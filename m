Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264402AbUFGLiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264402AbUFGLiy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 07:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUFGLiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 07:38:54 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:57228 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264402AbUFGLhe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:37:34 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.289
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_Jun__7_11_37_13_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040607113713.34405C086F@merlin.emma.line.org>
Date: Mon,  7 Jun 2004 13:37:13 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.289 has been released.

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
revision 0.289
date: 2004/06/07 11:35:46;  author: emma;  state: Exp;  lines: +2 -2
Merge Linus' und Matthias' version. Adds two mappings to BK (vita),
corrects one in CVS.
----------------------------
revision 0.288
date: 2004/06/07 07:08:25;  author: vita;  state: Exp;  lines: +12 -1
add 11 addresses
----------------------------
revision 0.287
date: 2004/06/03 14:17:25;  author: vita;  state: Exp;  lines: +9 -1
add 8 new addresses
----------------------------
revision 0.286
date: 2004/06/03 12:59:56;  author: vita;  state: Exp;  lines: +4 -1
add 3 new addresses
----------------------------
revision 0.285
date: 2004/06/03 07:54:02;  author: vita;  state: Exp;  lines: +51 -5
merge Linus' additions and corrections (48 addresses)
----------------------------
revision 0.284
date: 2004/05/20 09:30:43;  author: emma;  state: Exp;  lines: +2 -1
One new address (Deepak Saxena).
----------------------------
revision 0.283
date: 2004/05/19 20:00:12;  author: emma;  state: Exp;  lines: +2 -1
Add one address.
----------------------------
revision 0.282
date: 2004/05/16 22:37:25;  author: emma;  state: Exp;  lines: +30 -4
Two dozen more addresses.
Fix Deepak Saxena's new addresses that lacked the trailing comma
and caused compilation trouble.
----------------------------
revision 0.281
date: 2004/05/14 20:07:18;  author: emma;  state: Exp;  lines: +4 -1
Add address for Adam Radford. (Matthias Andree)
Three new addresses. (Deepax Saxena)
----------------------------
revision 0.280
date: 2004/05/14 00:23:09;  author: emma;  state: Exp;  lines: +2 -1
Add Adam Radford's address.
----------------------------
revision 0.279
date: 2004/05/14 00:17:32;  author: emma;  state: Exp;  lines: +2 -1
Pull one downstream address into upstream (Jon Krueger).
Vita: more than a dozen new addresses.
----------------------------
revision 0.278
date: 2004/05/13 11:35:55;  author: vita;  state: Exp;  lines: +16 -1
15 new addresses
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.278
retrieving revision 0.289
diff -u -r0.278 -r0.289
--- lk-changelog.pl	13 May 2004 11:35:55 -0000	0.278
+++ lk-changelog.pl	7 Jun 2004 11:35:46 -0000	0.289
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.278 2004/05/13 11:35:55 vita Exp $
+# $Id: lk-changelog.pl,v 0.289 2004/06/07 11:35:46 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -171,19 +171,24 @@
 'adrian:humboldt.co.uk' => 'Adrian Cox',
 'adsharma:unix-os.sc.intel.com' => 'Arun Sharma',
 'aebr:win.tue.nl' => 'Andries E. Brouwer',
+'agl:us.ibm.com' => 'Adam Litke',
 'agrover:acpi3.(none)' => 'Andy Grover',
 'agrover:acpi3.jf.intel.com' => 'Andy Grover', # guessed
 'agrover:aracnet.com' => 'Andy Grover',
 'agrover:dexter.groveronline.com' => 'Andy Grover',
 'agrover:groveronline.com' => 'Andy Grover',
 'agruen:suse.de' => 'Andreas Gruenbacher',
+'agx:sigxcpu.org' => 'Guido Guenther',
 'ahaas:airmail.net' => 'Art Haas',
 'ahaas:neosoft.com' => 'Art Haas',
+'ahu:ds9a.nl' => 'Bert Hubert',
 'aia21:cam.ac.uk' => 'Anton Altaparmakov',
 'aia21:cantab.net' => 'Anton Altaparmakov',
 'aia21:cus.cam.ac.uk' => 'Anton Altaparmakov',
 'aia21:drop.stormcorp.org' => 'Anton Altaparmakov', # guessed
+'airlied:linux.ie' => 'Dave Airlie',
 'airlied:pdx.freedesktop.org' => 'Dave Airlie',
+'airlied:starflyer.(none)' => 'Dave Airlie',
 'aj:andaco.de' => 'Andreas Jochens',
 'ajm:sgi.com' => 'Alan Mayer',
 'ajoshi:kernel.crashing.org' => 'Ani Joshi',
@@ -192,12 +197,14 @@
 'ak:colin2.muc.de' => 'Andi Kleen',
 'ak:muc.de' => 'Andi Kleen',
 'ak:suse.de' => 'Andi Kleen',
+'akepner:sgi.com' => 'Arthur Kepner',
 'akpm:digeo.com' => 'Andrew Morton',
 'akpm:org.rmk.(none)' => 'Andrew Morton',
 'akpm:osdl.org' => 'Andrew Morton', # guessed
 'akpm:reardensteel.com' => 'Andrew Morton',
 'akpm:zip.com.au' => 'Andrew Morton',
 'akropel1:rochester.rr.com' => 'Adam Kropelin', # lbdb
+'al.fracchetti:tin.it' => 'Alessandro Fracchetti',
 'alain.knaff:lll.lu' => 'Alain Knaff',
 'alain:linux.lu' => 'Alain Knaff',
 'alan:lxorguk.ukuu.org.uk' => 'Alan Cox',
@@ -253,6 +260,7 @@
 'ap:cipherica.com' => 'Alex Pankratov',
 'apolkosnik:directvinternet.com' => 'Adam Polkosnik',
 'apw:shadowen.org' => 'Andy Whitcroft',
+'aradford:amcc.com' => 'Adam Radford',
 'arashi:yomerashi.yi.org' => 'Matt Reppert',
 'arekm:pld-linux.org' => 'Arkadiusz Miskiewicz', # lbdb
 'arief_m_utama:telkomsel.co.id' => 'Arief Mulya Utama',
