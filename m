Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263615AbUECJ1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263615AbUECJ1l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 05:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbUECJ1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 05:27:41 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:46798 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263615AbUECJ0x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 05:26:53 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.273
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_May__3_09_26_45_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040503092645.5D376AD820@merlin.emma.line.org>
Date: Mon,  3 May 2004 11:26:45 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.273 has been released.

This script is used by Linus and Marcelo to rearrange and reformat BK
ChangeSet logs into a more human-readable format, and the official
repository is Parent repository is http://bktools.bkbits.net/bktools

As the script has grown large, this mail only contains a diff against
the last released version.

You can always download the full script and GPG signatures from
http://home.pages.de/~mandree/linux/kernel/

My thanks go to Vitezslav Samel who has spent a lot of time on digging
out the real names for addresses sending in BK ChangeSets.

Note that your mailer must be MIME-capable to save this mail properly,
because it is in the "quoted-printable" encoding.

= <- if you see just an equality sign, but no "3D", your mailer is fine.
= <- if you see 3D on this line, then upgrade your mailer or pipe this mail
= <- into metamail.

-- 
A sh script on behalf of Matthias Andree
-------------------------------------------------------------------------
Changes since last release:

----------------------------
revision 0.273
date: 2004/05/03 09:05:17;  author: vita;  state: Exp;  lines: +6 -1
5 new addresses
----------------------------
revision 0.272
date: 2004/05/01 14:57:38;  author: emma;  state: Exp;  lines: +1 -2
Fix merge error, remove duplicate address.
----------------------------
revision 0.271
date: 2004/05/01 14:52:38;  author: emma;  state: Exp;  lines: +3 -1
one new address
----------------------------
revision 0.270
date: 2004/04/28 08:02:55;  author: vita;  state: Exp;  lines: +3 -1
merge 2 addresses from Linus' tree
----------------------------
revision 0.269
date: 2004/04/27 10:06:48;  author: vita;  state: Exp;  lines: +5 -1
4 new addresses
----------------------------
revision 0.268
date: 2004/04/26 08:22:39;  author: vita;  state: Exp;  lines: +32 -1
31 new addresses (most from the could-be-added list)
----------------------------
revision 0.267
date: 2004/04/22 13:52:21;  author: vita;  state: Exp;  lines: +16 -5
11 new addresses and 3 corrections
----------------------------
revision 0.266
date: 2004/04/20 11:20:46;  author: emma;  state: Exp;  lines: +3 -1
Two more mappings.
----------------------------
revision 0.265
date: 2004/04/20 11:13:21;  author: emma;  state: Exp;  lines: +6 -1
Five new address mappings.
----------------------------
revision 0.264
date: 2004/04/16 12:52:38;  author: vita;  state: Exp;  lines: +29 -1
merge Linus' additions
----------------------------
revision 0.263
date: 2004/04/15 08:37:42;  author: vita;  state: Exp;  lines: +3 -1
add "Gude Analog- und Digitalsysteme GmbH" addresses
----------------------------
revision 0.262
date: 2004/04/15 07:42:30;  author: emma;  state: Exp;  lines: +4 -1
Add 3 addresses.
----------------------------
revision 0.261
date: 2004/04/15 07:34:56;  author: vita;  state: Exp;  lines: +18 -1
17 new addresses
----------------------------
revision 0.260
date: 2004/04/15 02:24:00;  author: emma;  state: Exp;  lines: +4 -1
Merge three addresses from Linus.
----------------------------
revision 0.259
date: 2004/04/02 13:07:50;  author: vita;  state: Exp;  lines: +3 -1
2 new addresses
----------------------------
revision 0.258
date: 2004/04/01 21:48:00;  author: emma;  state: Exp;  lines: +9 -3
If a From: header contains a known address, use the known name instead of the
name from the From: line, so as to have consistent names that can be grouped.
This fixes a report by Vita:
Maximilian Attems:
  o [NETFILTER]: Add MODULE_AUTHOR to ipchains_core.c

