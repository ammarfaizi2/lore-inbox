Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbUB2Vou (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 16:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbUB2Vou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 16:44:50 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:48593 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262158AbUB2VoQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 16:44:16 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.235
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sun_Feb_29_21_44_12_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040229214412.92781AA9DF@merlin.emma.line.org>
Date: Sun, 29 Feb 2004 22:44:12 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.235 has been released.

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
revision 0.235
date: 2004/02/29 21:42:46;  author: emma;  state: Exp;  lines: +15 -2
Merge BK <-> CVS changes.
----------------------------
revision 0.234
date: 2004/02/25 14:14:53;  author: vita;  state: Exp;  lines: +22 -1
21 new addresses
----------------------------
revision 0.233
date: 2004/02/17 12:30:07;  author: emma;  state: Exp;  lines: +3 -1
Two new addresses.
----------------------------
revision 0.232
date: 2004/02/11 14:17:23;  author: vita;  state: Exp;  lines: +12 -1
merge Linus' additions; add few more addresses
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.232
retrieving revision 0.235
diff -u -r0.232 -r0.235
--- lk-changelog.pl	11 Feb 2004 14:17:23 -0000	0.232
+++ lk-changelog.pl	29 Feb 2004 21:42:46 -0000	0.235
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.232 2004/02/11 14:17:23 vita Exp $
+# $Id: lk-changelog.pl,v 0.235 2004/02/29 21:42:46 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -227,6 +227,7 @@
 'anton:samba.org' => 'Anton Blanchard',
 'anton:superego.(none)' => 'Anton Blanchard',
 'anton:superego.ozlabs.ibm.com' => 'Anton Blanchard',
+'aoliva:redhat.com' => 'Alexandre Oliva',
 'ap:cipherica.com' => 'Alex Pankratov',
 'apolkosnik:directvinternet.com' => 'Adam Polkosnik',
 'arashi:yomerashi.yi.org' => 'Matt Reppert',
@@ -235,6 +236,7 @@
 'aris:cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
 'arjan:redhat.com' => 'Arjan van de Ven',
 'arjanv:redhat.com' => 'Arjan van de Ven',
+'armcc2000:com.rmk.(none)' => 'Andre',
 'armin:melware.de' => 'Armin Schindler',
 'arnaud.quette:mgeups.com' => 'Arnaud Quette',
 'arnd:arndb.de' => 'Arnd Bergmann',
@@ -308,8 +310,11 @@
 'boutcher:us.ibm.com' => 'Dave Boutcher',
 'braam:clusterfs.com' => 'Peter Braam',
 'brad:wasp.net.au' => 'Brad Campbell',
+'brazilnut:us.ibm.com' => 'Don Fry',
 'brett:bad-sports.com' => 'Brett Pemberton',
+'brian:rentec.com' => 'Brian Childs',
 'brihall:pcisys.net' => 'Brian Hall', # google
+'brking:us.ibm.com' => 'Brian King',
 'brm:murphy.dk' => 'Brian Murphy',
 'brownfld:irridia.com' => 'Ken Brownfield',
 'bryder:paradise.net.nz' => 'Bill Ryder',
@@ -374,6 +379,7 @@
 'corryk:us.ibm.com' => 'Kevin Corry',
 'cort:fsmlabs.com' => 'Cort Dougan',
 'coughlan:redhat.com' => 'Tom Coughlan',
+'cpg:puchol.com' => 'Carlos Puchol',
 'cph:zurich.ai.mit.edu' => 'Chris Hanson',
 'cr:sap.com' => 'Christoph Rohland',
 'craig:homerjay.homelinux.org' => 'Craig Wilkie',
@@ -474,6 +480,7 @@
 'dlstevens:us.ibm.com' => 'David Stevens',
 'dlsy:snoqualmie.dp.intel.com' => 'Dely Sy',
 'dmccr:us.ibm.com' => 'Dave McCracken',
+'dmilburn:redhat.com' => 'David Milburn',
 'dmo:osdl.org' => 'Dave Olien',
 'doj:cubic.org' => 'Dirk Jagdmann',
 'dok:directfb.org' => 'Denis Oliver Kropp',
@@ -487,6 +494,7 @@
 'dsaxena:com.rmk' => 'Deepak Saxena',
 'dsaxena:com.rmk.(none)' => 'Deepak Saxena',
 'dsaxena:mvista.com' => 'Deepak Saxena',
+'dsaxena:net.rmk.(none)' => 'Deepak Saxena',
 'dsaxena:plexity.net' => 'Deepak Saxena',
 'dsteklof:us.ibm.com' => 'Daniel E. F. Stekloff',
 'dth:dth.net' => 'Danny ter Haar', # guessed
@@ -588,6 +596,7 @@
 'gibbs:overdrive.btc.adaptec.com' => 'Justin T. Gibbs',
 'gibbs:scsiguy.com' => 'Justin T. Gibbs',
 'gilbertd:treblig.org' => 'Dr. David Alan Gilbert',
+'giuseppe.furlan:systeam.it' => 'Giuseppe Furlan',
 'gj:pointblue.com.pl' => 'Grzegorz Jaskiewicz',
 'gkernel.adm:hostme.bitkeeper.com' => 'Jeff Garzik', # himself
 'gl:dsa-ac.de' => 'Guennadi Liakhovetski',
@@ -652,6 +661,7 @@
 'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
 'hoho:binbash.net' => 'Colin Slater',
 'hollisb:us.ibm.com' => 'Hollis Blanchard',
+'horms:verge.net.au' => 'Simon Horman',
 'hpa:transmeta.com' => 'H. Peter Anvin',
 'hpa:zytor.com' => 'H. Peter Anvin',
 'hugh:veritas.com' => 'Hugh Dickins',
@@ -731,6 +741,7 @@
 'jejb:mulgrave.(none)' => 'James Bottomley', # from shortlog
 'jejb:raven.il.steeleye.com' => 'James Bottomley',
 'jenna.s.hall:intel.com' => 'Jenna S. Hall', # google
+'jeremy:sgi.com' => 'Jeremy Higdon',
 'jes:trained-monkey.org' => 'Jes Sorensen',
 'jes:wildopensource.com' => 'Jes Sorensen',
 'jet:gyve.org' => 'Masatake Yamato',
@@ -752,6 +763,7 @@
 'jh:sgi.com' => 'John Hesterberg',
 'jhammer:us.ibm.com' => 'Jack Hammer',
 'jhartmann:addoes.com' => 'Jeff Hartmann',
+'jhf:rivenstone.net' => 'Joseph Fannin',
 'jholmes:psu.edu' => 'Jason Holmes',
 'jiho:c-zone.net' => 'Jim Howard',
 'jim.houston:attbi.com' => 'Jim Houston',
@@ -789,6 +801,7 @@
 'jonsmirl:yahoo.com' => 'Jon Smirl',
 'joris:struyve.be' => 'Joris Struyve',
 'josh:joshisanerd.com' => 'Josh Myer',
+'jparadis:redhat.com' => 'Jim Paradis',
 'jsiemes:web.de' => 'Josef Siemes',
 'jsimmons:heisenberg.transvirtual.com' => 'James Simmons',
 'jsimmons:infradead.org' => 'James Simmons',
@@ -827,9 +840,11 @@
 'kare.sars:lmf.ericsson.se' => 'Kåre Särs',
 'karlis:mt.lv' => 'Karlis Peisenieks',
 'kartik_me:hotmail.com' => 'Kartikey Mahendra Bhatt',
+'kas:informatics.muni.cz' => 'Jan Kasprzak', # lbdb
 'kasperd:daimi.au.dk' => 'Kasper Dupont',
 'kaz:earth.email.ne.jp' => 'Kazuto Miyoshi',
 'kazunori:miyazawa.org' => 'Kazunori Miyazawa',
+'kberg:linux1394.org' => 'Steve Kinneberg',
 'keithu:parl.clemson.edu' => 'Keith Underwood',
 'kenneth.w.chen:intel.com' => 'Kenneth W. Chen',
 'kernel:jsl.com' => 'Jeffrey S. Laing',
@@ -886,6 +901,7 @@
 'ldl:aros.net' => 'Lou Langholtz',
 'ldm.adm:hostme.bitkeeper.com' => 'Patrick Mochel', # self
 'ldm:flatcap.org' => 'Richard Russon',
+'leachbj:bouncycastle.org' => 'Bernard Leach',
 'lee:compucrew.com' => 'Lee Nash', # lbdb
 'legoll:free.fr' => 'Vincent Legoll', # correction sent by himself
 'leigh:solinno.co.uk' => 'Leigh Brown', # lbdb
@@ -903,8 +919,10 @@
 'linux-usb:gemeinhardt.info' => 'Lars Gemeinhardt',
 'linux:brodo.de' => 'Dominik Brodowski',
 'linux:de.rmk.(none)' => 'Dominik Brodowski',
+'linux:de.rmk.(none2)' => 'Sebastian Henschel',
 'linux:dominikbrodowski.de' => 'Dominik Brodowski',
 'linux:hazard.jcu.cz' => 'Jan Marek',
+'linux:kodeaffe.de' => 'Sebastian Henschel',
 'linux:thorsten-knabe.de' => 'Thorsten Knabe',
 'lionel.bouton:inet6.fr' => 'Lionel Bouton',
 'lists:mdiehl.de' => 'Martin Diehl',
@@ -931,12 +949,15 @@
 'luca:libero.it' => 'Luca Risolia',
 'lucasvr:terra.com.br' => 'Lucas Correia Villa Real', # google
 'lunz:falooley.org' => 'Jason Lunz',
+'lxiep:linux.ibm.com' => 'Linda Xie',
 'lxiep:us.ibm.com' => 'Linda Xie',
 'm.c.p:wolk-project.de' => 'Marc-Christian Petersen',
 'm:mbsks.franken.de' => 'Matthias Bruestle',
 'maalanen:ra.abo.fi' => 'Marcus Alanen',
 'mac:melware.de' => 'Armin Schindler',
+'macro:ds2.pg.dga.pl' => 'Maciej W. Rozycki',
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
+'maeda.naoaki:jp.fujitsu.com' => 'MAEDA Naoaki',
 'mail:de.rmk.(none)' => 'Peter Teichmann',
 'makisara:abies.metla.fi' => 'Kai Mäkisara',
 'maloi:phota.to' => 'Andy Molloy',
@@ -966,6 +987,7 @@
 'mark.fasheh:oracle.com' => 'Mark Fasheh',
 'mark:alpha.dyndns.org' => 'Mark W. McClelland',
 'mark:hal9000.dyndns.org' => 'Mark W. McClelland',
+'mark:net.rmk.(none)' => 'Mark Hindley',
 'markh:osdl.org' => 'Mark Haverkamp',
 'markhe:veritas.com' => 'Mark Hemment',
 'marr:flex.com' => 'Bill Marr',
@@ -975,6 +997,7 @@
 'martin:bruli.net' => 'Martin Brulisauer',
 'martin:mdiehl.de' => 'Martin Diehl',
 'martin:meltin.net' => 'Martin Schwenke',
+'martine.silbermann:hp.com' => 'Martine Silbermann',
 'masanari.iida:hp.com' => 'Masanari Iida', # lbdb
 'mashirle:us.ibm.com' => 'Shirley Ma',
 'mason:suse.com' => 'Chris Mason',
@@ -1013,6 +1036,7 @@
 'michal:harddata.com' => 'Michal Jaegermann',
 'michal:logix.cz' => 'Michal Ludvig',
 'michel:daenzer.net' => 'Michel Dänzer',
+'miguel:cetuc.puc-rio.br' => 'Miguel Freitas', # lbdb
 'mikael.starvik:axis.com' => 'Mikael Starvik',
 'mikal:stillhq.com' => 'Michael Still',
 'mike.miller:hp.com' => 'Mike Miller',
@@ -1041,6 +1065,7 @@
 'mlang:delysid.org' => 'Mario Lang', # google
 'mlindner:syskonnect.de' => 'Mirko Lindner',
 'mlocke:mvista.com' => 'Montavista Software, Inc.',
+'mludvig:suse.cz' => 'Michal Ludvig',
 'mmagallo:debian.org' => 'Marcelo E. Magallon',
 'mmcclell:bigfoot.com' => 'Mark McClelland',
 'mochel:bambi.(none)' => 'Patrick Mochel',
@@ -1054,6 +1079,7 @@
 'moilanen:us.ibm.com' => 'Jake Moilanen',
 'mort:bork.org' => 'Martin Hicks',
 'mort:green.i.bork.org' => 'Martin Hicks',
+'mort:sgi.com' => 'Martin Hicks',
 'mort:wildopensource.com' => 'Martin Hicks',
 'mostrows:speakeasy.net' => 'Michal Ostrowski',
 'mostrows:watson.ibm.com' => 'Michal Ostrowski',
@@ -1186,6 +1212,7 @@
 'petri.koistinen:iki.fi' => 'Petri Koistinen',
 'petrides:redhat.com' => 'Ernie Petrides',
 'pfg:sgi.com' => 'Pat Gefre',
+'phil.el:wanadoo.fr' => 'Philippe Elie',
 'philipc:snapgear.com' => 'Philip Craig',
 'philipp:void.at' => 'Philipp Friedrich',
 'phillim2:comcast.net' => 'Mike Phillips',
@@ -1212,6 +1239,7 @@
 'purna:jcom.home.ne.jp' => 'Yusuf Wilajati Purna',
 'pwaechtler:mac.com' => 'Peter Wächtler',
 'q:kampsax.dtu.dk' => 'Dennis Jørgensen',
+'qboosh:pld-linux.org' => 'Jakub Bogusz',
 'qboosh:pld.org.pl' => 'Jakub Bogusz',
 'quade:hsnr.de' => 'Jürgen Quade',
 'quinlan:transmeta.com' => 'Daniel Quinlan',
@@ -1263,6 +1291,7 @@
 'rob:landley.net' => 'Rob Landley',
 'rob:osinvestor.com' => 'Rob Radez',
 'robert.olsson:data.slu.se' => 'Robert Olsson',
+'robert.picco:hp.com' => 'Robert Picco',
 'robin.farine:ch.rmk.(none)' => 'Robin Farine',
 'robn:verdi.et.tudelft.nl' => 'Rob van Nieuwkerk',
 'roehrich:sgi.com' => 'Dean Roehrich',
@@ -1310,6 +1339,7 @@
 'samuel.thibault:fnac.net' => 'Samuel Thibault', # lbdb
 'sandeen:sgi.com' => 'Eric Sandeen',
 'santiago:newphoenix.net' => 'Santiago A. Nullo', # sent by self
+'santil:us.ibm.com' => 'Santiago Leon',
 'sarolaht:cs.helsinki.fi' => 'Pasi Sarolahti',
 'sawa:yamamoto.gr.jp' => 'sawa',
 'scameron:quandary.cca.cpqcorp.net' => 'Steve Cameron',
@@ -1349,6 +1379,7 @@
 'shingchuang:via.com.tw' => 'Shing Chuang',
 'shmulik.hen:intel.com' => 'Shmulik Hen',
 'silicon:falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
+'simon:instant802.com' => 'Simon Barber',
 'simon:thekelleys.org.uk' => 'Simon Kelley',
 'simonb:lipsyncpost.co.uk' => 'Simon Burley',
 'skewer:terra.com.br' => 'Marcelo Abreu',
@@ -1448,6 +1479,7 @@
 'timw:splhi.com' => 'Tim Wright',
 'tinglett:vnet.ibm.com' => 'Todd Inglett',
 'tiwai:suse.de' => 'Takashi Iwai',
+'tlnguyen:snoqualmie.dp.intel.com' => 'long (tlnguyen)',
 'tmcreynolds:nvidia.com' => 'Tom McReynolds',
 'tmolina:cablespeed.com' => 'Thomas Molina',
 'tmolina:cox.net' => 'Thomas Molina',
@@ -1513,6 +1545,7 @@
 'wahrenbruch:kobil.de' => 'Thomas Wahrenbruch',
 'waltabbyh:comcast.net' => 'Walt Holman',
 'walter.harms:informatik.uni-oldenburg.de' => 'Walter Harms',
+'wang:ai.mit.edu' => 'Edward Wang',
 'warlord:mit.edu' => 'Derek Atkins',
 'warp:mercury.d2dc.net' => 'Zephaniah E. Hull',
 'wayne:stallion.oz.au' => 'Wayne Piekarski',
@@ -1526,6 +1559,7 @@
 'wesolows:foobazco.org' => 'Keith M. Wesolowski',
 'wessmith:sgi.com' => 'Wesley Smith',
 'wg:malloc.de' => 'Wolfram Gloger', # lbdb
+'wharms:bfs.de' => 'Walter Harms',
 'whitney:math.berkeley.edu' => 'Wayne Whitney',
 'whydoubt:yahoo.com' => 'Jeff Smith',
 'will:sowerbutts.com' => 'William R. Sowerbutts',
@@ -1552,6 +1586,7 @@
 'xose:wanadoo.es' => 'Xose Vazquez Perez', # lbdb
 'y.rutschle:com.rmk.(none)' => 'Yves Rutschle',
 'ya:slamail.org' => 'Yaacov Akiba Slama',
+'yasuyuki.kozakai:toshiba.co.jp' => 'Yasuyuki Kozakai',
 'yinah:couragetech.com.cn' => 'Yin Aihua',
 'yokota:netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
 'yoshfuji:linux-ipv6.org' => 'Hideaki Yoshifuji', # lbdb
@@ -1560,6 +1595,7 @@
 'yuasa:hh.iij4u.or.jp' => 'Yoichi Yuasa',
 'yuri:acronis.com' => 'Yuri Per', # lbdb
 'zaitcev:redhat.com' => 'Pete Zaitcev',
+'zdzichu:irc.pl' => 'Tomasz Torcz',
 'zecke:flint.arm.linux.org.uk' => 'Holger Freyther',
 'zecke:org.rmk.(none)' => 'Holger Freyther',
 'zinx:epicsol.org' => 'Zinx Verituse',