@@ -271,6 +279,7 @@
 'arvidjaar:mail.ru' => 'Andrey Borzenkov',
 'arzie:dds.nl' => 'Robert Zwerus',
 'aschultz:warp10.net' => 'Andreas Schultz',
+'ashok.raj:intel.com' => 'Ashok Raj',
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
 'asl:launay.org' => 'Arnaud S. Launay',
 'aspicht:arkeia.com' => 'Arnaud Spicht',
@@ -328,9 +337,11 @@
 'bjorn.helgaas:com.rmk.(none)' => 'Bjorn Helgaas',
 'bjorn.helgaas:hp.com' => 'Bjorn Helgaas',
 'bjorn.wesen:axis.com' => 'Bjorn Wesen',
+'bjorn:mork.no' => 'Bjørn Mork',
 'bjorn_helgaas:hp.com' => 'Bjorn Helgaas',
 'bk:suse.de' => 'Bernhard Kaindl',
 'blaschke:blaschke3.austin.ibm.com' => 'Dave Blaschke',
+'blazara:nvidia.com' => 'Brian Lazara',
 'blueflux:koffein.net' => 'Oskar Andreasson',
 'bmatheny:purdue.edu' => 'Blake Matheny', # google
 'bombe:informatik.tu-muenchen.de' => 'Andreas Bombe',
@@ -340,12 +351,14 @@
 'brad:wasp.net.au' => 'Brad Campbell',
 'brazilnut:us.ibm.com' => 'Don Fry',
 'brett:bad-sports.com' => 'Brett Pemberton',
+'brewt-linux-kernel:brewt.org' => 'Adrian Yee',
 'brian:rentec.com' => 'Brian Childs',
 'brihall:pcisys.net' => 'Brian Hall', # google
 'brill:fs.math.uni-frankfurt.de' => 'Björn Brill',
 'brking:us.ibm.com' => 'Brian King',
 'brm:murphy.dk' => 'Brian Murphy',
 'brownfld:irridia.com' => 'Ken Brownfield',
+'bryan:staidm.org' => 'Bryan Rittmeyer',
 'bryder:paradise.net.nz' => 'Bill Ryder',
 'buffer:antifork.org' => 'Angelo Dell\'Aera',
 'bunk:de.rmk.(none)' => 'Adrian Bunk', # guessed
@@ -361,11 +374,13 @@
 'c-d.hailfinger.kernel.2002-q4:gmx.net' => 'Carl-Daniel Hailfinger', # himself
 'c-d.hailfinger.kernel.2003:gmx.net' => 'Carl-Daniel Hailfinger', # himself
 'c-d.hailfinger.kernel.2004:gmx.net' => 'Carl-Daniel Hailfinger',
+'c.lucas:ifrance.com' => 'Christophe Lucas',
 'cagle:mindspring.com' => 'John Cagle', # Alan
 'calum.mackay:cdmnet.org' => 'Calum Mackay', # lbdb
 'cananian:lesser-magoo.lcs.mit.edu' => 'C. Scott Ananian',
 'car.busse:gmx.de' => 'Carsten Busse',	# verified by Greg KH
 'cat:zip.com.au' => 'CaT',
+'catalin.marinas:com.rmk.(none)' => 'Catalin Marinas',
 'cattelan:lupo.thebarn.com' => 'Russell Cattelan',
 'cattelan:naboo.americas.sgi.com' => 'Russell Cattelan',
 'cattelan:naboo.eagan' => 'Russell Cattelan',
@@ -388,6 +403,7 @@
 'chip:pobox.com' => 'Chip Salzenberg', # lbdb
 'chris:qwirx.com' => 'Chris Wilson',
 'chris:wirex.com' => 'Chris Wright',
+'chrisg:etnus.com' => 'Chris Gottbrath',
 'chrisl:vmware.com' => 'Christopher Li',
 'christer:weinigel.se' => 'Christer Weinigel', # from shortlog
 'christophe:saout.de' => 'Christophe Saout',
@@ -407,6 +423,7 @@
 'cltien:cmedia.com.tw' => 'Chen Li Tien',
 'cmayor:ca.rmk.(none)' => 'Cam Mayor',
 'cminyard:mvista.com' => 'Corey Minyard',
+'cmm:us.ibm.com' => 'Mingming Cao',
 'cniehaus:handhelds.org' => 'Carsten Niehaus',
 'cobra:compuserve.com' => 'Kevin Brosius',
 'colin:colino.net' => 'Colin Leroy',
@@ -419,6 +436,7 @@
 'cort:fsmlabs.com' => 'Cort Dougan',
 'coughlan:redhat.com' => 'Tom Coughlan',
 'coywolf:greatcn.org' => 'Coywolf Qi Hunt',
+'cpg:aladdin.de' => 'Christian Groessler',
 'cpg:puchol.com' => 'Carlos Puchol',
 'cph:zurich.ai.mit.edu' => 'Chris Hanson',
 'cr:sap.com' => 'Christoph Rohland',
@@ -455,6 +473,7 @@
 'daniel:osdl.org' => 'Daniel McNeil',
 'daniela:cyclades.com' => 'Daniela Squassoni',
 'dank:kegel.com' => 'Dan Kegel',
+'danlee:informatik.uni-freiburg.de' => 'Sau Dan Lee',
 'dario:emc.com' => 'Dario Ballabio', # Alan Cox
 'dave.jiang:com.rmk.(none)' => 'Dave Jiang',
 'dave.jiang:intel.com' => 'Dave Jiang', # lbdb
@@ -474,6 +493,7 @@
 'david-b:pacbell.com' => 'David Brownell',
 'david-b:pacbell.net' => 'David Brownell',
 'david-b:packbell.net' => 'David Brownell',
+'david.goodenough:btconnect.com' => 'David Goodenough',
 'david.nelson:pobox.com' => 'David Nelson',
 'david:csse.uwa.edu.au' => 'David Glance',
 'david:gibson.dropbear.id.au' => 'David Gibson',