maximilian attems:
  o add warning to DocBook/Makefile
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.258
diff -u -r0.258 lk-changelog.pl
--- lk-changelog.pl	1 Apr 2004 21:48:00 -0000	0.258
+++ lk-changelog.pl	3 May 2004 09:22:12 -0000
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.258 2004/04/01 21:48:00 emma Exp $
+# $Id: lk-changelog.pl,v 0.273 2004/05/03 09:05:17 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -136,6 +136,7 @@
 my %addresses = (
 '_nessuno_:katamail.com' => 'Davide Andrian',
 'a.kasparas:gmc.lt' => 'Aidas Kasparas',
+'a.othieno:bluewin.ch' => 'Arthur Othieno',
 'a.othieno:ch.rmk.(none)' => 'Arthur Othieno',
 'a.wegele:tu-bs.de' => 'Artur Wegele',
 'aaron.baranoff:tsc.tdk.com' => 'Aaron Baranoff',
@@ -154,6 +155,7 @@
 'acme:dhcp197.conectiva' => 'Arnaldo Carvalho de Melo',
 'acme:parisc.kerneljanitors.org' => 'Arnaldo Carvalho de Melo',
 'acurtis:onz.com' => 'Allen Curtis',
+'adam:evdebs.org' => 'Adam Goode',
 'adam:kroptech.com' => 'Adam Kropelin',
 'adam:mailhost.nmt.edu' => 'Adam Radford', # google
 'adam:nmt.edu' => 'Adam Radford', # google
@@ -165,6 +167,7 @@
 'adi:drcomp.erfurt.thur.de' => 'Adrian Knoth',
 'adilger:clusterfs.com' => 'Andreas Dilger',
 'adobriyan:mail.ru' => 'Alexey Dobriyan',
+'adrian:humboldt.co.uk' => 'Adrian Cox',
 'adsharma:unix-os.sc.intel.com' => 'Arun Sharma',
 'aebr:win.tue.nl' => 'Andries E. Brouwer',
 'agrover:acpi3.(none)' => 'Andy Grover',
@@ -179,6 +182,7 @@
 'aia21:cantab.net' => 'Anton Altaparmakov',
 'aia21:cus.cam.ac.uk' => 'Anton Altaparmakov',
 'aia21:drop.stormcorp.org' => 'Anton Altaparmakov', # guessed
+'aj:andaco.de' => 'Andreas Jochens',
 'ajm:sgi.com' => 'Alan Mayer',
 'ajoshi:kernel.crashing.org' => 'Ani Joshi',
 'ajoshi:shell.unixbox.com' => 'Ani Joshi',
@@ -192,6 +196,7 @@
 'akpm:reardensteel.com' => 'Andrew Morton',
 'akpm:zip.com.au' => 'Andrew Morton',
 'akropel1:rochester.rr.com' => 'Adam Kropelin', # lbdb
+'alain.knaff:lll.lu' => 'Alain Knaff',
 'alain:linux.lu' => 'Alain Knaff',
 'alan:lxorguk.ukuu.org.uk' => 'Alan Cox',
 'alan:redhat.com' => 'Alan Cox',
@@ -199,6 +204,7 @@
 'albert:users.sourceforge.net' => 'Albert Cahalan',
 'albertogli:telpin.com.ar' => 'Alberto Bertogli',
 'alborchers:steinerpoint.com' => 'Al Borchers',
+'alessandro.zummo:towertech.it' => 'Alessandro Zummo',
 'alex.williamson:hp.com' => 'Alex Williamson',
 'alex:de.rmk.(none)' => 'Alexander Schulz',
 'alex:ssi.bg' => 'Alexander Atanasov',
@@ -208,6 +214,7 @@
 'alexander.riesen:synopsys.com' => 'Alexander Riesen',
 'alexander.schulz:com.rmk.(none)' => 'Alexander Schulz',
 'alexander.schulz:innominate.com' => 'Alexander Schulz',
+'alexander.stohr:gmx.de' => 'Alexander Stohr',
 'alexander:all-2.com' => 'Alexander Oltu',
 'alexey:technomagesinc.com' => 'Alex Tomas',
 'alext:fc.hp.com' => 'Alex Tsariounov',
@@ -225,6 +232,7 @@
 'andikies:t-online.de' => 'Andreas Kies',
 'andmike:us.ibm.com' => 'Mike Anderson', # lbdb
 'andre.breiler:null-mx.org' => 'André Breiler',
+'andre:linux-ide.org' => 'Andre Hedrick',
 'andrea:suse.de' => 'Andrea Arcangeli',
 'andrew.grover:intel.com' => 'Andy Grover', # "Andy" to match former entries
 'andrew.vasquez:qlogic.com' => 'Andrew Vasquez',
@@ -232,6 +240,7 @@
 'andrew:com.rmk.(none)' => 'Andrew Victor', # double-check
 'andries.brouwer:cwi.nl' => 'Andries E. Brouwer',
 'andros:citi.umich.edu' => 'Andy Adamson',
+'andyw:uk.ibm.com' => 'Andy Whitcroft',
 'angus.sawyer:dsl.pipex.com' => 'Angus Sawyer',
 'ankry:green.mif.pg.gda.pl' => 'Andrzej Krzysztofowicz',
 'anton:samba.org' => 'Anton Blanchard',
@@ -240,6 +249,7 @@
 'aoliva:redhat.com' => 'Alexandre Oliva',
 'ap:cipherica.com' => 'Alex Pankratov',
 'apolkosnik:directvinternet.com' => 'Adam Polkosnik',
+'apw:shadowen.org' => 'Andy Whitcroft',
 'arashi:yomerashi.yi.org' => 'Matt Reppert',
 'arekm:pld-linux.org' => 'Arkadiusz Miskiewicz', # lbdb
 'arief_m_utama:telkomsel.co.id' => 'Arief Mulya Utama',
@@ -282,6 +292,7 @@
 'bart.de.schuymer:pandora.be' => 'Bart De Schuymer',
 'bart:samwel.tk' => 'Bart Samwel',
 'bbosch:iphase.com' => 'Bradley A. Bosch',
+'bbuesker:qualcomm.com' => 'Brian Buesker',
 'bcollins:debian.org' => 'Ben Collins',
 'bcrl:bob.home.kvack.org' => 'Benjamin LaHaise',
 'bcrl:redhat.com' => 'Benjamin LaHaise',
@@ -291,6 +302,7 @@
 'bdschuym:pandora.be' => 'Bart De Schuymer',
 'beattie:beattie-home.net' => 'Brian Beattie', # from david.nelson
 'bellucda:tiscali.it' => 'Daniele Bellucci',
+'ben-linux:org.rmk.(none)' => 'Ben Dooks',
 'bengen:hilluzination.de' => 'Hilko Bengen',
 'benh:kernel.crashing.org' => 'Benjamin Herrenschmidt',
 'benh:zion.wanadoo.fr' => 'Benjamin Herrenschmidt',
@@ -304,6 +316,7 @@
 'bero:arklinux.org' => 'Bernhard Rosenkraenzer',
 'bfennema:falcon.csc.calpoly.edu' => 'Ben Fennema',
 'bfields:citi.umich.edu' => 'J. Bruce Fields',
+'bfields:fieldses.org' => 'J. Bruce Fields',
 'bgerst:didntduck.org' => 'Brian Gerst',
 'bhards:bigpond.net.au' => 'Brad Hards',
 'bhavesh:avaya.com' => 'Bhavesh P. Davda',
@@ -361,6 +374,7 @@
 'ch:com.rmk.(none)' => 'Christopher Hoover',
 'ch:hpl.hp.com' => 'Christopher Hoover', # by Kristian Peters
 'ch:murgatroid.com' => 'Christopher Hoover',
+'chaapala:cisco.com' => 'Clay Haapala',
 'chad_smith:hp.com' => 'Chad Smith',
 'chadt:sgi.com' => 'Chad Talbott',
 'chan:aleph1.co.uk' => 'Tak-Shing Chan',
@@ -370,6 +384,7 @@
 'chip:pobox.com' => 'Chip Salzenberg', # lbdb
 'chris:qwirx.com' => 'Chris Wilson',
 'chris:wirex.com' => 'Chris Wright',
+'chrisl:vmware.com' => 'Christopher Li',
 'christer:weinigel.se' => 'Christer Weinigel', # from shortlog
 'christophe:saout.de' => 'Christophe Saout',
 'christopher.leech:intel.com' => 'Christopher Leech',
@@ -389,13 +404,16 @@
 'cminyard:mvista.com' => 'Corey Minyard',
 'cniehaus:handhelds.org' => 'Carsten Niehaus',
 'cobra:compuserve.com' => 'Kevin Brosius',
+'colin:colino.net' => 'Colin Leroy',
 'colin:gibbs.dhs.org' => 'Colin Gibbs',
 'colin:gibbsonline.net' => 'Colin Gibbs', # whois
 'colpatch:us.ibm.com' => 'Matthew Dobson',
 'corbet:lwn.net' => 'Jonathan Corbet',
+'coreyed:linxtechnologies.com' => 'Corey Edwards',
 'corryk:us.ibm.com' => 'Kevin Corry',
 'cort:fsmlabs.com' => 'Cort Dougan',
 'coughlan:redhat.com' => 'Tom Coughlan',
+'coywolf:greatcn.org' => 'Coywolf Qi Hunt',
 'cpg:puchol.com' => 'Carlos Puchol',
 'cph:zurich.ai.mit.edu' => 'Chris Hanson',
 'cr:sap.com' => 'Christoph Rohland',
@@ -412,6 +430,7 @@
 'd.mueller:elsoft.ch' => 'David Müller',
 'd3august:dtek.chalmers.se' => 'Björn Augustsson',
 'da-x:gmx.net' => 'Dan Aloni',
+'dainis_jonitis:exigengroup.lv' => 'Dainis Jonitis',
 'daisy:teetime.dynamic.austin.ibm.com' => 'Daisy Chang', # from shortlog
 'dale.farnsworth:mvista.com' => 'Dale Farnsworth',
 'dale:farnsworth.org' => 'Dale Farnsworth',
@@ -468,6 +487,7 @@
 'ddstreet:us.ibm.com' => 'Dan Streetman',
 'dean:arctic.org' => 'Dean Gaudet',
 'debian:abeckmann.de' => 'Andreas Beckmann',
+'deepfire:sic-elvis.zel.ru' => 'Samium Gromoff',
 'defouwj:purdue.edu' => 'Jeff DeFouw',
 'deller:gmx.de' => 'Helge Deller',
 'dent:cosy.sbg.ac.at' => "Thomas 'Dent' Mirlacher",
@@ -514,11 +534,13 @@
 'dsaxena:mvista.com' => 'Deepak Saxena',
 'dsaxena:net.rmk.(none)' => 'Deepak Saxena',
 'dsaxena:plexity.net' => 'Deepak Saxena',
+'dsd:gentoo.org' => 'Daniel Drake',
 'dsteklof:us.ibm.com' => 'Daniel E. F. Stekloff',
 'dth:dth.net' => 'Danny ter Haar', # guessed
 'dtor_core:ameritech.net' => 'Dmitry Torokhov',
 'ducrot:poupinou.org' => 'Bruno Ducrot',
 'duncan.sands:math.u-psud.fr' => 'Duncan Sands',
+'dvrabel:com.rmk.(none)' => 'David Vrabel',
 'dwmw2:dwmw2.baythorne.internal' => 'David Woodhouse',
 'dwmw2:infradead.org' => 'David Woodhouse',
 'dwmw2:redhat.com' => 'David Woodhouse',
@@ -527,6 +549,7 @@
 'ebrower:resilience.com' => 'Eric Brower',
 'ebrower:usa.net' => 'Eric Brower',
 'ebs:ebshome.net' => 'Eugene Surovegin',
+'ecashin:uga.edu' => 'Ed L Cashin',
 'ecd:skynet.be' => 'Eddie C. Dost',
 'eddie.williams:steeleye.com' => 'Eddie Williams',
 'edv:macrolink.com' => 'Ed Vance',
@@ -556,6 +579,7 @@
 'eric:lammerts.org' => 'Eric Lammerts',
 'erik:aarg.net' => 'Erik Arneson',
 'erik:harddisk-recovery.nl' => 'Erik Mouw',
+'erik:rigtorp.com' => 'Erik Rigtorp',
 'erik_habbinga:hp.com' => 'Erik Habbinga',
 'erikj:subway.americas.sgi.com' => 'Erik Jacobson',
 'erlend-a:us.his.no' => 'Erlend Aasland',
@@ -563,8 +587,11 @@
 'ernstp:mac.com' => 'Ernst Persson', # lbdb
 'eugene.teo:eugeneteo.net' => 'Eugene Teo',
 'eugeneteo:eugeneteo.net' => 'Eugene Teo',
+'evan.felix:pnl.gov' => 'Evan Felix',
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
+'fabian.frederick:skynet.be' => 'Fabian Frederick',
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
+'faith:redhat.com' => 'Rik Faith',
 'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hüffner',
 'fb.arm:net.rmk.(none)' => 'Frank Becker',
 'fbecker:com.rmk.(none)' => 'Frank Becker',
@@ -590,6 +617,7 @@
 'francis.wiran:hp.com' => 'Francis Wiran',
 'franz.sirl-kernel:lauterbach.com' => 'Franz Sirl',
 'franz.sirl:lauterbach.com' => 'Franz Sirl',
+'frederik.deweerdt:laposte.net' => 'Frederik Deweerdt',
 'frival:zk3.dec.com' => 'Peter Rival',
 'fscked:netvisao.pt' => 'Paulo André',
 'fubar:us.ibm.com' => 'Jay Vosburgh',
@@ -599,6 +627,7 @@
 'galak:blarg.somerset.sps.mot.com' => 'Kumar Gala',
 'ganadist:nakyup.mizi.com' => 'Cha Young-Ho',
 'gandalf:netfilter.org' => 'Martin Josefsson',
+'gandalf:winds.org' => 'Byron Stanoszek',
 'gandalf:wlug.westbo.se' => 'Martin Josefsson',
 'ganesh.venkatesan:intel.com' => 'Ganesh Venkatesan',
 'ganesh:tuxtop.vxindia.veritas.com' => 'Ganesh Varadarajan',
@@ -607,9 +636,11 @@
 'garloff:suse.de' => 'Kurt Garloff',
 'garyhade:us.ibm.com' => 'Gary Hade',
 'gbarzini:virata.com' => 'Guido Barzini',
+'geert.uytterhoeven:sonycom.com' => 'Geert Uytterhoeven',
 'geert:linux-m68k.org' => 'Geert Uytterhoeven',
 'george:mvista.com' => 'George Anzinger',
 'georgn:somanetworks.com' => 'Georg Nikodym',
+'gerald.schaefer:gmx.net' => 'Gerald Schaefer',
 'gerg:moreton.com.au' => 'Greg Ungerer',
 'gerg:snapgear.com' => 'Greg Ungerer',
 'ghoz:sympatico.ca' => 'Ghozlane Toumi',
@@ -679,6 +710,7 @@
 'herbert:13thfloor.at' => 'Herbert Pötzl', # lbdb
 'herbert:gondor.apana.org.au' => 'Herbert Xu',
 'hermes:gibson.dropbear.id.au' => 'David Gibson',
+'hero:persua.de' => 'Heiko Ronsdorf',
 'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
 'hjm:redhat.com' => 'Heinz Mauelshagen', # lbdb
 'hoho:binbash.net' => 'Colin Slater',
@@ -687,6 +719,7 @@
 'horms:verge.net.au' => 'Simon Horman',
 'hpa:transmeta.com' => 'H. Peter Anvin',
 'hpa:zytor.com' => 'H. Peter Anvin',
+'hugh:com.rmk.(none)' => 'Hugh Dickins',
 'hugh:veritas.com' => 'Hugh Dickins',
 'hunold:convergence.de' => 'Michael Hunold',
 'hunold:linuxtv.org' => 'Michael Hunold',
@@ -698,10 +731,12 @@
 'icampbell:com.rmk.(none)' => 'Ian Campbell',
 'ilmari:ilmari.org' => 'Dagfinn Ilmari Mannsåker',
 'inaky.perez-gonzalez:intel.com' => 'Iñaky Pérez-González', # LK 20030829
+'info:gudeads.com' => 'Gude Analog- und Digitalsysteme GmbH',
 'info:usblcd.de' => 'Adams IT Services',
 'ink:jurassic.park.msu.ru' => 'Ivan Kokshaysky',
 'ink:ru.rmk.(none)' => 'Ivan Kokshaysky',
 'ink:undisclosed.(none)' => 'Ivan Kokshaysky',
+'ioanamitu:yahoo.com' => 'Carl Spalletta',
 'iod00d:hp.com' => 'Grant Grundler', # lbdb
 'ionut:badula.org' => 'Ion Badulescu',
 'ionut:cs.columbia.edu' => 'Ion Badulescu',
@@ -731,6 +766,7 @@
 'jamey:crl.dec.com' => 'Jamey Hicks',
 'jamie:shareable.org' => 'Jamie Lokier',
 'jan.oravec:6com.sk' => 'Jan Oravec',
+'jan:ccsinfo.com' => 'Jan Capek',
 'jan:zuchhold.com' => 'Jan Zuchhold',
 'janetmor:us.ibm.com' => 'Janet Morgan',
 'jani:astechnix.ro' => 'Jani Monoses',
@@ -762,6 +798,8 @@
 'jef:linuxbe.org' => 'Jean-Francois Dive',
 'jeff.wiedemeier:hp.com' => 'Jeff Wiedemeier',
 'jeffm:suse.com' => 'Jeff Mahoney',
+'jeffm:suse.de' => 'Jeff Mahoney',
+'jeffpc:optonline.net' => 'Josef \'Jeff\' Sipek',
 'jeffs:accelent.com' => 'Jeff Sutherland', # lbdb
 'jejb:fuzzy.(none)' => 'James Bottomley',
 'jejb:jet.(none)' => 'James Bottomley', # wild guess
@@ -795,7 +833,10 @@
 'jholmes:psu.edu' => 'Jason Holmes',
 'jiho:c-zone.net' => 'Jim Howard',
 'jim.houston:attbi.com' => 'Jim Houston',
+'jim.houston:comcast.net' => 'Jim Houston',
+'jk:ozlabs.org' => 'Jeremy Kerr',
 'jkenisto:us.ibm.com' => 'James Keniston',
+'jkmaline:cc.hut.fi' => 'Jouni Malinen',
 'jkt:helius.com' => 'Jack Thomasson',
 'jlcooke:certainkey.com' => 'Jean-Luc Cooke',
 'jmcmullan:linuxcare.com' => 'Jason McMullan',
@@ -806,9 +847,11 @@
 'jo-lkml:suckfuell.net' => 'Jochen Suckfuell',
 'jochen:jochen.org' => 'Jochen Hein',
 'jochen:scram.de' => 'Jochen Friedrich',
+'joe.korty:ccur.com' => 'Joe Korty',
 'joe:fib011235813.fsnet.co.uk' => 'Joe Thornber',
 'joe:perches.com' => 'Joe Perches',
 'joe:wavicle.org' => 'Joe Burks',
+'joel.becker:oracle.com' => 'Joel Becker',
 'joel.buckley:sun.com' => 'Joel Buckley',
 'joergprante:netcologne.de' => 'Jörg Prante',
 'joern:infradead.org' => 'Jörn Engel',
@@ -817,6 +860,8 @@
 'johann.deneux:it.uu.se' => 'Johann Deneux',
 'johann.deneux:laposte.net' => 'Johann Deneux',
 'johannes:erdfelt.com' => 'Johannes Erdfelt',
+'john.cagle:hp.com' => 'John Cagle',
+'john.l.byrne:hp.com' => 'John L. Byrne',
 'john:deater.net' => 'John Clemens',
 'john:fremlin.de' => 'John Fremlin',
 'john:grabjohn.com' => 'John Bradford',
@@ -833,6 +878,8 @@
 'joris:struyve.be' => 'Joris Struyve',
 'josh:joshisanerd.com' => 'Josh Myer',
 'jparadis:redhat.com' => 'Jim Paradis',
+'jrsantos:austin.ibm.com' => 'Jose R. Santos',
+'jschopp:austin.ibm.com' => 'Joel Schopp',
 'jsiemes:web.de' => 'Josef Siemes',
 'jsimmons:heisenberg.transvirtual.com' => 'James Simmons',
 'jsimmons:infradead.org' => 'James Simmons',
@@ -891,10 +938,13 @@
 'khali:linux-fr.org' => 'Jean Delvare', # lbdb
 'khalid:fc.hp.com' => 'Khalid Aziz',
 'khalid_aziz:hp.com' => 'Khalid Aziz',
+'khawar.chaudhry:amd.com' => 'Khawar Chaudhry',
 'khc:pc.waw.pl' => 'Krzysztof Halasa',
 'khc:pm.waw.pl' => 'Krzysztof Halasa',
 'kieran:mgpenguin.net' => 'Kieran Morrissey',
+'kingsley:aurema.com' => 'Cheung Kingsley',
 'kiran:in.ibm.com' => 'Ravikiran G. Thirumalai',
+'kirillx:7ka.mipt.ru' => 'Kirill Korotaev',
 'kisza:sch.bme.hu' => 'Andras Kis-Szabo', # google (netfilter-ext HOWTO)
 'kkeil:isdn4linux.de' => 'Karsten Keil',
 'kkeil:suse.de' => 'Karsten Keil',
@@ -952,7 +1002,9 @@
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
 'liam.girdwood:wolfsonmicro.com' => 'Liam Girdwood',
+'linas:austin.ibm.com' => 'Linas Vepstas',
 'linas:us.ibm.com' => 'Linas Vepstas',
+'linux-kernel:n-dimensional.de' => 'Hans Ulrich Niedermann',
 'linux-usb:gemeinhardt.info' => 'Lars Gemeinhardt',
 'linux:brodo.de' => 'Dominik Brodowski',
 'linux:de.rmk.(none)' => 'Dominik Brodowski',
@@ -966,11 +1018,13 @@
 'livio:ime.usp.br' => 'Livio Baldini Soares',
 'liyang:nerv.cx' => 'Liyang Hu',
 'lkml001:vrfy.org' => 'Kay Sievers',
+'lkml:lievin.net' => 'Romain Liévin',
 'lkml:mathfillsmewithgreatjoy.com' => 'Michael Plump',
 'lkml:shemesh.biz' => 'Shachar Shemesh',
 'lm:bitmover.com' => 'Larry McVoy',
 'lm:work.bitmover.com' => 'Larry McVoy',
 'lode_leroy:hotmail.com' => 'Lode Leroy',
+'loftin:ldl.fc.hp.com' => 'Terry Loftin',
 'lopezp:grupocp.es' => 'Jose A. Lopez',
 'lord:jen.americas.sgi.com' => 'Stephen Lord',
 'lord:laptop.americas' => 'Stephen Lord',
@@ -986,9 +1040,11 @@
 'luca:libero.it' => 'Luca Risolia',
 'lucasvr:terra.com.br' => 'Lucas Correia Villa Real', # google
 'lunz:falooley.org' => 'Jason Lunz',
+'luto:myrealbox.com' => 'Andy Lutomirski',
 'lxiep:linux.ibm.com' => 'Linda Xie',
 'lxiep:ltcfwd.linux.ibm.com' => 'Linda Xie',
 'lxiep:us.ibm.com' => 'Linda Xie',
+'m.c.p:kernel.linux-systeme.com' => 'Marc-Christian Petersen',
 'm.c.p:wolk-project.de' => 'Marc-Christian Petersen',
 'm:mbsks.franken.de' => 'Matthias Bruestle',
 'maalanen:ra.abo.fi' => 'Marcus Alanen',
@@ -997,7 +1053,10 @@
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
 'maeda.naoaki:jp.fujitsu.com' => 'Maeda Naoaki',
 'mail:de.rmk.(none)' => 'Peter Teichmann',
+'mail:gude.info' => 'Gude Analog- und Digitalsysteme GmbH',
+'mail:s-holst.de' => 'Stefan Holst',
 'makisara:abies.metla.fi' => 'Kai Mäkisara',
+'makovick:kmlinux.fjfi.cvut.cz' => 'Jindrich Makovicka',
 'maloi:phota.to' => 'Andy Molloy',
 'malte.d:gmx.net' => 'Malte Doersam', # google
 'manand:us.ibm.com' => 'Mala Anand',
@@ -1032,6 +1091,7 @@
 'marr:flex.com' => 'Bill Marr',
 'martin.bene:icomedias.com' => 'Martin Bene',
 'martin.bligh:us.ibm.com' => 'Martin J. Bligh',
+'martin.lubich:gmx.at' => 'Martin Lubich',
 'martin.schwidefsky:debitel.net' => 'Martin Schwidefsky',
 'martin:bruli.net' => 'Martin Brulisauer',
 'martin:mdiehl.de' => 'Martin Diehl',
@@ -1039,6 +1099,7 @@
 'martine.silbermann:hp.com' => 'Martine Silbermann',
 'masanari.iida:hp.com' => 'Masanari Iida', # lbdb
 'masbock:us.ibm.com' => 'Max Asbock',
+'maschaffner:gmx.ch' => 'Martin Schaffner',
 'mashirle:us.ibm.com' => 'Shirley Ma',
 'mason:suse.com' => 'Chris Mason',
 'mathieu:newview.com' => 'Mathieu Chouquet-Stringer',
@@ -1054,8 +1115,10 @@
 'mb:ozaba.mine.nu' => 'Magnus Boden',
 'mbligh:aracnet.com' => 'Martin J. Bligh',
 'mbp:samba.org' => 'Martin Pool', # lbdb
+'mbp:vexed.ozlabs.hp.com' => 'Martin Pool',
 'mcgrof:ruslug.rutgers.edu' => 'Luis R. Rodriguez',
 'mcgrof:studorgs.rutgers.edu' => 'Luis R. Rodriguez',
+'mchan:broadcom.com' => 'Michael Chan',
 'mcp:linux-systeme.de' => 'Marc-Christian Petersen',
 'mdharm-scsi:one-eyed-alien.net' => 'Matthew Dharm',
 'mdharm-usb:one-eyed-alien.net' => 'Matthew Dharm',
@@ -1063,15 +1126,20 @@
 'mdiehl:mdiehl.de' => 'Martin Diehl',
 'mdomsch:dell.com' => 'Matt Domsch', # lbdb
 'mds:paradyne.com' => 'Mark D. Studebaker',
+'mebrown:michaels-house.net' => 'Michael E. Brown',
 'mec:shout.net' => 'Michael Elizabeth Chastain',
 'meissner:suse.de' => 'Marcus Meissner',
+'metolent:snoqualmie.dp.intel.com' => 'Matt Tolentino',
 'mfedyk:matchmail.com' => 'Mike Fedyk',
 'mgalgoci:redhat.com' => 'Matthew Galgoci',
 'mgreer:mivsta.com' => 'Mark A. Greer', # typo
 'mgreer:mvista.com' => 'Mark A. Greer', # lbdb
+'mhf:linuxmail.org' => 'Michael Frank',
 'mhoffman:lightlink.com' => 'Mark M. Hoffman',
 'mhopf:innominate.com' => 'Mark-André Hopf',
 'michael.krauth:web.de' => 'Michael Krauth',
+'michael.veeck:gmx.net' => 'Michael Veeck',
+'michael.waychison:sun.com' => 'Mike Waychison',
 'michael:metaparadigm.com' => 'Michael Clark',
 'michael_e_brown:dell.com' => 'Michael E. Brown', # lbdb
 'michaelc:cs.wisc.edu' => 'Mike Christie', # lbdb
@@ -1079,6 +1147,7 @@
 'michal:harddata.com' => 'Michal Jaegermann',
 'michal:logix.cz' => 'Michal Ludvig',
 'michal_dobrzynski:mac.com' => 'Michal Dobrzynski',
+'michel.marti:objectxp.com' => 'Michel Marti',
 'michel:daenzer.net' => 'Michel Dänzer',
 'miguel:cetuc.puc-rio.br' => 'Miguel Freitas', # lbdb
 'mikael.starvik:axis.com' => 'Mikael Starvik',
@@ -1099,6 +1168,7 @@
 'mingo:elte.hu' => 'Ingo Molnar',
 'mingo:redhat.com' => 'Ingo Molnar',
 'minyard:acm.org' => 'Corey Minyard',
+'miquels:cistron.nl' => 'Miquel van Smoorenburg',
 'mirage:kaotik.org' => 'Tiago Sousa',
 'mitch:sfgoth.com' => 'Mitchell Blank Jr.',
 'miura:da-cha.org' => 'Hiroshi Miura',
@@ -1115,6 +1185,7 @@
 'mmagallo:debian.org' => 'Marcelo E. Magallon',
 'mmcclell:bigfoot.com' => 'Mark McClelland',
 'mochel:bambi.(none)' => 'Patrick Mochel',
+'mochel:digitalimplant.org' => 'Patrick Mochel',
 'mochel:geena.pdx.osdl.net' => 'Patrick Mochel',
 'mochel:hera.kernel.org' => 'Patrick Mochel',
 'mochel:kernel.bkbits.net' => 'Patrick Mochel',
@@ -1146,14 +1217,18 @@
 'mzyngier:freesurf.fr' => 'Marc Zyngier',
 'n0ano:n0ano.com' => 'Don Dugger',
 'nahshon:actcom.co.il' => 'Itai Nahshon',
+'nakam:linux-ipv6.org' => 'Masahide Nakamura',
+'nathanl:austin.ibm.com' => 'Nathan Lynch',
 'nathans:bruce.melbourne.sgi.com' => 'Nathan Scott',
 'nathans:sgi.com' => 'Nathan Scott',
 'naveenb:cisco.com' => 'Naveen Burmi', # lbdb
+'ncunningham:users.sourceforge.net' => 'Nigel Cunningham',
 'neilb:cse.unsw.edu.au' => 'Neil Brown',
 'neilt:slimy.greenend.org.uk' => 'Neil Turton',
 'nemosoft:smcc.demon.nl' => 'Nemosoft Unv.',
 'netfilter:interlinx.bc.ca' => 'Brian J. Murrell',
 'nick.holloway:pyrites.org.uk' => 'Nick Holloway',
+'nickpiggin:yahoo.com.au' => 'Nick Piggin',
 'nico:cam.org' => 'Nicolas Pitre',
 'nico:org.rmk' => 'Nicolas Pitre',
 'nico:org.rmk.(none)' => 'Nicolas Pitre',
@@ -1161,7 +1236,9 @@
 'nicolas.mailhot:laposte.net' => 'Nicolas Mailhot',
 'nicolas:dupeux.net' => 'Nicolas Dupeux',
 'nikai:nikai.net' => 'Nicolas Kaiser',
+'nikita:namesys.com' => 'Nikita Danilov',
 'nikkne:hotpop.com' => 'Nikola Knezevic',
+'niraj17:iitbombay.org' => 'Niraj Kumar',
 'nitin.a.kamble:intel.com' => 'Nitin A. Kamble',
 'niv:us.ibm.com' => 'Nivedita Singhvi',
 'nivedita:w-nivedita.beaverton.ibm.com' => 'Nivedita Singhvi',
@@ -1180,6 +1257,7 @@
 'ogasawara:osdl.org' => 'Leann Ogasawara',
 'okir:suse.de' => 'Olaf Kirch', # lbdb
 'okurth:gmx.net' => 'Oliver Kurth',
+'olaf.boehm:lanner.de' => 'Olaf Boehm',
 'olaf.dietsche#list.linux-kernel:t-online.de' => 'Olaf Dietsche',
 'oleg:tv-sign.ru' => 'Oleg Nesterov',
 'olh:suse.de' => 'Olaf Hering',
@@ -1191,6 +1269,7 @@
 'oliver:oenone.homelinux.org' => 'Oliver Neukum',
 'oliver:vermuden.neukum.org' => 'Oliver Neukum',
 'olof:austin.ibm.com' => 'Olof Johansson',
+'omkhar:rogers.com' => 'Omkhar Arasaratnam',
 'orjan.friberg:axis.com' => 'Orjan Friberg',
 'os:emlix.com' => 'Oskar Schirmer', # sent by himself
 'osst:riede.org' => 'Willem Riede',
@@ -1208,7 +1287,9 @@
 'patch:luckynet.dynu.com' => '"Lightweight Patch Manager"', # lbdb
 'patmans:ibm.com' => 'Patrick Mansfield',
 'patmans:us.ibm.com' => 'Patrick Mansfield',
+'patrick.boettcher:desy.de' => 'Patrick Boettcher',
 'patrick:dreker.de' => 'Patrick Dreker', # lbdb
+'patrick:wildi.com' => 'Patrick Wildi',
 'paubert:iram.es' => 'Gabriel Paubert',
 'paul.clements:steeleye.com' => 'Paul Clements',
 'paul.mundt:timesys.com' => 'Paul Mundt', # google
@@ -1216,6 +1297,7 @@
 'paul:wagland.net' => 'Paul Wagland', # lbdb
 'paulkf:microgate.com' => 'Paul Fulghum',
 'paulm:routefree.com' => 'Paul Mielke',
+'paulmck:us.ibm.com' => 'Paul E. McKenney',
 'paulus:au1.ibm.com' => 'Paul Mackerras',
 'paulus:cargo.(none)' => 'Paul Mackerras',
 'paulus:nanango.paulus.ozlabs.org' => 'Paul Mackerras',
@@ -1236,9 +1318,11 @@
 'pebl:math.ku.dk' => 'Peter Berg Larsen',
 'pee:erkkila.org' => 'Paul E. Erkkila',
 'pekon:informatics.muni.cz' => 'Petr Konecny',
+'pepinto:student.dei.uc.pt' => 'Pedro Emanuel M. D. Pinto',
 'per.winkvist:telia.com' => 'Per Winkvist',
 'per.winkvist:uk.com' => 'Per Winkvist',
 'perex:perex.cz' => 'Jaroslav Kysela',
+'perex:petra.perex-int.cz' => 'Jaroslav Kysela', # guessed
 'perex:pnote.perex-int.cz' => 'Jaroslav Kysela',
 'perex:suse.cz' => 'Jaroslav Kysela',
 'perrye:linuxmail.org' => 'Perry Gilfillan', # lbdb
@@ -1260,6 +1344,7 @@
 'petkan:users.sourceforge.net' => 'Petko Manolov',
 'petr:scssoft.com' => 'Petr Sebor',
 'petr:vandrovec.name' => 'Petr Vandrovec',
+'petri.koistinen:fi.rmk.(none)' => 'Petri Koistinen',
 'petri.koistinen:iki.fi' => 'Petri Koistinen',
 'petrides:redhat.com' => 'Ernie Petrides',
 'pfg:sgi.com' => 'Pat Gefre',
@@ -1269,6 +1354,7 @@
 'philipp:void.at' => 'Philipp Friedrich',
 'phillim2:comcast.net' => 'Mike Phillips',
 'piggin:cyberone.com.au' => 'Nick Piggin',
+'piggy:timesys.com' => 'La Monte H.P. Yarroll',
 'pixi:burble.org' => 'Maurice S. Barnum',
 'pj:sgi.com' => 'Paul Jackson',
 'pkot:linuxnews.pl' => 'Pawel Kot',
@@ -1299,6 +1385,7 @@
 'quintela:mandrakesoft.com' => 'Juan Quintela',
 'r.a.mercer:blueyonder.co.uk' => 'Adam Mercer',
 'r.e.wolff:bitwizard.nl' => 'Rogier Wolff', # lbdb
+'r.s.bultje:students.uu.nl' => 'Ronald S. Bultje',
 'ralf:dea.linux-mips.net' => 'Ralf Bächle',
 'ralf:linux-mips.org' => 'Ralf Bächle',
 'ralphs:org.rmk.(none)' => 'Ralph Siemsen',
@@ -1313,6 +1400,7 @@
 'rbt:mtlb.co.uk' => 'Robert Cardell',
 'rbultje:ronald.bitfreak.net' => 'Ronald Bultje',
 'rct:gherkin.frus.com' => 'Bob Tracy',
+'rddunlap:org.rmk.(none)' => 'Randy Dunlap',
 'rddunlap:osdl.org' => 'Randy Dunlap',
 'reality:delusion.de' => 'Udo A. Steinberg',
 'redbliss:libero.it' => 'Leopoldo Cerbaro',
@@ -1336,8 +1424,9 @@
 'riel:surriel.com' => 'Rik van Riel',
 'rjweryk:uwo.ca' => 'Rob Weryk',
 'rl:hellgate.ch' => 'Roger Luethi',
-'rlievin:free.fr' => 'Romain Lievin',
+'rlievin:free.fr' => 'Romain Liévin',
 'rmk+lkml:arm.linux.org.uk' => 'Russell King',
+'rmk+pcmcia:arm.linux.org.uk' => 'Russell King',
 'rmk-pci:arm.linux.org.uk' => 'Russell King',
 'rmk:arm.linux.org.uk' => 'Russell King',
 'rmk:flint.arm.linux.org.uk' => 'Russell King',
@@ -1357,8 +1446,10 @@
 'roland:frob.com' => 'Roland McGrath',
 'roland:redhat.com' => 'Roland McGrath',
 'roland:topspin.com' => 'Roland Dreier',
-'romain.lievin:esisar.inpg.fr' => 'Romain Lievin',
-'romain.lievin:wanadoo.fr' => 'Romain Lievin',
+'romain.lievin:esisar.inpg.fr' => 'Romain Liévin',
+'romain.lievin:wanadoo.fr' => 'Romain Liévin',
+'romain:lievin.net' => 'Romain Liévin',
+'romain:orebokech.com' => 'Romain Francoise',
 'romieu:cogenit.fr' => 'François Romieu',
 'romieu:fr.zoreil.com' => 'François Romieu',
 'root:viper.(none)' => 'Maxim Krasnyansky',
@@ -1369,6 +1460,7 @@
 'rth:dot.sfbay.redhat.com' => 'Richard Henderson',
 'rth:eeyore.twiddle.net' => 'Richard Henderson',
 'rth:fidel.sfbay.redhat.com' => 'Richard Henderson',
+'rth:heffalump.twiddle.home' => 'Richard Henderson',
 'rth:kanga.(none)' => 'Richard Henderson',
 'rth:kanga.twiddle.home' => 'Richard Henderson',
 'rth:kanga.twiddle.net' => 'Richard Henderson',
@@ -1381,9 +1473,11 @@
 'russell_d_cagle:mindspring.com' => 'Russell Cagle', # google
 'rusty:linux.co.intel.com' => 'Rusty Lynch',
 'rusty:rustcorp.com.au' => 'Rusty Russell',
+'rvinson:linuxbox.(none)' => 'Randy Vinson',
 'rvinson:mvista.com' => 'Randy Vinson',
 'rwhron:earthlink.net' => 'Randy Hron',
 'rwhron:net.rmk.(none)' => 'Randy Hron',
+'ryan:michonline.com' => 'Ryan Anderson',
 'rz:linux-m68k.org' => 'Richard Zidlicky',
 's.doyon:videotron.ca' => 'Stéphane Doyon',
 'sabala:students.uiuc.edu' => 'Michal Sabala', # google
@@ -1409,10 +1503,12 @@
 'schwab:suse.de' => 'Andreas Schwab',
 'schwidefsky:de.ibm.com' => 'Martin Schwidefsky',
 'scole:zianet.com' => 'Steven Cole', # lk, Alan Cox 20030904
+'scott.bailey:eds.com' => 'Scott Bailey',
 'scott.feldman:intel.com' => 'Scott Feldman',
 'scott_anderson:mvista.com' => 'Scott Anderson',
 'scottm:minion.yyz.somanetworks.com' => 'Scott Murray',
 'scottm:somanetworks.com' => 'Scott Murray',
+'scriptkiddie:wp.pl' => 'Marek Szuba',
 'sct:redhat.com' => 'Stephen C. Tweedie',
 'sdake:mvista.com' => 'Steven Dake',
 'sds:epoch.ncsc.mil' => 'Stephen D. Smalley',
@@ -1422,6 +1518,7 @@
 'sebastian.droege:gmx.de' => 'Sebastian Dröge',
 'sebek64:post.cz' => 'Marcel Sebek',
 'set:pobox.com' => 'Paul Thompson',
+'sezero:superonline.com' => 'Özkan Sezer',
 'sfbest:us.ibm.com' => 'Steve Best',
 'sfr:au1.ibm.com' => 'Stephen Rothwell',
 'sfr:canb.auug.org.au' => 'Stephen Rothwell',
@@ -1455,6 +1552,7 @@
 'solt:dns.toxicfilms.tv' => 'Maciej Soltysiak',
 'soruk:eridani.co.uk' => 'Michael McConnell',
 'sparker:sun.com' => 'Steven Parker', # by Duncan Laurie
+'sparse:chrisli.org' => 'Christopher Li',
 'sprite:sprite.fr.eu.org' => 'Jeremie Koenig',
 'spse:secret.org.uk' => 'Simon Evans', # by Kristian Peters
 'spyro:com.rmk.(none)' => 'Ian Molton',
@@ -1484,19 +1582,25 @@
 'steve:kbuxd.necst.nec.co.jp' => 'Steve Baur',
 'steve:navaho.co.uk' => 'Steve Hill',
 'steved:redhat.com' => 'Steve Dickson',
+'stevef:linux-udp14619769uds.austin.ibm.com' => 'Steve French',
 'stevef:linux.local' => 'Steve French', # guessed
+'stevef:smfhome.smfdom' => 'Steve French',
+'stevef:smfhome.smfsambadom' => 'Steve French',
 'stevef:smfhome1.austin.rr.com' => 'Steve French',
 'stevef:smfhome2.austin.rr.com' => 'Steve French',
 'stevef:stevef95.austin.ibm.com' => 'Steve French',
 'stevef:steveft21.austin.ibm.com' => 'Steve French',
 'stevef:steveft21.ltcsamba' => 'Steve French',
 'stewart:inverse.wetlogic.net' => 'Paul Stewart',
+'stewart:linux.org.au' => 'Stewart Smith',
 'stewart:wetlogic.net' => 'Paul Stewart',
+'strosake:us.ibm.com' => 'Michael Strosaker',
 'stuart_hayes:dell.com' => 'Stuart Hayes',
 'stuartm:connecttech.com' => 'Stuart MacDonald',
 'sullivan:austin.ibm.com' => 'Mike Sullivan',
 'suncobalt.adm:hostme.bitkeeper.com' => 'Tim Hockin', # by Duncan Laurie
 'sunil.saxena:intel.com' => 'Sunil Saxena',
+'suparna:in.ibm.com' => 'Suparna Bhattacharya',
 'suresh.b.siddha:intel.com' => 'Suresh B. Siddha',
 'sv:sw.com.sg' => 'Vladimir Simonov',
 'svm:kozmix.org' => 'Sander van Malssen',
@@ -1509,6 +1613,7 @@
 't-kouchi:mvf.biglobe.ne.jp' => 'Takayoshi Kouchi',
 'tai:imasy.or.jp' => 'Taisuke Yamada',
 'taka:valinux.co.jp' => 'Hirokazu Takahashi',
+'takamiya:po.ntts.co.jp' => 'Noriaki Takamiya',
 'tao:acc.umu.se' => 'David Weinehall', # by himself
 'tao:kernel.org' => 'David Weinehall', # by himself
 'tapio:iptime.fi' => 'Tapio Laxström',
@@ -1529,6 +1634,7 @@
 'thoffman:arnor.net' => 'Torrey Hoffman',
 'thomas:bender.thinknerd.de' => 'Thomas Walpuski',
 'thomas:habets.pp.se' => 'Thomas Habets',
+'thomas:horsten.com' => 'Thomas Horsten',
 'thomas:osterried.de' => 'Thomas Osterried',
 'thomas:stewarts.org.uk' => 'Thomas Stewart',
 'thomas:winischhofer.net' => 'Thomas Winischhofer', # whois
@@ -1544,9 +1650,11 @@
 'tinglett:vnet.ibm.com' => 'Todd Inglett',
 'tiwai:suse.de' => 'Takashi Iwai',
 'tlnguyen:snoqualmie.dp.intel.com' => 'Tom L. Nguyen',
+'tmattox:engr.uky.edu' => 'Tim Mattox',
 'tmcreynolds:nvidia.com' => 'Tom McReynolds',
 'tmolina:cablespeed.com' => 'Thomas Molina',
 'tmolina:cox.net' => 'Thomas Molina',
+'tom.l.nguyen:intel.com' => 'Nguyen, Tom L',
 'tomita:cinet.co.jp' => 'Osamu Tomita',
 'toml:us.ibm.com' => 'Tom Lendacky',
 'tomlins:cam.org' => 'Ed Tomlinson',
@@ -1554,10 +1662,12 @@
 'tommy:home.tig-grr.com' => 'Tom Marshall',
 'tony.luck:intel.com' => 'Tony Luck',
 'tony:atomide.com' => 'Tony Lindgren',
+'tony:bakeyournoodle.com' => 'Tony Breeds',
 'tony:cantech.net.au' => 'Anthony J. Breeds-Taurima',
 'tony:com.rmk.(none)' => 'Tony Lindgren',
 'tonyb:cybernetics.com' => 'Tony Battersby',
 'torben.mathiasen:hp.com' => 'Torben Mathiasen',
+'torque:ukrpost.net' => 'Yury Umanets',
 'torvalds:linux.local' => 'Linus Torvalds',
 'trevor.pering:intel.com' => 'Trevor Pering',
 'trini:bill-the-cat.bloom.county' => 'Tom Rini',
@@ -1580,8 +1690,10 @@
 'tytso:snap.thunk.org' => "Theodore Y. T'so",
 'tytso:think.thunk.org' => "Theodore Y. T'so", # guessed
 'u233:shaw.ca' => 'Trent Whaley',
+'uaca:alumni.uv.es' => 'Ulisses Alonso Camaró',
 'urban.widmark:enlight.net' => 'Urban Widmark',
 'urban:teststation.com' => 'Urban Widmark',
+'uwe.koziolek:gmx.net' => 'Uwe Koziolek',
 'uzi:uzix.org' => 'Joshua Uziel',
 'valdis.kletnieks:vt.edu' => 'Valdis Kletnieks',
 'valko:linux.karinthy.hu' => 'Laszlo Valko',
@@ -1590,10 +1702,12 @@
 'varenet:parisc-linux.org' => 'Thibaut Varene',
 'vatsa:in.ibm.com' => 'Srivatsa Vaddagiri',
 'vberon:mecano.gme.usherb.ca' => 'Vincent Béron',
+'vda:port.imtp.ilyichevsk.odessa.ua' => 'Denis Vlasenko',
 'venkatesh.pallipadi:intel.com' => 'Venkatesh Pallipadi',
 'vherva:niksula.hut.fi' => 'Ville Herva',
 'vinay-rc:naturesoft.net' => 'Vinay K. Nallamothu',
 'vinay.nallamothu:gsecone.com' => 'Vinay K. Nallamothu',
+'vince:kyllikki.org' => 'Vincent Sanders',
 'vinsci:floss.(none)' => 'Leonard Norrgard',
 'viro:math.psu.edu' => 'Alexander Viro',
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
@@ -1624,6 +1738,7 @@
 'weicht:in.tum.de' => 'Thomas Weich',
 'weigand:immd1.informatik.uni-erlangen.de' => 'Ulrich Weigand',
 'weihs:linux1394.org' => 'Manfred Weihs',
+'wellnhofer:aevum.de' => 'Nick Wellnhofer',
 'wensong:linux-vs.org' => 'Wensong Zhang',
 'wes:infosink.com' => 'Wes Schreiner',
 'wesolows:foobazco.org' => 'Keith M. Wesolowski',
@@ -1654,6 +1769,7 @@
 'xavier.bru:bull.net' => 'Xavier Bru',
 'xkaspa06:stud.fee.vutbr.cz' => 'Tomas Kasparek',
 'xose:wanadoo.es' => 'Xose Vazquez Perez', # lbdb
+'xschmi00:stud.feec.vutbr.cz' => 'Michal Schmidt',
 'y.rutschle:com.rmk.(none)' => 'Yves Rutschle',
 'ya:slamail.org' => 'Yaacov Akiba Slama',
 'yasuyuki.kozakai:toshiba.co.jp' => 'Yasuyuki Kozakai',

