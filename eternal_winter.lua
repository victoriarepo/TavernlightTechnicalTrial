-- spells.xml
--	<instant group="attack" spellid="118" name="Eternal Winter" words="frigo" level="0" mana="0" premium="0" selftarget="0" cooldown="0"
--		groupcooldown="4000" needlearn="0" script="attack/eternal_winter.lua">
--		<vocation name="Druid" />
--		<vocation name="Elder Druid" />
--		<vocation name="Paladin" />
--	</instant>
-- I modified an existing spell which already had the right graphics to get a quite demo running
-- Set level=0, mana=0, premium=0, cooldown=0 and shortened the words to "frigo"

-- Set up the earea I wanted the effect to cover
AREA_3X4 = {
	{0, 0, 0, 1, 1, 0, 0, 0},
	{0, 0, 1, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 3, 3, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 1, 0, 0},
	{0, 0, 0, 1, 1, 0, 0, 0}
}

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
combat:setArea(createCombatArea(AREA_3X4))

function onGetFormulaValues(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 5.5) + 25
	local max = (level / 5) + (magicLevel * 11) + 50
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