@@ -507,6 +527,7 @@
 'dhowells:cambridge.redhat.com' => 'David Howells',
 'dhowells:redhat.com' => 'David Howells',
 'dhylands:com.rmk.(none)' => 'Dave Hylands',
+'diegocg:teleline.es' => 'Diego Calleja García',
 'dilinger:mp3revolution.net' => 'Andres Salomon',
 'dipankar:in.ibm.com' => 'Dipankar Sarma',
 'dirk.behme:com.rmk.(none)' => 'Dirk Behme',
@@ -539,13 +560,17 @@
 'dsaxena:com.rmk.(none)' => 'Deepak Saxena',
 'dsaxena:mvista.com' => 'Deepak Saxena',
 'dsaxena:net.rmk.(none)' => 'Deepak Saxena',
+'dsaxena:omelas.(none)' => 'Deepak Saxena',
 'dsaxena:plexity.net' => 'Deepak Saxena',
+'dsaxena:xanadu.(none)' => 'Deepak Saxena',
 'dsd:gentoo.org' => 'Daniel Drake',
 'dsteklof:us.ibm.com' => 'Daniel E. F. Stekloff',
+'dsw:gelato.unsw.edu.au' => 'Darren Williams',
 'dth:dth.net' => 'Danny ter Haar', # guessed
 'dtor_core:ameritech.net' => 'Dmitry Torokhov',
 'ducrot:poupinou.org' => 'Bruno Ducrot',
 'duncan.sands:math.u-psud.fr' => 'Duncan Sands',
+'dvrabel:arcom.com' => 'David Vrabel',
 'dvrabel:com.rmk.(none)' => 'David Vrabel',
 'dwmw2:dwmw2.baythorne.internal' => 'David Woodhouse',
 'dwmw2:infradead.org' => 'David Woodhouse',
@@ -563,6 +588,7 @@
 'edwardsg:sgi.com' => 'Greg Edwards', # google
 'efocht:ess.nec.de' => 'Erich Focht',
 'eger:havoc.gtf.org' => 'David Eger',
+'eger:theboonies.us' => 'David Eger',
 'ehabkost:conectiva.com.br' => 'Eduardo Pereira Habkost',
 'eike-hotplug:sf-tec.de' => 'Rolf Eike Beer',
 'eike-kernel:sf-tec.de' => 'Rolf Eike Beer', # sent by himself
@@ -593,11 +619,13 @@
 'erlend-a:us.his.no' => 'Erlend Aasland',
 'erlend-a:ux.his.no' => 'Erlend Aasland',
 'ernstp:mac.com' => 'Ernst Persson', # lbdb
+'errandir_news:mph.eclipse.co.uk' => 'Martin Habets',
 'eugene.teo:eugeneteo.net' => 'Eugene Teo',
 'eugeneteo:eugeneteo.net' => 'Eugene Teo',
 'evan.felix:pnl.gov' => 'Evan Felix',
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'fabian.frederick:skynet.be' => 'Fabian Frederick',
+'faikuygur:tnn.net' => 'Faik Uygur',
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
 'faith:redhat.com' => 'Rik Faith',
 'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hüffner',
@@ -613,6 +641,7 @@
 'fero:sztalker.hu' => 'Bakonyi Ferenc',
 'filip.sneppe:cronos.be' => 'Filip Sneppe',
 'fischer:linux-buechse.de' => 'Jürgen E. Fischer',
+'fishor:gmx.net' => 'Alexey Fisher',
 'flavien:lebarbe.net' => 'Flavien Lebarbé',
 'fletch:aracnet.com' => 'Martin J. Bligh',
 'flo:rfc822.org' => 'Florian Lohoff',
@@ -622,6 +651,7 @@
 'fnm:fusion.ukrsat.com' => 'Nick Fedchik',
 'focht:ess.nec.de' => 'Erich Focht',
 'fokkensr:fokkensr.vertis.nl' => 'Rolf Fokkens',
+'france:handhelds.org' => 'George France',
 'francis.wiran:hp.com' => 'Francis Wiran',
 'frank.cornelis:elis.ugent.be' => 'Frank Cornelis',
 'franz.sirl-kernel:lauterbach.com' => 'Franz Sirl',
@@ -632,6 +662,7 @@
 'fubar:us.ibm.com' => 'Jay Vosburgh',
 'fw:deneb.enyo.de' => 'Florian Weimer', # lbdb
 'fzago:austin.rr.com' => 'Frank Zago', # google
+'g.liakhovetski:gmx.de' => 'Guennadi Liakhovetski',
 'gaa:ulticom.com' => 'Gary Algier', # google
 'galak:blarg.somerset.sps.mot.com' => 'Kumar Gala',
 'ganadist:nakyup.mizi.com' => 'Cha Young-Ho',
@@ -647,6 +678,7 @@
 'gbarzini:virata.com' => 'Guido Barzini',
 'geert.uytterhoeven:sonycom.com' => 'Geert Uytterhoeven',
 'geert:linux-m68k.org' => 'Geert Uytterhoeven',
+'geoffrey.levand:am.sony.com' => 'Geoffrey LEVAND',
 'george:mvista.com' => 'George Anzinger',
 'georgn:somanetworks.com' => 'Georg Nikodym',
 'gerald.schaefer:gmx.net' => 'Gerald Schaefer',
@@ -656,6 +688,7 @@
 'gibbs:overdrive.btc.adaptec.com' => 'Justin T. Gibbs',
 'gibbs:scsiguy.com' => 'Justin T. Gibbs',
 'gilbertd:treblig.org' => 'Dr. David Alan Gilbert',
+'giri:lmc.cs.sunysb.edu' => 'Giridhar Pemmasani',
 'giuseppe.furlan:systeam.it' => 'Giuseppe Furlan',
 'gj:pointblue.com.pl' => 'Grzegorz Jaskiewicz',
 'gkernel.adm:hostme.bitkeeper.com' => 'Jeff Garzik', # himself
@@ -663,6 +696,7 @@
 'glee:gnupilgrims.org' => 'Geoffrey Lee', # lbdb
 'glenn:aoi-industries.com' => 'Glenn Burkhardt',
 'gnb:alphalink.com.au' => 'Greg Banks',
