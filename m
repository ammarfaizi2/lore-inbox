Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263987AbTD0NNC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 09:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263988AbTD0NNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 09:13:02 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:62737 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263987AbTD0NMz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 09:12:55 -0400
MIME-Version: 1.0
To: torvalds@transmeta.com
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sun_Apr_27_13_24_52_UTC_2003_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20030427132452.0C9FA84479@merlin.emma.line.org>
Date: Sun, 27 Apr 2003 15:24:52 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use bk receive to patch this mail, you can pull from
bk://krusty.dt.e-technik.uni-dortmund.de  (NOTE: no trailing slash)
or you can apply the patch below.

Patch description:
More addresses for the shortlog script.

PLEASE MERGE, I MAY ABANDON THE PROJECT OTHERWISE.

Matthias
##### DIFFSTAT #####
# shortlog |   76 +++++++++++++++++++++++++++++++++++++++++--
# 1 files changed, 74 insertions(+), 2 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.49    -> 1.50   
#	            shortlog	1.23    -> 1.24   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/04/27	matthias.andree@gmx.de	1.50
# Add 33 more address -> name mappings.
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Sun Apr 27 15:24:51 2003
+++ b/shortlog	Sun Apr 27 15:24:51 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.96 2003/04/13 10:46:57 emma Exp $
+# $Id: lk-changelog.pl,v 0.104 2003/04/27 13:18:46 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -88,6 +88,20 @@
 #
 # Unless otherwise noted, the addresses below have been obtained using
 # lbdb.