+'gnb:melbourne.sgi.com' => 'Greg Banks',
 'go:turbolinux.co.jp' => 'Go Taniguchi',
 'gone:us.ibm.com' => 'Patricia Gaughen',
 'gorgo:thunderchild.debian.net' => 'Madarasz Gergely',
@@ -673,9 +707,9 @@
 'green:angband.namesys.com' => 'Oleg Drokin',
 'green:linuxhacker.ru' => 'Oleg Drokin',
 'green:namesys.com' => 'Oleg Drokin',
-'greg_aumann:sil.org' => 'Greg Aumann',
 'greg:kroah.com' => 'Greg Kroah-Hartman',
 'greg:soap.kroah.net' => 'Greg Kroah-Hartman',
+'greg_aumann:sil.org' => 'Greg Aumann',
 'gregkh:kernel.bkbits.net' => 'Greg Kroah-Hartman',
 'grigouze:noos.fr' => 'Mickaël Grigouze',
 'gronkin:nerdvana.com' => 'George Ronkin',
@@ -684,11 +718,14 @@
 'grundym:us.ibm.com' => 'Michael Grundy',
 'gsromero:alumnos.euitt.upm.es' => 'Guillermo S. Romero',
 'gtoumi:laposte.net' => 'Ghozlane Toumi',
+'gtw:cs.bu.edu' => 'Gary Wong',
 'guillaume:morinfr.org' => 'Guillaume Morin',
 'gwehrman:sgi.com' => 'Geoffrey Wehrman',
 'h.schurig:de.rmk.(none)' => 'Holger Schurig',
+'habanero:us.ibm.com' => 'Andrew Theurer',
 'hadi:cyberus.ca' => 'Jamal Hadi Salim',
 'hadi:shell.cyberus.ca' => 'Jamal Hadi Salim',
+'hadi:zynx.com' => 'Jamal Hadi Salim',
 'hall:vdata.com' => 'Jeff Hall',
 'hammer:adaptec.com' => 'Jack Hammer',
 'hannal:us.ibm.com' => 'Hanna V. Linder',
@@ -719,6 +756,7 @@
 'henrique:cyclades.com' => 'Henrique Gobbi',
 'herbert:13thfloor.at' => 'Herbert Pötzl', # lbdb
 'herbert:gondor.apana.org.au' => 'Herbert Xu',
+'herbet:gondor.apana.org.au' => 'Herbert Xu',
 'hermes:gibson.dropbear.id.au' => 'David Gibson',
 'hero:persua.de' => 'Heiko Ronsdorf',
 'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
@@ -789,6 +827,7 @@
 'jay.estabrook:compaq.com' => 'Jay Estabrook',
 'jay.estabrook:hp.com' => 'Jay Estabrook',
 'jb:jblache.org' => 'Julien Blache',
+'jbarnes:engr.sgi.com' => 'Jesse Barnes',
 'jbarnes:sgi.com' => 'Jesse Barnes',
 'jbaron:redhat.com' => 'Jason Baron',
 'jbglaw:lug-owl.de' => 'Jan-Benedict Glaw',
@@ -798,6 +837,7 @@
 'jcdutton:users.sourceforge.net' => 'James Courtier-Dutton',
 'jdavid:farfalle.com' => 'David Ruggiero',
 'jdewand:redhat.com' => 'Julie DeWandel',
+'jdgaston:snoqualmie.dp.intel.com' => 'Jason D Gaston',
 'jdike:jdike.wstearns.org' => 'Jeff Dike',
 'jdike:karaya.com' => 'Jeff Dike',
 'jdike:uml.karaya.com' => 'Jeff Dike',
@@ -809,6 +849,7 @@
 'jeff.wiedemeier:hp.com' => 'Jeff Wiedemeier',
 'jeffm:suse.com' => 'Jeff Mahoney',
 'jeffm:suse.de' => 'Jeff Mahoney',
+'jeffml:pobox.com' => 'Jeff Lightfoot',
 'jeffpc:optonline.net' => 'Josef \'Jeff\' Sipek',
 'jeffs:accelent.com' => 'Jeff Sutherland', # lbdb
 'jejb:fuzzy.(none)' => 'James Bottomley',
@@ -816,7 +857,9 @@
 'jejb:malley.(none)' => 'James Bottomley',
 'jejb:mulgrave.(none)' => 'James Bottomley', # from shortlog
 'jejb:raven.il.steeleye.com' => 'James Bottomley',
+'jelenz:edu.rmk.(none)' => 'John Lenz',
 'jenna.s.hall:intel.com' => 'Jenna S. Hall', # google
+'jeremy:redfishsoftware.com.au' => 'Jeremy Kerr',
 'jeremy:sgi.com' => 'Jeremy Higdon',
 'jermar:itbs.cz' => 'Jakub Jermar',
 'jes:trained-monkey.org' => 'Jes Sorensen',
@@ -841,12 +884,15 @@
 'jhammer:us.ibm.com' => 'Jack Hammer',
 'jhartmann:addoes.com' => 'Jeff Hartmann',
 'jhf:rivenstone.net' => 'Joseph Fannin',
+'jhh:lucent.com' => 'Jorge Hernandez-Herrero',
 'jholmes:psu.edu' => 'Jason Holmes',
 'jiho:c-zone.net' => 'Jim Howard',
+'jim.hague:acm.org' => 'Jim Hague',
 'jim.houston:attbi.com' => 'Jim Houston',
 'jim.houston:comcast.net' => 'Jim Houston',
 'jk:ozlabs.org' => 'Jeremy Kerr',
 'jkenisto:us.ibm.com' => 'James Keniston',
+'jkluebs:com.rmk.(none)' => 'John K. Luebs',
 'jkmaline:cc.hut.fi' => 'Jouni Malinen',
 'jkt:helius.com' => 'Jack Thomasson',
 'jlcooke:certainkey.com' => 'Jean-Luc Cooke',
@@ -855,6 +901,7 @@
 'jmorris:intercode.com.au' => 'James Morris',
 'jmorris:redhat.com' => 'James Morris',
 'jmorros:intercode.com.au' => 'James Morris',	# it's typo IMHO
+'jnardelli:infosciences.com' => 'Joe Nardelli',
 'jo-lkml:suckfuell.net' => 'Jochen Suckfuell',
 'jochen:jochen.org' => 'Jochen Hein',
 'jochen:scram.de' => 'Jochen Friedrich',
@@ -891,7 +938,9 @@
 'joshk:triplehelix.org' => 'Joshua Kwan',
 'jparadis:redhat.com' => 'Jim Paradis',
 'jparmele:wildbear.com' => 'Joseph Parmelee',
+'jpk:sgi.com' => 'Jon Krueger',
 'jrsantos:austin.ibm.com' => 'Jose R. Santos',
+'js189202:zodiac.mimuw.edu.pl' => 'Jerzy Szczepkowski',
 'jschopp:austin.ibm.com' => 'Joel Schopp',
 'jsiemes:web.de' => 'Josef Siemes',
 'jsimmons:heisenberg.transvirtual.com' => 'James Simmons',
@@ -930,6 +979,7 @@
 'kanojsarcar:yahoo.com' => 'Kanoj Sarcar',
 'kaos:ocs.com.au' => 'Keith Owens',
 'kaos:sgi.com' => 'Keith Owens', # sent by himself
+'kaos:sgi.o' => 'Keith Owens',
 'kare.sars:lmf.ericsson.se' => 'Kåre Särs',
 'karlis:mt.lv' => 'Karlis Peisenieks',
 'kartik_me:hotmail.com' => 'Kartikey Mahendra Bhatt',
@@ -940,12 +990,15 @@
 'kazunori:miyazawa.org' => 'Kazunori Miyazawa',
 'kberg:linux1394.org' => 'Steve Kinneberg',
 'keithu:parl.clemson.edu' => 'Keith Underwood',
+'kenn:linux.ie' => 'Kenn Humborg',
 'kenneth.w.chen:intel.com' => 'Kenneth W. Chen',
 'kernel:jsl.com' => 'Jeffrey S. Laing',
 'kernel:kolivas.org' => 'Con Kolivas',
 'kernel:steeleye.com' => 'Paul Clements',
 'kettenis:gnu.org' => 'Mark Kettenis',
 'kevcorry:us.ibm.com' => 'Kevin Corry',
+'kevin.curtis:farsite.co.uk' => 'Kevin Curtis',
+'kevin:koconnor.net' => 'Kevin O\'Connor',
 'kevino:asti-usa.com' => 'Kevin Owen',
 'key:austin.ibm.com' => 'Kent Yoder',
 'khaho:koti.soon.fi' => 'Ari Juhani Hämeenaho',
@@ -981,6 +1034,7 @@
 'kronos:kronoz.cjb.net' => 'Luca Tettamanti',
 'kuba:mareimbrium.org' => 'Kuba Ober',
 'kuebelr:email.uc.edu' => 'Robert Kuebel',
+'kumar.gala:freescale.com' => 'Kumar Gala',
 'kumarkr:us.ibm.com' => 'Krishna Kumar',
 'kunihiro:ipinfusion.com' => 'Kunihiro Ishiguro',
 'kurt.robideau:comtrol.com' => 'Kurt Robideau',	# wild guess
@@ -1019,14 +1073,18 @@
 'linas:austin.ibm.com' => 'Linas Vepstas',
 'linas:us.ibm.com' => 'Linas Vepstas',
 'linux-kernel:n-dimensional.de' => 'Hans Ulrich Niedermann',
+'linux-kernel:vortech.net' => 'Joshua Jackson',
 'linux-usb:gemeinhardt.info' => 'Lars Gemeinhardt',
+'linux-usb:nerds-incorporated.org' => 'Sepp Wijnands',
 'linux:brodo.de' => 'Dominik Brodowski',
 'linux:de.rmk.(none)' => 'Dominik Brodowski',
 'linux:de.rmk.(none2)' => 'Sebastian Henschel',
 'linux:dominikbrodowski.de' => 'Dominik Brodowski',
 'linux:hazard.jcu.cz' => 'Jan Marek',
 'linux:kodeaffe.de' => 'Sebastian Henschel',
+'linux:sandersweb.net' => 'David Sanders',
 'linux:thorsten-knabe.de' => 'Thorsten Knabe',
+'linuxram:us.ibm.com' => 'Ram Pai',
 'lionel.bouton:inet6.fr' => 'Lionel Bouton',
 'lists:mdiehl.de' => 'Martin Diehl',
 'livio:ime.usp.br' => 'Livio Baldini Soares',
@@ -1090,6 +1148,7 @@
 'marcelo:logos.cnet' => 'Marcelo Tosatti', # guessed
 'marcelo:plucky.distro.conectiva' => 'Marcelo Tosatti',
 'marchand:kde.org' => 'Mickael Marchand',
+'marco.cova:studio.unibo.it' => 'Marco Cova',
 'marcus:ingate.com' => 'Marcus Sundberg',
 'marekm:amelek.gda.pl' => 'Marek Michalkiewicz',
 'margitsw:t-online.de' => 'Margit Schubert-While',
@@ -1102,6 +1161,7 @@
 'markgw:sgi.com' => 'Mark Goodwin',
 'markh:osdl.org' => 'Mark Haverkamp',
 'markhe:veritas.com' => 'Mark Hemment',
+'markus.lidel:shadowconnect.com' => 'Markus Lidel',
 'marr:flex.com' => 'Bill Marr',
 'martin.bene:icomedias.com' => 'Martin Bene',
 'martin.bligh:us.ibm.com' => 'Martin J. Bligh',
@@ -1130,9 +1190,11 @@
 'mbligh:aracnet.com' => 'Martin J. Bligh',
 'mbp:samba.org' => 'Martin Pool', # lbdb
 'mbp:vexed.ozlabs.hp.com' => 'Martin Pool',