+my @addresses_handled_in_regexp = (
+'alan:hraefn.swansea.linux.org.uk' => 'Alan Cox',
+'alan:irongate.swansea.linux.org.uk' => 'Alan Cox',
+'torvalds:athlon.transmeta.com' => 'Linus Torvalds',
+'torvalds:home.transmeta.com' => 'Linus Torvalds',
+'torvalds:kiwi.transmeta.com' => 'Linus Torvalds',
+'torvalds:penguin.transmeta.com' => 'Linus Torvalds',
+'torvalds:tove.transmeta.com' => 'Linus Torvalds',
+'torvalds:transmeta.com' => 'Linus Torvalds',
+'###############################' => '###############'
+);
+
+undef @addresses_handled_in_regexp;
+
 my %addresses = (
 'aaron.baranoff:tsc.tdk.com' => 'Aaron Baranoff',
 'abraham:2d3d.co.za' => 'Abraham van der Merwe',
@@ -130,6 +144,7 @@
 'akropel1:rochester.rr.com' => 'Adam Kropelin', # lbdb
 'alan:lxorguk.ukuu.org.uk' => 'Alan Cox',
 'alan:redhat.com' => 'Alan Cox',
+'alborchers:steinerpoint.com' => 'Al Borchers',
 'alex:ssi.bg' => 'Alexander Atanasov',
 'alex_williamson:attbi.com' => 'Alex Williamson', # lbdb
 'alex_williamson:hp.com' => 'Alex Williamson', # google
@@ -153,6 +168,7 @@
 'anton:superego.(none)' => 'Anton Blanchard',
 'anton:superego.ozlabs.ibm.com' => 'Anton Blanchard',
 'apolkosnik:directvinternet.com' => 'Adam Polkosnik',
+'arashi:yomerashi.yi.org' => 'Matt Reppert',
 'aris:cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
 'arjan:redhat.com' => 'Arjan van de Ven',
 'arjanv:redhat.com' => 'Arjan van de Ven',
@@ -160,6 +176,7 @@
 'arnd:arndb.de' => 'Arnd Bergmann',
 'arnd:bergmann-dalldorf.de' => 'Arnd Bergmann',
 'arndb:de.ibm.com' => 'Arnd Bergmann',
+'arndt:lin02384n012.mc.schoenewald.de' => 'Arndt Schoenewald',
 'arun.sharma:intel.com' => 'Arun Sharma',
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
 'asl:launay.org' => 'Arnaud S. Launay',
@@ -185,6 +202,7 @@
 'beattie:beattie-home.net' => 'Brian Beattie', # from david.nelson
 'benh:kernel.crashing.org' => 'Benjamin Herrenschmidt',
 'benh:zion.wanadoo.fr' => 'Benjamin Herrenschmidt',
+'bergner:cannon.rchland.ibm.com' => 'Peter Bergner',
 'bergner:vnet.ibm.com' => 'Peter Bergner',
 'berny.f:aon.at' => 'Bernhard Fischer',
 'bero:arklinux.org' => 'Bernhard Rosenkraenzer',
@@ -206,6 +224,7 @@
 'brihall:pcisys.net' => 'Brian Hall', # google
 'brm:murphy.dk' => 'Brian Murphy',
 'brownfld:irridia.com' => 'Ken Brownfield',
+'bryder:paradise.net.nz' => 'Bill Ryder',
 'bunk:fs.tum.de' => 'Adrian Bunk',
 'buytenh:gnu.org' => 'Lennert Buytenhek',
 'bwa:us.ibm.com' => 'Bruce Allan',
@@ -222,6 +241,7 @@
 'ccaputo:alt.net' => 'Chris Caputo',
 'cel:citi.umich.edu' => 'Chuck Lever',
 'celso:bulma.net' => 'Celso González', # google
+'ch:com.rmk.(none)' => 'Christopher Hoover',
 'ch:hpl.hp.com' => 'Christopher Hoover', # by Kristian Peters
 'ch:murgatroid.com' => 'Christopher Hoover',
 'chan:aleph1.co.uk' => 'Tak-Shing Chan',
@@ -239,6 +259,7 @@
 'clemens:ladisch.de' => 'Clemens Ladisch',
 'cloos:jhcloos.com' => 'James H. Cloos Jr.',
 'cloos:lugabout.jhcloos.org' => 'James H. Cloos Jr.',
+'cmayor:ca.rmk.(none)' => 'Cam Mayor',
 'cminyard:mvista.com' => 'Corey Minyard',
 'cniehaus:handhelds.org' => 'Carsten Niehaus',
 'cobra:compuserve.com' => 'Kevin Brosius',
@@ -312,6 +333,7 @@
 'dhowells:redhat.com' => 'David Howells',
 'dilinger:mp3revolution.net' => 'Andres Salomon',
 'dipankar:in.ibm.com' => 'Dipankar Sarma',
+'dirk.behme:com.rmk.(none)' => 'Dirk Behme',
 'dirk.behme:de.bosch.com' => 'Dirk Behme',
 'dirk.uffmann:nokia.com' => 'Dirk Uffmann',
 'dkuhlen:fhm.edu' => 'Dominik Kuhlen',
@@ -341,9 +363,12 @@
 'edv:macrolink.com' => 'Ed Vance',
 'edward_peng:dlink.com.tw' => 'Edward Peng',
 'efocht:ess.nec.de' => 'Erich Focht',
+'ehabkost:conectiva.com.br' => 'Eduardo Pereira Habkost',
 'eike-kernel:sf-tec.de' => 'Rolf Eike Beer', # sent by himself
 'eike:bilbo.math.uni-mannheim.de' => 'Rolf Eike Beer',
+'elenstev:com.rmk.(none)' => 'Steven Cole',
 'elenstev:mesatop.com' => 'Steven Cole',
+'eli.carter:com.rmk.(none)' => 'Eli Carter',
 'eli.kupermann:intel.com' => 'Eli Kupermann',
 'engebret:us.ibm.com' => 'Dave Engebretsen',
 'eranian:frankl.hpl.hp.com' => 'Stéphane Eranian',
@@ -376,6 +401,7 @@
 'fw:deneb.enyo.de' => 'Florian Weimer', # lbdb
 'fzago:austin.rr.com' => 'Frank Zago', # google
 'ganadist:nakyup.mizi.com' => 'Cha Young-Ho',
+'gandalf:netfilter.org' => 'Martin Josefsson',
 'gandalf:wlug.westbo.se' => 'Martin Josefsson',
 'ganesh:tuxtop.vxindia.veritas.com' => 'Ganesh Varadarajan',
 'ganesh:veritas.com' => 'Ganesh Varadarajan',
@@ -396,7 +422,7 @@
 'glee:gnupilgrims.org' => 'Geoffrey Lee', # lbdb
 'gnb:alphalink.com.au' => 'Greg Banks',
 'go:turbolinux.co.jp' => 'Go Taniguchi',
-'gone:us.ibm.com' => 'Patricia Guaghen',
+'gone:us.ibm.com' => 'Patricia Gaughen',
 'gotom:debian.or.jp' => 'Goto Masanori', # from shortlog
 'gphat:cafes.net' => 'Cory Watson',
 'greearb:candelatech.com' => 'Ben Greear',
@@ -465,11 +491,13 @@
 'jamie:shareable.org' => 'Jamie Lokier',
 'jani:astechnix.ro' => 'Jani Monoses',
 'jani:iv.ro' => 'Jani Monoses',
+'javaman:katamail.com' => 'Paulo Ornati',
 'jb:jblache.org' => 'Julien Blache',
 'jbarnes:sgi.com' => 'Jesse Barnes',
 'jbglaw:lug-owl.de' => 'Jan-Benedict Glaw',
 'jblack:linuxguru.net' => 'James Blackwell',
 'jbm:joshisanerd.com' => 'Josh Myer',
+'jcdutton:users.sourceforge.net' => 'James Courtier-Dutton',
 'jdavid:farfalle.com' => 'David Ruggiero',
 'jdike:jdike.wstearns.org' => 'Jeff Dike',
 'jdike:karaya.com' => 'Jeff Dike',
@@ -487,6 +515,7 @@
 'jes:trained-monkey.org' => 'Jes Sorensen',
 'jes:wildopensource.com' => 'Jes Sorensen',
 'jgarzik:fokker2.devel.redhat.com' => 'Jeff Garzik',
+'jgarzik:hum.(none)' => 'Jeff Garzik',
 'jgarzik:mandrakesoft.com' => 'Jeff Garzik',
 'jgarzik:pobox.com' => 'Jeff Garzik',
 'jgarzik:redhat.com' => 'Jeff Garzik',
@@ -531,6 +560,7 @@
 'jsimmons:maxwell.earthlink.net' => 'James Simmons',
 'jsimmons:transvirtual.com' => 'James Simmons',
 'jsm:udlkern.fc.hp.com' => 'John Marvin',
+'jsun:mvista.com' => 'Jun Sun',
 'jt:bougret.hpl.hp.com' => 'Jean Tourrilhes',
 'jt:hpl.hp.com' => 'Jean Tourrilhes',
 'jtyner:cs.ucr.edu' => 'John Tyner',
@@ -592,6 +622,7 @@
 'ldb:ldb.ods.org' => 'Luca Barbieri',
 'ldm:flatcap.org' => 'Richard Russon',
 'lee:compucrew.com' => 'Lee Nash', # lbdb
+'legoll:free.fr' => 'Vince Hodges',
 'leigh:solinno.co.uk' => 'Leigh Brown', # lbdb
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
@@ -689,9 +720,11 @@
 'mochel:osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdlab.org' => 'Patrick Mochel',
+'mort:wildopensource.com' => 'Martin Hicks',
 'mostrows:speakeasy.net' => 'Michal Ostrowski',
 'mostrows:watson.ibm.com' => 'Michal Ostrowski',
 'mporter:cox.net' => 'Matt Porter',
+'mrr:nexthop.com' => 'Mathew Richardson',
 'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
 'msw:redhat.com' => 'Matt Wilson',
 'mufasa:sis.com.tw' => 'Mufasa Yang', # sent by himself
@@ -708,6 +741,7 @@
 'netfilter:interlinx.bc.ca' => 'Brian J. Murrell',
 'nick.holloway:pyrites.org.uk' => 'Nick Holloway',
 'nico:cam.org' => 'Nicolas Pitre',
+'nico:org.rmk.(none)' => 'Nicolas Pitre',
 'nicolas.aspert:epfl.ch' => 'Nicolas Aspert',
 'nicolas.mailhot:laposte.net' => 'Nicolas Mailhot',
 'niv:us.ibm.com' => 'Nivedita Singhvi',
@@ -787,6 +821,7 @@
 'porter:cox.net' => 'Matt Porter',
 'prom:berlin.ccc.de' => 'Ingo Albrecht',
 'proski:gnu.org' => 'Pavel Roskin',
+'proski:org.rmk.(none)' => 'Pavel Roskin',
 'pwaechtler:mac.com' => 'Peter Wächtler',
 'quinlan:transmeta.com' => 'Daniel Quinlan',
 'quintela:mandrakesoft.com' => 'Juan Quintela',
@@ -814,6 +849,8 @@
 'richard.brunner:amd.com' => 'Richard Brunner',
 'riel:conectiva.com.br' => 'Rik van Riel',
 'riel:imladris.surriel.com' => 'Rik van Riel',
+'riel:redhat.com' => 'Rik van Riel',
+'riel:surriel.com' => 'Rik van Riel',
 'rjweryk:uwo.ca' => 'Rob Weryk',
 'rl:hellgate.ch' => 'Roger Luethi',
 'rlievin:free.fr' => 'Romain Lievin',
@@ -829,6 +866,7 @@
 'roland:redhat.com' => 'Roland McGrath',
 'roland:topspin.com' => 'Roland Dreier',
 'romain.lievin:esisar.inpg.fr' => 'Romain Lievin',
+'romain.lievin:wanadoo.fr' => 'Romain Lievin',
 'romieu:cogenit.fr' => 'François Romieu',
 'romieu:fr.zoreil.com' => 'François Romieu',
 'root:viper.(none)' => 'Maxim Krasnyansky',
@@ -860,6 +898,7 @@
 'sarolaht:cs.helsinki.fi' => 'Pasi Sarolahti',
 'sawa:yamamoto.gr.jp' => 'sawa',
 'scameron:quandary.cca.cpqcorp.net' => 'Steve Cameron',
+'schlicht:uni-mannheim.de' => 'Thomas Schlichter',
 'schoenfr:gaaertner.de' => 'Erik Schoenfelder',
 'schwab:suse.de' => 'Andreas Schwab',
 'schwidefsky:de.ibm.com' => 'Martin Schwidefsky',
@@ -886,9 +925,11 @@
 'smurf:osdl.org' => 'Nathan Dabney',
 'snailtalk:linux-mandrake.com' => 'Geoffrey Lee', # by himself
 'solar:openwall.com' => 'Solar Designer',
+'soruk:eridani.co.uk' => 'Michael McConnell',
 'sparker:sun.com' => 'Steven Parker', # by Duncan Laurie
 'sprite:sprite.fr.eu.org' => 'Jeremie Koenig',
 'spse:secret.org.uk' => 'Simon Evans', # by Kristian Peters
+'spyro:com.rmk.(none)' => 'Ian Molton',
 'src:flint.arm.linux.org.uk' => 'Russell King',
 'sri:us.ibm.com' => 'Sridhar Samudrala',
 'sridhar:dyn9-47-18-140.beaverton.ibm.com' => 'Sridhar Samudrala',
@@ -917,7 +958,9 @@
 'suncobalt.adm:hostme.bitkeeper.com' => 'Tim Hockin', # by Duncan Laurie
 'sunil.saxena:intel.com' => 'Sunil Saxena',
 'suresh.b.siddha:intel.com' => 'Suresh B. Siddha',
+'sv:sw.com.sg' => 'Vladimir Simonov',
 'swanson:uklinux.net' => 'Alan Swanson',
+'swiergot:intersec.pl' => 'Jaroslaw Swierczynski',
 'szepe:pinerecords.com' => 'Tomas Szepe',
 't-kouchi:mvf.biglobe.ne.jp' => 'Takayoshi Kouchi',
 'tai:imasy.or.jp' => 'Taisuke Yamada',
@@ -925,6 +968,7 @@
 'tao:acc.umu.se' => 'David Weinehall', # by himself
 'tao:kernel.org' => 'David Weinehall', # by himself
 'tapio:iptime.fi' => 'Tapio Laxström',
+'tausq:debian.org' => 'Randolph Chung',
 'tcallawa:redhat.com' => "Tom 'spot' Callaway",
 'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
 'th122948:scl1.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
@@ -979,8 +1023,10 @@
 'wd:denx.de' => 'Wolfgang Denk',
 'weigand:immd1.informatik.uni-erlangen.de' => 'Ulrich Weigand',
 'wes:infosink.com' => 'Wes Schreiner',
+'wesolows:foobazco.org' => 'Keith M. Wesolowski',
 'wg:malloc.de' => 'Wolfram Gloger', # lbdb
 'whitney:math.berkeley.edu' => 'Wayne Whitney',
+'whydoubt:yahoo.com' => 'Jeff Smith',
 'will:sowerbutts.com' => 'William R. Sowerbutts',
 'willy:debian.org' => 'Matthew Wilcox',
 'willy:fc.hp.com' => 'Matthew Wilcox',
@@ -990,6 +1036,7 @@
 'wli:holomorphy.com' => 'William Lee Irwin III',
 'wolfgang.fritz:gmx.net' => 'Wolfgang Fritz', # by Kristian Peters
 'wolfgang:iksw-muees.de' => 'Wolfgang Muees',
+'wolfgang:top.mynetix.de' => 'Wolfgang Mauerer',
 'wriede:riede.org' => 'Willem Riede',
 'wrlk:riede.org' => 'Willem Riede',
 'wstinson:infonie.fr' => 'William Stinson',
@@ -1595,6 +1642,31 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.104  2003/04/27 13:18:46  emma
+# Add two more addresses.
+#
+# Revision 0.103  2003/04/24 09:20:31  vita
+# added 2 names for new addresses
+#
+# Revision 0.102  2003/04/23 12:39:05  vita
+# added 9 names for new addresses
+#
+# Revision 0.101  2003/04/18 11:43:22  vita
+# added 8 names for new addresses
+#
+# Revision 0.100  2003/04/17 10:25:19  vita
+# added 3 names for new addresses
+#
+# Revision 0.99  2003/04/16 08:17:49  vita
+# added 9 names for new addresses
+#
+# Revision 0.98  2003/04/14 15:47:56  emma
+# Doing Zack Brown a favor and archiving addresses that are now handled by regexps
+# in a separate list.
+#
+# Revision 0.97  2003/04/13 11:33:27  emma
+# Correct Patricia Gaughen's name (was Gua...). Found by Geoffrey Lee.
+#
 # Revision 0.96  2003/04/13 10:46:57  emma
 # 100 (one hundred) new addresses and 17 corrections by Zack Brown.
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.50
## Wrapped with gzip_uu ##


begin 600 bkpatch24288
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
.<`=DWG\`@1OPFG\0````
`
end