+'mbuesch:freenet.de' => 'Michael Buesch',
 'mcgrof:ruslug.rutgers.edu' => 'Luis R. Rodriguez',
 'mcgrof:studorgs.rutgers.edu' => 'Luis R. Rodriguez',
 'mchan:broadcom.com' => 'Michael Chan',
+'mchouque:online.fr' => 'Mathieu Chouquet-Stringer',
 'mcp:linux-systeme.de' => 'Marc-Christian Petersen',
 'mdharm-scsi:one-eyed-alien.net' => 'Matthew Dharm',
 'mdharm-usb:one-eyed-alien.net' => 'Matthew Dharm',
@@ -1143,6 +1205,7 @@
 'mebrown:michaels-house.net' => 'Michael E. Brown',
 'mec:shout.net' => 'Michael Elizabeth Chastain',
 'meissner:suse.de' => 'Marcus Meissner',
+'menard.fabrice:wanadoo.fr' => 'Fabrice Menard',
 'metolent:snoqualmie.dp.intel.com' => 'Matt Tolentino',
 'mfedyk:matchmail.com' => 'Mike Fedyk',
 'mgalgoci:redhat.com' => 'Matthew Galgoci',
@@ -1151,6 +1214,7 @@
 'mhf:linuxmail.org' => 'Michael Frank',
 'mhoffman:lightlink.com' => 'Mark M. Hoffman',
 'mhopf:innominate.com' => 'Mark-André Hopf',
+'mhuth:mvista.com' => 'Mark Huth',
 'michael.krauth:web.de' => 'Michael Krauth',
 'michael.veeck:gmx.net' => 'Michael Veeck',
 'michael.waychison:sun.com' => 'Mike Waychison',
@@ -1214,12 +1278,14 @@
 'mort:wildopensource.com' => 'Martin Hicks',
 'mostrows:speakeasy.net' => 'Michal Ostrowski',
 'mostrows:watson.ibm.com' => 'Michal Ostrowski',
+'movits:bloomberg.com' => 'Mordechai Ovits',
 'moz:compsoc.man.ac.uk' => 'John Levon',
 'mpm:selenic.com' => 'Matt Mackall',
 'mporter:cox.net' => 'Matt Porter',
 'mporter:kernel.crashing.org' => 'Matt Porter',
 'mroos:linux.ee' => 'Meelis Roos',
 'mrr:nexthop.com' => 'Mathew Richardson',
+'mru:kth.se' => 'Mans Rullgard',
 'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
 'msw:redhat.com' => 'Matt Wilson',
 'mufasa:sis.com.tw' => 'Mufasa Yang', # sent by himself
@@ -1279,6 +1345,7 @@
 'oleg:tv-sign.ru' => 'Oleg Nesterov',
 'olh:suse.de' => 'Olaf Hering',
 'oliendm:us.ibm.com' => 'Dave Olien',
+'oliver.heilmann:drkw.com' => 'Oliver Heilmann',
 'oliver.neukum:lrz.uni-muenchen.de' => 'Oliver Neukum',
 'oliver.spang:siemens.com' => 'Oliver Spang',
 'oliver:neukum.name' => 'Oliver Neukum',
@@ -1296,19 +1363,23 @@
 'p.guehring:futureware.at' => 'Philipp Gühring',
 'p.lavarre:ieee.org' => 'Pat LaVarre',
 'p2:ace.ulyssis.sutdent.kuleuven.ac.be' => 'Peter De Shrijver',
+'p:draigbrady.com' => 'Pádraig Brady',
 'p_gortmaker:yahoo.com' => 'Paul Gortmaker',
 'pablo:menichini.com.ar' => 'Pablo Menichini',
 'pam.delaney:lsil.com' => 'Pamela Delaney',
 'panagiotis.issaris:mech.kuleuven.ac.be' => 'Panagiotis Issaris',
 'paschal:rcsis.com' => 'David Paschal',
 'pasky:ucw.cz' => 'Petr Baudis',
+'pat:computer-refuge.org' => 'Patrick Finnegan',
 'patch:luckynet.dynu.com' => '"Lightweight Patch Manager"', # lbdb
+'patl:users.sourceforge.net' => 'Patrick J. LoPresti',
 'patmans:ibm.com' => 'Patrick Mansfield',
 'patmans:us.ibm.com' => 'Patrick Mansfield',
 'patrick.boettcher:desy.de' => 'Patrick Boettcher',
 'patrick:dreker.de' => 'Patrick Dreker', # lbdb
 'patrick:wildi.com' => 'Patrick Wildi',
 'paubert:iram.es' => 'Gabriel Paubert',
+'paul+nospam:wurtel.net' => 'Paul Slootman',
 'paul.clements:steeleye.com' => 'Paul Clements',
 'paul.mundt:timesys.com' => 'Paul Mundt', # google
 'paul:kungfoocoder.org' => 'Paul Wagland', # lbdb
@@ -1326,16 +1397,20 @@
 'pavel:janik.cz' => 'Pavel Janík',
 'pavel:suse.cz' => 'Pavel Machek',
 'pavel:ucw.cz' => 'Pavel Machek',
+'pavlas:nextra.cz' => 'Zdenek Pavlas',
 'pavlin:icir.org' => 'Pavlin Radoslavov',
 'pazke:donpac.ru' => 'Andrey Panin',
 'pazke:orbita1.ru' => 'Andrey Panin',
 'pbadari:us.ibm.com' => 'Badari Pulavarty',
+'pbouchand:cyberdeck.com' => 'Patrice Bouchand',
 'pcaulfie:redhat.com' => 'Patrick Caulfield',
 'pdelaney:lsil.com' => 'Pam Delaney',
 'pe1rxq:amsat.org' => 'Jeroen Vreeken',
 'pebl:math.ku.dk' => 'Peter Berg Larsen',
 'pee:erkkila.org' => 'Paul E. Erkkila',
 'pekon:informatics.muni.cz' => 'Petr Konecny',
+'pelle:dsv.su.se' => 'Per Olofsson',
+'pepe:attika.ath.cx' => 'Piotr Kaczuba',
 'pepinto:student.dei.uc.pt' => 'Pedro Emanuel M. D. Pinto',
 'per.winkvist:telia.com' => 'Per Winkvist',
 'per.winkvist:uk.com' => 'Per Winkvist',
@@ -1390,6 +1465,7 @@
 'ppc64:brule.rchland.ibm.com' => 'Peter Bergner',
 'praka:users.sourceforge.net' => 'Andrew Vasquez',
 'prasanna:in.ibm.com' => 'Prasanna S. Panchamukhi', # lbdb
+'prof.bj:freemail.hu' => 'Prof. BJ',
 'prom:berlin.ccc.de' => 'Ingo Albrecht',
 'proski:gnu.org' => 'Pavel Roskin',
 'proski:org.rmk' => 'Pavel Roskin',
@@ -1413,7 +1489,9 @@
 'randy.dunlap:verizon.net' => 'Randy Dunlap',
 'ranty:debian.org' => 'Manuel Estrada Sainz',
 'rask:sygehus.dk' => 'Rask Ingemann Lambertsen',
+'rathamahata:php4.ru' => 'Sergey S. Kostyliov',
 'raul:pleyades.net' => 'Raul Nunez de Arenas Coronado',
+'raven:themaw.net' => 'Ian Kent',
 'ray-lk:madrabbit.org' => 'Ray Lee',
 'rbh00:utsglobal.com' => 'Richard Hitt', # asked him, he prefers Richard
 'rbt:mtlb.co.uk' => 'Robert Cardell',
@@ -1457,6 +1535,7 @@
 'robert.olsson:data.slu.se' => 'Robert Olsson',
 'robert.picco:hp.com' => 'Robert Picco',
 'robin.farine:ch.rmk.(none)' => 'Robin Farine',
+'robin.farine:org.rmk.(none)' => 'Robin Farine',
 'robn:verdi.et.tudelft.nl' => 'Rob van Nieuwkerk',
 'roehrich:sgi.com' => 'Dean Roehrich',
 'rohde:duff.dk' => 'Rasmus Rohde',
@@ -1515,6 +1594,7 @@
 'sawa:yamamoto.gr.jp' => 'sawa',
 'scameron:quandary.cca.cpqcorp.net' => 'Steve Cameron',
 'scd:broked.org' => 'Steven Dake',
+'schaffner:gmx.li' => 'Martin Schaffner',
 'schierlm:gmx.de' => 'Michael Schierl',
 'schlicht:uni-mannheim.de' => 'Thomas Schlichter',
 'schlicht:uni-mannheimn.de' => 'Thomas Schlichter',	# it's typo IMHO
@@ -1534,6 +1614,7 @@
 'sds:epoch.ncsc.mil' => 'Stephen D. Smalley',
 'sds:tislabs.com' => 'Stephen D. Smalley',
 'sean.mcgoogan:superh.com' => 'Sean McGoogan',
+'sean:mess.org' => 'Sean Young',
 'seanlkml:rogers.com' => 'Sean Estabrooks',
 'sebastian.droege:gmx.de' => 'Sebastian Dröge',
 'sebek64:post.cz' => 'Marcel Sebek',
@@ -1547,6 +1628,7 @@
 'shaggy:kleikamp.austin.ibm.com' => 'Dave Kleikamp',
 'shaggy:kleikamp.dyn.webahead.ibm.com' => 'Dave Kleikamp',
 'shaggy:shaggy.austin.ibm.com' => 'Dave Kleikamp', # lbdb
+'shai:ftcon.com' => 'Shai Fultheim',
 'sheilds:msrl.com' => 'Michael Shields', # typo
 'shemminger:osdl.org' => 'Stephen Hemminger',
 'shep:alum.mit.edu' => 'Tim Shepard',
@@ -1595,6 +1677,7 @@
 'stelian.pop:fr.alcove.com' => 'Stelian Pop',
 'stelian:popies.net' => 'Stelian Pop',
 'stephane.galles:free.fr' => 'Stephane Galles', # guessed
+'stephen:phynp6.phy-astr.gsu.edu' => 'Stephen Leonard',
 'stern:rowland.harvard.edu' => 'Alan Stern',
 'stern:rowland.org' => 'Alan Stern', # lbdb
 'steve.cameron:hp.com' => 'Stephen Cameron',
@@ -1608,6 +1691,7 @@
 'stevef:smfhome.smfdom' => 'Steve French',
 'stevef:smfhome.smfsambadom' => 'Steve French',
 'stevef:smfhome1.austin.rr.com' => 'Steve French',
+'stevef:smfhome1.smfsambadom' => 'Steve French',
 'stevef:smfhome2.austin.rr.com' => 'Steve French',
 'stevef:stevef95.austin.ibm.com' => 'Steve French',
 'stevef:steveft21.austin.ibm.com' => 'Steve French',
@@ -1619,6 +1703,7 @@
 'stsp:aknet.ru' => 'Stas Sergeev',
 'stuart_hayes:dell.com' => 'Stuart Hayes',
 'stuartm:connecttech.com' => 'Stuart MacDonald',
+'stuber:loria.fr' => 'Jürgen Stuber',
 'sullivan:austin.ibm.com' => 'Mike Sullivan',
 'suncobalt.adm:hostme.bitkeeper.com' => 'Tim Hockin', # by Duncan Laurie
 'sunil.saxena:intel.com' => 'Sunil Saxena',
@@ -1628,6 +1713,7 @@
 'svm:kozmix.org' => 'Sander van Malssen',
 'swanson:uklinux.net' => 'Alan Swanson',
 'swiergot:intersec.pl' => 'Jaroslaw Swierczynski',
+'sxking:qwest.net' => 'Steven King',
 'szepe:pinerecords.com' => 'Tomas Szepe',
 'sziwan:hell.org.pl' => 'Karol Kozimor',
 'szuk:telusplanet.net' => 'Scott Zuk',
@@ -1655,6 +1741,7 @@
 'thockin:sun.com' => 'Tim Hockin',
 'thoffman:arnor.net' => 'Torrey Hoffman',
 'thomas.schlichter:web.de' => 'Thomas Schlichter',
+'thomas.wahrenbruch:kobil.com' => 'Thomas Wahrenbruch',
 'thomas:bender.thinknerd.de' => 'Thomas Walpuski',
 'thomas:habets.pp.se' => 'Thomas Habets',
 'thomas:horsten.com' => 'Thomas Horsten',
@@ -1683,6 +1770,7 @@
 'tomlins:cam.org' => 'Ed Tomlinson',
 'tommy.christensen:tpack.net' => 'Tommy Christensen',
 'tommy:home.tig-grr.com' => 'Tom Marshall',
+'tony.cureington:hp.com' => 'Tony Cureington',
 'tony.luck:intel.com' => 'Tony Luck',
 'tony:atomide.com' => 'Tony Lindgren',
 'tony:bakeyournoodle.com' => 'Tony Breeds',
@@ -1692,7 +1780,10 @@
 'torben.mathiasen:hp.com' => 'Torben Mathiasen',
 'torque:ukrpost.net' => 'Yury Umanets',
 'torvalds:linux.local' => 'Linus Torvalds',
+'toshihiro.kobayashi:com.rmk.(none)' => 'Toshihiro Kobayashi',
+'tpoynor:mvista.com' => 'Todd Poynor',
 'trevor.pering:intel.com' => 'Trevor Pering',
+'trimmer:infiniconsys.com' => 'Todd Rimmer',
 'trini:bill-the-cat.bloom.county' => 'Tom Rini',
 'trini:kernel.crashing.org' => 'Tom Rini',
 'trini:mvista.com' => 'Tom Rini',
@@ -1705,6 +1796,7 @@
 'tspat:de.ibm.com' => 'Thomas Spatzier',
 'tuncer.ayaz:gmx.de' => 'Tuncer M. Zayamut Ayaz', # lbdb
 'tv:debian.org' => 'Tommi Virtanen',
+'tv:tv.debian.net' => 'Tommi Virtanen',
 'tvignaud:mandrakesoft.com' => 'Thierry Vignaud',
 'tvrtko:net4u.hr' => 'Tvrtko A. Ursulin',
 'twaugh:redhat.com' => 'Tim Waugh',
@@ -1716,8 +1808,10 @@
 'uaca:alumni.uv.es' => 'Ulisses Alonso Camaró',
 'urban.widmark:enlight.net' => 'Urban Widmark',
 'urban:teststation.com' => 'Urban Widmark',
+'uwe.bugla:gmx.de' => 'Uwe Bugla',
 'uwe.koziolek:gmx.net' => 'Uwe Koziolek',
 'uzi:uzix.org' => 'Joshua Uziel',
+'vadim:cs.washington.edu' => 'Vadim Lobanov',
 'valdis.kletnieks:vt.edu' => 'Valdis Kletnieks',
 'valko:linux.karinthy.hu' => 'Laszlo Valko',
 'vandrove:vc.cvut.cz' => 'Petr Vandrovec',
@@ -1727,6 +1821,8 @@
 'vberon:mecano.gme.usherb.ca' => 'Vincent Béron',
 'vda:port.imtp.ilyichevsk.odessa.ua' => 'Denis Vlasenko',
 'venkatesh.pallipadi:intel.com' => 'Venkatesh Pallipadi',
+'vesselin:alphawave.com.au' => 'Vesselin Kostadiov',
+'vfort:provident-solutions.com' => 'Vernon A. Fort',
 'vherva:niksula.hut.fi' => 'Ville Herva',
 'vinay-rc:naturesoft.net' => 'Vinay K. Nallamothu',
 'vinay.nallamothu:gsecone.com' => 'Vinay K. Nallamothu',
@@ -1743,6 +1839,7 @@
 'vojtech:suse.cz' => 'Vojtech Pavlik',
 'vojtech:twilight.ucw.cz' => 'Vojtech Pavlik',
 'vojtech:ucw.cz' => 'Vojtech Pavlik', # added by himself
+'vrajesh:umich.edu' => 'Rajesh Venkatasubramanian',
 'vs:tribesman.namesys.com' => 'Vladimir Saveliev',
 'vsu:altlinux.ru' => 'Sergey Vlasov',
 'wa:almesberger.net' => 'Werner Almesberger',
@@ -1789,11 +1886,13 @@
 'wrlk:riede.org' => 'Willem Riede',
 'wstinson:infonie.fr' => 'William Stinson',
 'wstinson:wanadoo.fr' => 'William Stinson',
+'wtogami:redhat.com' => 'Warren Togami',
 'xavier.bru:bull.net' => 'Xavier Bru',
 'xkaspa06:stud.fee.vutbr.cz' => 'Tomas Kasparek',
 'xose:wanadoo.es' => 'Xose Vazquez Perez', # lbdb
 'xschmi00:stud.feec.vutbr.cz' => 'Michal Schmidt',
 'y.rutschle:com.rmk.(none)' => 'Yves Rutschle',
+'y.rutschle:indigovision.com' => 'Yves Rutschle',
 'ya:slamail.org' => 'Yaacov Akiba Slama',
 'yasuyuki.kozakai:toshiba.co.jp' => 'Yasuyuki Kozakai',
 'yinah:couragetech.com.cn' => 'Yin Aihua',
@@ -1810,10 +1909,12 @@
 'zecke:org.rmk.(none)' => 'Holger Freyther',
 'zinx:epicsol.org' => 'Zinx Verituse',
 'zippel:linux-m68k.org' => 'Roman Zippel',
+'zli4:cs.uiuc.edu' => 'Zhenmin Li',
 'zubarev:us.ibm.com' => 'Irene Zubarev', # google
 'zw:superlucidity.net' => 'Zach Welch',
 'zwane:arm.linux.org.uk' => 'Zwane Mwaikambo',
 'zwane:commfireservices.com' => 'Zwane Mwaikambo',
+'zwane:fsmlabs.com' => 'Zwane Mwaikambo',
 'zwane:holomorphy.com' => 'Zwane Mwaikambo',
 'zwane:linux.realnet.co.sz' => 'Zwane Mwaikambo',
 'zwane:linuxpower.ca' => 'Zwane Mwaikambo',

