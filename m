Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUGBKjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUGBKjO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 06:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUGBKjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 06:39:14 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:36790 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261685AbUGBKif convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 06:38:35 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.307
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri_Jul__2_10_38_30_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040702103830.6AC78C0D6B@merlin.emma.line.org>
Date: Fri,  2 Jul 2004 12:38:30 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.307 has been released.

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
revision 0.307
date: 2004/07/02 08:59:44;  author: vita;  state: Exp;  lines: +6 -1
added 5 new addresses
----------------------------
revision 0.306
date: 2004/06/30 07:59:54;  author: vita;  state: Exp;  lines: +13 -1
added 12 addresses
----------------------------
revision 0.305
date: 2004/06/29 07:30:13;  author: vita;  state: Exp;  lines: +3 -1
added 2 addresses
----------------------------
revision 0.304
date: 2004/06/28 11:11:42;  author: vita;  state: Exp;  lines: +2 -1
added Andries E. Brouwer's address
----------------------------
revision 0.303
date: 2004/06/28 06:25:02;  author: vita;  state: Exp;  lines: +9 -3
added 6 new addresses; re-sorted
----------------------------
revision 0.302
date: 2004/06/25 10:42:28;  author: vita;  state: Exp;  lines: +11 -1
added 10 new addresses
----------------------------
revision 0.301
date: 2004/06/24 14:33:44;  author: vita;  state: Exp;  lines: +8 -1
7 new addresses
----------------------------
revision 0.300
date: 2004/06/24 14:11:38;  author: vita;  state: Exp;  lines: +17 -2
collect address translations from "Signed-off-by:" lines also;
don't insist on colon in "From: name <address>" lines
----------------------------
revision 0.299
date: 2004/06/24 12:55:16;  author: vita;  state: Exp;  lines: +2 -1
add one address
----------------------------
revision 0.298
date: 2004/06/23 08:09:34;  author: vita;  state: Exp;  lines: +5 -1
added 4 new addresses
----------------------------
revision 0.297
date: 2004/06/22 13:59:17;  author: vita;  state: Exp;  lines: +3 -1
added 2 new addresses
----------------------------
revision 0.296
date: 2004/06/21 07:46:33;  author: vita;  state: Exp;  lines: +34 -1
added 33 new addresses
----------------------------
revision 0.295
date: 2004/06/17 09:48:44;  author: vita;  state: Exp;  lines: +4 -1
added 3 new addresses
----------------------------
revision 0.294
date: 2004/06/16 09:29:12;  author: emma;  state: Exp;  lines: +2 -2
Change --mode=fixup so it also works without trailing colon.
----------------------------
revision 0.293
date: 2004/06/13 19:20:51;  author: emma;  state: Exp;  lines: +10 -1
Update
----------------------------
revision 0.292
date: 2004/06/11 10:47:16;  author: vita;  state: Exp;  lines: +2 -1
add another Steve French's address
----------------------------
revision 0.291
date: 2004/06/09 16:04:38;  author: vita;  state: Exp;  lines: +6 -1
add 5 addresses
----------------------------
revision 0.290
date: 2004/06/08 11:38:04;  author: vita;  state: Exp;  lines: +4 -1
add 3 addresses (1 from Linus' BK tree, 2 new)
----------------------------
revision 0.289
date: 2004/06/07 11:35:46;  author: emma;  state: Exp;  lines: +2 -2
Merge Linus' und Matthias' version. Adds two mappings to BK (vita),
corrects one in CVS.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.289
diff -u -r0.289 lk-changelog.pl
--- lk-changelog.pl	7 Jun 2004 11:35:46 -0000	0.289
+++ lk-changelog.pl	2 Jul 2004 10:36:27 -0000
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.289 2004/06/07 11:35:46 emma Exp $
+# $Id: lk-changelog.pl,v 0.307 2004/07/02 08:59:44 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -146,6 +146,7 @@
 'ac9410:attbi.com' => 'Albert Cranford',
 'ac9410:bellsouth.net' => 'Albert Cranford',
 'acher:in.tum.de' => 'Georg Acher',
+'achew:nvidia.com' => 'Andrew Chew',
 'achim_leubner:adaptec.com' => 'Achim Leubner',
 'achirica:telefonica.net' => 'Javier Achirica',
 'achirica:ttd.net' => 'Javier Achirica',
@@ -155,6 +156,7 @@
 'acme:conectiva.com.br' => 'Arnaldo Carvalho de Melo',
 'acme:dhcp197.conectiva' => 'Arnaldo Carvalho de Melo',
 'acme:parisc.kerneljanitors.org' => 'Arnaldo Carvalho de Melo',
+'acme:toy.kerneljanitors.org' => 'Arnaldo Carvalho de Melo',
 'acurtis:onz.com' => 'Allen Curtis',
 'adam:evdebs.org' => 'Adam Goode',
 'adam:kroptech.com' => 'Adam Kropelin',
@@ -163,6 +165,7 @@
 'adam:os.inf.tu-dresden.de' => 'Adam Lackorzynski',
 'adam:skullslayer.rod.org' => 'Adam Bernau',
 'adam:yggdrasil.com' => 'Adam J. Richter',
+'adaplas:hotpop.com' => 'Antonino Daplas',
 'adaplas:pol.net' => 'Antonino Daplas',
 'aderesch:fs.tum.de' => 'Andreas Deresch',
 'adi:drcomp.erfurt.thur.de' => 'Adrian Knoth',
@@ -170,7 +173,10 @@
 'adobriyan:mail.ru' => 'Alexey Dobriyan',
 'adrian:humboldt.co.uk' => 'Adrian Cox',
 'adsharma:unix-os.sc.intel.com' => 'Arun Sharma',
+'adwol:polsl.gliwice.pl' => 'Adam Osuchowski',
+'aeb:cwi.nl' => 'Andries E. Brouwer',
 'aebr:win.tue.nl' => 'Andries E. Brouwer',
+'agk:redhat.com' => 'Alasdair G. Kergon',
 'agl:us.ibm.com' => 'Adam Litke',
 'agrover:acpi3.(none)' => 'Andy Grover',
 'agrover:acpi3.jf.intel.com' => 'Andy Grover', # guessed
@@ -190,6 +196,7 @@
 'airlied:pdx.freedesktop.org' => 'Dave Airlie',
 'airlied:starflyer.(none)' => 'Dave Airlie',
 'aj:andaco.de' => 'Andreas Jochens',
+'ajgrothe:yahoo.com' => 'Aaron Grothe',
 'ajm:sgi.com' => 'Alan Mayer',
 'ajoshi:kernel.crashing.org' => 'Ani Joshi',
 'ajoshi:shell.unixbox.com' => 'Ani Joshi',
@@ -198,6 +205,7 @@
 'ak:muc.de' => 'Andi Kleen',
 'ak:suse.de' => 'Andi Kleen',
 'akepner:sgi.com' => 'Arthur Kepner',
+'akm:osdl.org' => 'Andrew Morton', # typo?
 'akpm:digeo.com' => 'Andrew Morton',
 'akpm:org.rmk.(none)' => 'Andrew Morton',
 'akpm:osdl.org' => 'Andrew Morton', # guessed
@@ -216,6 +224,7 @@
 'alessandro.zummo:towertech.it' => 'Alessandro Zummo',
 'alex.williamson:com.rmk.(none)' => 'Alex Williamson',
 'alex.williamson:hp.com' => 'Alex Williamson',
+'alex:clusterfs.com' => 'Alex Tomas',
 'alex:de.rmk.(none)' => 'Alexander Schulz',
 'alex:ssi.bg' => 'Alexander Atanasov',
 'alex_williamson:attbi.com' => 'Alex Williamson', # lbdb
@@ -244,6 +253,8 @@
 'andre.breiler:null-mx.org' => 'André Breiler',
 'andre:linux-ide.org' => 'Andre Hedrick',
 'andrea:suse.de' => 'Andrea Arcangeli',
+'andreas:xss.co.at' => 'Andreas Haumer',
+'andrej.filipcic:ijs.si' => 'Andrej Filipcic',
 'andrew.grover:intel.com' => 'Andy Grover', # "Andy" to match former entries
 'andrew.vasquez:qlogic.com' => 'Andrew Vasquez',
 'andrew.wood:ivarch.com' => 'Andrew Wood',
@@ -281,10 +292,13 @@
 'aschultz:warp10.net' => 'Andreas Schultz',
 'ashok.raj:intel.com' => 'Ashok Raj',
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
+'askulysh:image.kiev.ua' => 'Andriy Skulysh',
 'asl:launay.org' => 'Arnaud S. Launay',
 'aspicht:arkeia.com' => 'Arnaud Spicht',
+'async:cc.gatech.edu' => 'Rob Melby',
 'atul.mukker:lsil.com' => 'Atul Mukker',
 'atulm:lsil.com' => 'Atul Mukker',
+'augustus:linuxhardware.org' => 'Kris Kersey',
 'aurelien:aurel32.net' => 'Aurelien Jarno', # lbdb
 'aviro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'awagger:web.de' => 'Axel Waggershauser',
@@ -333,6 +347,7 @@
 'bhards:bigpond.net.au' => 'Brad Hards',
 'bhavesh:avaya.com' => 'Bhavesh P. Davda',
 'bheilbrun:paypal.com' => 'Brad Heilbrun', # by himself
+'bjoern:j3e.de' => 'Bjoern Jacke',
 'bjorn.andersson:erc.ericsson.se' => 'Björn Andersson', # google, guessed ö
 'bjorn.helgaas:com.rmk.(none)' => 'Bjorn Helgaas',
 'bjorn.helgaas:hp.com' => 'Bjorn Helgaas',
@@ -344,6 +359,7 @@
 'blazara:nvidia.com' => 'Brian Lazara',
 'blueflux:koffein.net' => 'Oskar Andreasson',
 'bmatheny:purdue.edu' => 'Blake Matheny', # google
+'bogdan.costescu:iwr.uni-heidelberg.de' => 'Bogdan Costescu',
 'bombe:informatik.tu-muenchen.de' => 'Andreas Bombe',
 'borisitk:fortunet.com' => 'Boris Itkis', # by Kristian Peters
 'boutcher:us.ibm.com' => 'Dave Boutcher',
@@ -368,6 +384,7 @@
 'bwheadley:earthlink.net' => 'Bryan W. Headley',
 'bwindle:fint.org' => 'Burton N. Windle',
 'bzeeb-lists:lists.zabbadoz.net' => 'Björn A. Zeeb', # lbdb
+'bzolnier:elka.pw.edu.pl' => 'Bartlomiej Zolnierkiewicz',
 'bzzz:gerasimov.net' => 'Alex Tomas',
 'bzzz:tmi.comex.ru' => 'Alex Tomas',
 'c-d.hailfinger.kernel.2002-07:gmx.net' => 'Carl-Daniel Hailfinger',
@@ -389,6 +406,7 @@
 'ccheney:cheney.cx' => 'Christopher L. Cheney',
 'cel:citi.umich.edu' => 'Chuck Lever',
 'celso:bulma.net' => 'Celso González', # google
+'cesarb:nitnet.com.br' => 'Cesar Eduardo Barros',
 'ch:com.rmk.(none)' => 'Christopher Hoover',
 'ch:hpl.hp.com' => 'Christopher Hoover', # by Kristian Peters
 'ch:murgatroid.com' => 'Christopher Hoover',
@@ -406,6 +424,7 @@
 'chrisg:etnus.com' => 'Chris Gottbrath',
 'chrisl:vmware.com' => 'Christopher Li',
 'christer:weinigel.se' => 'Christer Weinigel', # from shortlog
+'christoph:graphe.net' => 'Christoph Lameter',
 'christophe:saout.de' => 'Christophe Saout',
 'christopher.leech:intel.com' => 'Christopher Leech',
 'christopher:intel.com' => 'Christopher Goldfarb',
@@ -426,6 +445,7 @@
 'cmm:us.ibm.com' => 'Mingming Cao',
 'cniehaus:handhelds.org' => 'Carsten Niehaus',
 'cobra:compuserve.com' => 'Kevin Brosius',
+'cohuck:de.ibm.com' => 'Cornelia Huck',
 'colin:colino.net' => 'Colin Leroy',
 'colin:gibbs.dhs.org' => 'Colin Gibbs',
 'colin:gibbsonline.net' => 'Colin Gibbs', # whois
@@ -440,6 +460,7 @@
 'cpg:puchol.com' => 'Carlos Puchol',
 'cph:zurich.ai.mit.edu' => 'Chris Hanson',
 'cr:sap.com' => 'Christoph Rohland',
+'craig.nadler:arc.com' => 'Craig Nadler',
 'craig:homerjay.homelinux.org' => 'Craig Wilkie',
 'cramerj:intel.com' => 'Jeb J. Cramer',
 'cruault:724.com' => 'Charles-Edouard Ruault',
@@ -453,6 +474,7 @@
 'd.mueller:elsoft.ch' => 'David Müller',
 'd3august:dtek.chalmers.se' => 'Björn Augustsson',
 'da-x:gmx.net' => 'Dan Aloni',
+'dada1:cosmosbay.com' => 'Eric Dumazet',
 'dainis_jonitis:exigengroup.lv' => 'Dainis Jonitis',
 'daisy:teetime.dynamic.austin.ibm.com' => 'Daisy Chang', # from shortlog
 'dale.farnsworth:mvista.com' => 'Dale Farnsworth',
@@ -508,12 +530,14 @@
 'davis_g:com.rmk.(none)' => 'George G. Davis',
 'dax:gurulabs.com' => 'Dax Kelson',
 'dbrownell:users.sourceforge.net' => 'David Brownell',
+'dcn:sgi.com' => 'Dean Nelson',
 'ddstreet:ieee.org' => 'Dan Streetman',
 'ddstreet:us.ibm.com' => 'Dan Streetman',
 'dean:arctic.org' => 'Dean Gaudet',
 'debian:abeckmann.de' => 'Andreas Beckmann',
 'deepfire:sic-elvis.zel.ru' => 'Samium Gromoff',
 'defouwj:purdue.edu' => 'Jeff DeFouw',
+'delaunay:lix.polytechnique.fr' => 'Eric Delaunay',
 'deller:gmx.de' => 'Helge Deller',
 'dent:cosy.sbg.ac.at' => "Thomas 'Dent' Mirlacher",
 'derek:ihtfp.com' => 'Derek Atkins',
@@ -567,6 +591,7 @@
 'dsteklof:us.ibm.com' => 'Daniel E. F. Stekloff',
 'dsw:gelato.unsw.edu.au' => 'Darren Williams',
 'dth:dth.net' => 'Danny ter Haar', # guessed
+'dtor:mail.ru' => 'Dmitry Torokhov',
 'dtor_core:ameritech.net' => 'Dmitry Torokhov',
 'ducrot:poupinou.org' => 'Bruno Ducrot',
 'duncan.sands:math.u-psud.fr' => 'Duncan Sands',
@@ -575,6 +600,7 @@
 'dwmw2:dwmw2.baythorne.internal' => 'David Woodhouse',
 'dwmw2:infradead.org' => 'David Woodhouse',
 'dwmw2:redhat.com' => 'David Woodhouse',
+'dwmw2:shinybook.infradead.org' => 'David Woodhouse',
 'dz:cs.unitn.it' => 'Massimo Dal Zotto',
 'ebiederm:xmission.com' => 'Eric W. Biederman',
 'ebrower:resilience.com' => 'Eric Brower',
@@ -589,17 +615,20 @@
 'efocht:ess.nec.de' => 'Erich Focht',
 'eger:havoc.gtf.org' => 'David Eger',
 'eger:theboonies.us' => 'David Eger',
+'egmont:uhulinux.hu' => 'Egmont Koblinger',
 'ehabkost:conectiva.com.br' => 'Eduardo Pereira Habkost',
 'eike-hotplug:sf-tec.de' => 'Rolf Eike Beer',
 'eike-kernel:sf-tec.de' => 'Rolf Eike Beer', # sent by himself
 'eike:bilbo.math.uni-mannheim.de' => 'Rolf Eike Beer',
 'elenstev:com.rmk.(none)' => 'Steven Cole',
 'elenstev:mesatop.com' => 'Steven Cole',
+'elf:buici.com' => 'Marc Singer',
 'elf:com.rmk.(none)' => 'Marc Singer',
 'eli.carter:com.rmk.(none)' => 'Eli Carter',
 'eli.kupermann:intel.com' => 'Eli Kupermann',
 'emann:mrv.com' => 'Eran Mann',
 'emcnabb:cs.byu.edu' => 'Evan N. McNabb',
+'emoenke:gwdg.de' => 'Eberhard Mönkeberg',
 'emoore:lsil.com' => 'Eric Dean Moore',
 'ender:debian.org' => 'David Martínez Moreno',
 'engebret:au1.ibm.com' => 'David Engebretsen',
@@ -623,6 +652,7 @@
 'eugene.teo:eugeneteo.net' => 'Eugene Teo',
 'eugeneteo:eugeneteo.net' => 'Eugene Teo',
 'evan.felix:pnl.gov' => 'Evan Felix',
+'extreme:zayanionline.com' => 'Vineet Mehta',
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'fabian.frederick:skynet.be' => 'Fabian Frederick',
 'faikuygur:tnn.net' => 'Faik Uygur',
@@ -638,6 +668,7 @@
 'felipewd:terra.com.br' => 'Felipe Damasio', # by self (did not ask to include the W.)
 'fello:libero.it' => 'Fabrizio Fellini',
 'fenghua.yu:intel.com' => 'Fenghua Yu', # google
+'fenlason:redhat.com' => 'Jay Fenlason',
 'fero:sztalker.hu' => 'Bakonyi Ferenc',
 'filip.sneppe:cronos.be' => 'Filip Sneppe',
 'fischer:linux-buechse.de' => 'Jürgen E. Fischer',
@@ -648,17 +679,20 @@
 'florian.thiel:gmx.net' => 'Florian Thiel', # from shortlog
 'florin:iucha.net' => 'Florin Iucha',
 'floroiu:fokus.fraunhofer.de' => 'John Williams Floroiu',
+'fn:kernelport.de' => 'Frank Neuber',
 'fnm:fusion.ukrsat.com' => 'Nick Fedchik',
 'focht:ess.nec.de' => 'Erich Focht',
 'fokkensr:fokkensr.vertis.nl' => 'Rolf Fokkens',
 'france:handhelds.org' => 'George France',
 'francis.wiran:hp.com' => 'Francis Wiran',
+'frank.a.uepping:t-online.de' => 'Frank A. Uepping',
 'frank.cornelis:elis.ugent.be' => 'Frank Cornelis',
 'franz.sirl-kernel:lauterbach.com' => 'Franz Sirl',
 'franz.sirl:lauterbach.com' => 'Franz Sirl',
 'frederik.deweerdt:laposte.net' => 'Frederik Deweerdt',
 'frival:zk3.dec.com' => 'Peter Rival',
 'fscked:netvisao.pt' => 'Paulo André',
+'fsgqa:sgi.com' => 'Nathan Scott',
 'fubar:us.ibm.com' => 'Jay Vosburgh',
 'fw:deneb.enyo.de' => 'Florian Weimer', # lbdb
 'fzago:austin.rr.com' => 'Frank Zago', # google
@@ -674,6 +708,7 @@
 'ganesh:veritas.com' => 'Ganesh Varadarajan',
 'ganesh:vxindia.veritas.com' => 'Ganesh Varadarajan',
 'garloff:suse.de' => 'Kurt Garloff',
+'gary_lerhaupt:dell.com' => 'Gary Lerhaupt',
 'garyhade:us.ibm.com' => 'Gary Hade',
 'gbarzini:virata.com' => 'Guido Barzini',
 'geert.uytterhoeven:sonycom.com' => 'Geert Uytterhoeven',
@@ -694,11 +729,14 @@
 'gkernel.adm:hostme.bitkeeper.com' => 'Jeff Garzik', # himself
 'gl:dsa-ac.de' => 'Guennadi Liakhovetski',
 'glee:gnupilgrims.org' => 'Geoffrey Lee', # lbdb
+'glen:imodulo.com' => 'Glen Nakamura',
 'glenn:aoi-industries.com' => 'Glenn Burkhardt',
 'gnb:alphalink.com.au' => 'Greg Banks',
 'gnb:melbourne.sgi.com' => 'Greg Banks',
+'gnb:sgi.com' => 'Greg Banks',
 'go:turbolinux.co.jp' => 'Go Taniguchi',
 'gone:us.ibm.com' => 'Patricia Gaughen',
+'gordon.jin:intel.com' => 'Gordon Jin',
 'gorgo:thunderchild.debian.net' => 'Madarasz Gergely',
 'gortmaker:yahoo.com' => 'Paul Gortmaker',
 'gotom:debian.or.jp' => 'Goto Masanori', # from shortlog
@@ -711,6 +749,7 @@
 'greg:soap.kroah.net' => 'Greg Kroah-Hartman',
 'greg_aumann:sil.org' => 'Greg Aumann',
 'gregkh:kernel.bkbits.net' => 'Greg Kroah-Hartman',
+'gregor_jan:seznam.cz' => 'Jan Gregor',
 'grigouze:noos.fr' => 'Mickaël Grigouze',
 'gronkin:nerdvana.com' => 'George Ronkin',
 'grundler:cup.hp.com' => 'Grant Grundler',
@@ -725,6 +764,7 @@
 'habanero:us.ibm.com' => 'Andrew Theurer',
 'hadi:cyberus.ca' => 'Jamal Hadi Salim',
 'hadi:shell.cyberus.ca' => 'Jamal Hadi Salim',
+'hadi:znyx.com' => 'Jamal Hadi Salim', # typo
 'hadi:zynx.com' => 'Jamal Hadi Salim',
 'hall:vdata.com' => 'Jeff Hall',
 'hammer:adaptec.com' => 'Jack Hammer',
@@ -760,17 +800,22 @@
 'hermes:gibson.dropbear.id.au' => 'David Gibson',
 'hero:persua.de' => 'Heiko Ronsdorf',
 'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
+'hiroshi_doyu:montavista.co.jp' => 'Hiroshi Doyu',
+'hjl:lucon.org' => 'H. J. Lu',
 'hjm:redhat.com' => 'Heinz Mauelshagen', # lbdb
 'hoho:binbash.net' => 'Colin Slater',
 'hollisb:us.ibm.com' => 'Hollis Blanchard',
+'holt:sgi.com' => 'Robin Holt',
 'home:mdiehl.de' => 'Martin Diehl',
 'horms:verge.net.au' => 'Simon Horman',
 'hpa:transmeta.com' => 'H. Peter Anvin',
 'hpa:zytor.com' => 'H. Peter Anvin',
+'huangt:star-net.cn' => 'Tao Huang',
 'hugh:com.rmk.(none)' => 'Hugh Dickins',
 'hugh:veritas.com' => 'Hugh Dickins',
 'hunold:convergence.de' => 'Michael Hunold',
 'hunold:linuxtv.org' => 'Michael Hunold',
+'hverhagen:dse.nl' => 'Harm Verhagen',
 'hwahl:hwahl.de' => 'Hartmut Wahl',
 'i.palsenberg:jdirmedia.nl' => 'Igmar Palsenberg', # lbdb
 'ian.abbott:mev.co.uk' => 'Ian Abbott',
@@ -800,6 +845,7 @@
 'jack:ucw.cz' => 'Jan Kara',
 'jack_hammer:adaptec.com' => 'Jack Hammer',
 'jackson:realtek.com.tw' => 'Ian Jackson',
+'jacmet:sunsite.dk' => 'Peter Korsgaard',
 'jaharkes:cs.cmu.edu' => 'Jan Harkes',
 'jakob.kemi:telia.com' => 'Jakob Kemi',
 'jakub:redhat.com' => 'Jakub Jelínek',
@@ -858,12 +904,14 @@
 'jejb:mulgrave.(none)' => 'James Bottomley', # from shortlog
 'jejb:raven.il.steeleye.com' => 'James Bottomley',
 'jelenz:edu.rmk.(none)' => 'John Lenz',
+'jelenz:students.wisc.edu' => 'John Lenz',
 'jenna.s.hall:intel.com' => 'Jenna S. Hall', # google
 'jeremy:redfishsoftware.com.au' => 'Jeremy Kerr',
 'jeremy:sgi.com' => 'Jeremy Higdon',
 'jermar:itbs.cz' => 'Jakub Jermar',
 'jes:trained-monkey.org' => 'Jes Sorensen',
 'jes:wildopensource.com' => 'Jes Sorensen',
+'jesse.brandeburg:intel.com' => 'Jesse Brandeburg',
 'jet:gyve.org' => 'Masatake Yamato',
 'jfbeam:bluetronic.net' => 'Ricky Beam',
 'jgarzik:fokker2.devel.redhat.com' => 'Jeff Garzik',
@@ -880,6 +928,7 @@
 'jgrimm:jgrimm.austin.ibm.com' => 'Jon Grimm', # google
 'jgrimm:touki.austin.ibm.com' => 'Jon Grimm', # google
 'jgrimm:touki.qip.austin.ibm.com' => 'Jon Grimm', # google
+'jgt:pobox.com' => 'Jon Thackray',
 'jh:sgi.com' => 'John Hesterberg',
 'jhammer:us.ibm.com' => 'Jack Hammer',
 'jhartmann:addoes.com' => 'Jeff Hartmann',
@@ -901,6 +950,7 @@
 'jmorris:intercode.com.au' => 'James Morris',
 'jmorris:redhat.com' => 'James Morris',
 'jmorros:intercode.com.au' => 'James Morris',	# it's typo IMHO
+'jmunsin:iki.fi' => 'Jonas Munsin',
 'jnardelli:infosciences.com' => 'Joe Nardelli',
 'jo-lkml:suckfuell.net' => 'Jochen Suckfuell',
 'jochen:jochen.org' => 'Jochen Hein',
@@ -929,11 +979,15 @@
 'johnpol:2ka.mipt.ru' => 'Evgeniy Polyakov',
 'johnrose:austin.ibm.com' => 'John Rose',
 'johnstul:us.ibm.com' => 'John Stultz',
+'jon:ballardtech.com' => 'Jon Neal',
 'jon:focalhost.com' => 'Jon Oberheide',
 'jonas.larsson:net.rmk.(none)' => 'Jonas Larsson',
+'jonas:thornblad.net' => 'Jonas Thornblad',
 'jones:ingate.com' => 'Jones Desougi',
 'jonsmirl:yahoo.com' => 'Jon Smirl',
+'joris:eljakim.nl' => 'Joris van Rantwijk',
 'joris:struyve.be' => 'Joris Struyve',
+'josh:emperorlinux.com' => 'Josh Litherland',
 'josh:joshisanerd.com' => 'Josh Myer',
 'joshk:triplehelix.org' => 'Joshua Kwan',
 'jparadis:redhat.com' => 'Jim Paradis',
@@ -956,6 +1010,7 @@
 'jt:hpl.hp.com' => 'Jean Tourrilhes',
 'jtyner:cs.ucr.edu' => 'John Tyner',
 'judd:jpilot.org' => 'Judd Montgomery',
+'juhl-lkml:dif.dk' => 'Jesper Juhl',
 'jun.nakajima:intel.com' => 'Jun Nakajima',
 'jung-ik.lee:intel.com' => 'Jung-Ik Lee',
 'jurgen:botz.org' => 'Jürgen Botz',
@@ -972,7 +1027,9 @@
 'kai:tp1.ruhr-uni-bochum.de' => 'Kai Germaschewski',
 'kai:vaio.(none)' => 'Kai Germaschewski',
 'kai:zephyr.physics.uiowa.edu' => 'Kai Germaschewski',
+'kaie:kuix.de' => 'Kai Engert',
 'kala:pinerecords.com' => 'Tomas Szepe',
+'kalin:thinrope.net' => 'Kalin Rumenov Kozhuharov',
 'kambo77:hotmail.com' => 'Kambo Lohan',
 'kaneshige.kenji:jp.fujitsu.com' => 'Kenji Kaneshige', # lbdb
 'kanoj:vger.kernel.org' => 'Kanoj Sarcar', # sent by Arnaldo Carvalho de Melo
@@ -989,15 +1046,18 @@
 'kaz:earth.email.ne.jp' => 'Kazuto Miyoshi',
 'kazunori:miyazawa.org' => 'Kazunori Miyazawa',
 'kberg:linux1394.org' => 'Steve Kinneberg',
+'kdesler:soohrt.org' => 'Karsten Desler',
 'keithu:parl.clemson.edu' => 'Keith Underwood',
 'kenn:linux.ie' => 'Kenn Humborg',
 'kenneth.w.chen:intel.com' => 'Kenneth W. Chen',
+'kernel-hacker:bennee.com' => 'Alex Bennee',
 'kernel:jsl.com' => 'Jeffrey S. Laing',
 'kernel:kolivas.org' => 'Con Kolivas',
 'kernel:steeleye.com' => 'Paul Clements',
 'kettenis:gnu.org' => 'Mark Kettenis',
 'kevcorry:us.ibm.com' => 'Kevin Corry',
 'kevin.curtis:farsite.co.uk' => 'Kevin Curtis',
+'kevin.tian:intel.com' => 'Kevin Tian',
 'kevin:koconnor.net' => 'Kevin O\'Connor',
 'kevino:asti-usa.com' => 'Kevin Owen',
 'key:austin.ibm.com' => 'Kent Yoder',
@@ -1012,6 +1072,7 @@
 'kingsley:aurema.com' => 'Cheung Kingsley',
 'kiran:in.ibm.com' => 'Ravikiran G. Thirumalai',
 'kirillx:7ka.mipt.ru' => 'Kirill Korotaev',
+'kishoreak:myw.ltindia.com' => 'Kishore A K',
 'kisza:sch.bme.hu' => 'Andras Kis-Szabo', # google (netfilter-ext HOWTO)
 'kkeil:isdn4linux.de' => 'Karsten Keil',
 'kkeil:suse.de' => 'Karsten Keil',
@@ -1032,9 +1093,11 @@
 'krishnakumar:naturesoft.net' => 'Krishna Kumar',
 'krkumar:us.ibm.com' => 'Krishna Kumar',
 'kronos:kronoz.cjb.net' => 'Luca Tettamanti',
+'kszysiu:iceberg.elsat.net.pl' => 'Krzysztof Rusocki',
 'kuba:mareimbrium.org' => 'Kuba Ober',
 'kuebelr:email.uc.edu' => 'Robert Kuebel',
 'kumar.gala:freescale.com' => 'Kumar Gala',
+'kumar.gala:motorola.com' => 'Kumar Gala',
 'kumarkr:us.ibm.com' => 'Krishna Kumar',
 'kunihiro:ipinfusion.com' => 'Kunihiro Ishiguro',
 'kurt.robideau:comtrol.com' => 'Kurt Robideau',	# wild guess
@@ -1048,6 +1111,7 @@
 'laforge:org.rmk.(none)' => 'Harald Welte', # guessed
 'lathiat:sixlabs.org' => 'Trent Lathiat Lloyd',
 'latten:austin.ibm.com' => 'Joy Latten',
+'laubrycomm:free.fr' => 'Ludovic Aubry',
 'laurent:latil.nom.fr' => 'Laurent Latil',
 'lavarre:iomega.com' => 'Pat LaVarre',
 'lawrence:the-penguin.otak.com' => 'Lawrence Walton',
@@ -1084,6 +1148,7 @@
 'linux:kodeaffe.de' => 'Sebastian Henschel',
 'linux:sandersweb.net' => 'David Sanders',
 'linux:thorsten-knabe.de' => 'Thorsten Knabe',
+'linux:youmustbejoking.demon.co.uk' => 'Darren Salt',
 'linuxram:us.ibm.com' => 'Ram Pai',
 'lionel.bouton:inet6.fr' => 'Lionel Bouton',
 'lists:mdiehl.de' => 'Martin Diehl',
@@ -1118,6 +1183,7 @@
 'lxiep:us.ibm.com' => 'Linda Xie',
 'm.c.p:kernel.linux-systeme.com' => 'Marc-Christian Petersen',
 'm.c.p:wolk-project.de' => 'Marc-Christian Petersen',
+'m.hunold:gmx.de' => 'Michael Hunold',
 'm:mbsks.franken.de' => 'Matthias Bruestle',
 'maalanen:ra.abo.fi' => 'Marcus Alanen',
 'mac:melware.de' => 'Armin Schindler',
@@ -1228,6 +1294,7 @@
 'michel.marti:objectxp.com' => 'Michel Marti',
 'michel:daenzer.net' => 'Michel Dänzer',
 'miguel:cetuc.puc-rio.br' => 'Miguel Freitas', # lbdb
+'mika:osdl.org' => 'Mika Kukkonen',
 'mikael.starvik:axis.com' => 'Mikael Starvik',
 'mikal:stillhq.com' => 'Michael Still',
 'mike.miller:hp.com' => 'Mike Miller',
@@ -1238,7 +1305,9 @@
 'mikpe:csd.uu.se' => 'Mikael Pettersson',
 'mikpe:user.it.uu.se' => 'Mikael Pettersson',
 'mikulas:artax.karlin.mff.cuni.cz' => 'Mikulas Patocka',
+'miles:gnu.org' => 'Miles Bader',
 'miles:lsi.nec.co.jp' => 'Miles Bader',
+'miles:mctpc71.ucom.lsi.nec.co.jp' => 'Miles Bader',
 'miles:megapathdsl.net' => 'Miles Lane',
 'milli:acmeps.com' => 'Michael Milligan',
 'miltonm:bga.com' => 'Milton Miller', # by Kristian Peters
@@ -1304,6 +1373,7 @@
 'nathans:sgi.com' => 'Nathan Scott',
 'naveenb:cisco.com' => 'Naveen Burmi', # lbdb
 'ncunningham:users.sourceforge.net' => 'Nigel Cunningham',
+'neil:bortnak.com' => 'Neil Bortnak',
 'neilb:cse.unsw.edu.au' => 'Neil Brown',
 'neilt:slimy.greenend.org.uk' => 'Neil Turton',
 'nemosoft:smcc.demon.nl' => 'Nemosoft Unv.',
@@ -1329,11 +1399,13 @@
 'nmiell:attbi.com' => 'Nicholas Miell',
 'noah:caltech.edu' => 'Noah J. Misch',
 'nobita:t-online.de' => 'Andreas Busch',
+'noll:mathematik.tu-darmstadt.de' => 'Andre Noll',
 'noodles:earth.li' => 'Jonathan McDowell',
 'normalperson:yhbt.net' => 'Eric Wong',
 'not:just.any.name' => 'John Fremlin',
 'nstraz:sgi.com' => 'Nathan Straz',
 'ntfs:flatcap.org' => 'Richard Russon', # lbdb
+'numlock:freesurf.ch' => 'Joël Bourquard',
 'nuno:itsari.org' => 'Nuno Monteiro',
 'obelix123:toughguy.net' => 'Raj',		# Hmm..
 'od:suse.de' => 'Olaf Dabrunz',
@@ -1356,6 +1428,7 @@
 'omkhar:rogers.com' => 'Omkhar Arasaratnam',
 'orjan.friberg:axis.com' => 'Orjan Friberg',
 'os:emlix.com' => 'Oskar Schirmer', # sent by himself
+'ossi:kde.org' => 'Oswald Buddenhagen',
 'osst:riede.org' => 'Willem Riede',
 'otaylor:redhat.com' => 'Owen Taylor',
 'ouellettes:videotron.ca' => 'Stephane Ouellette',
@@ -1368,6 +1441,7 @@
 'pablo:menichini.com.ar' => 'Pablo Menichini',
 'pam.delaney:lsil.com' => 'Pamela Delaney',
 'panagiotis.issaris:mech.kuleuven.ac.be' => 'Panagiotis Issaris',
+'panto:intracom.gr' => 'Pantelis Antoniou',
 'paschal:rcsis.com' => 'David Paschal',
 'pasky:ucw.cz' => 'Petr Baudis',
 'pat:computer-refuge.org' => 'Patrick Finnegan',
@@ -1381,8 +1455,10 @@
 'paubert:iram.es' => 'Gabriel Paubert',
 'paul+nospam:wurtel.net' => 'Paul Slootman',
 'paul.clements:steeleye.com' => 'Paul Clements',
+'paul.focke:pandora.be' => 'Paul Focke',
 'paul.mundt:timesys.com' => 'Paul Mundt', # google
 'paul:kungfoocoder.org' => 'Paul Wagland', # lbdb
+'paul:serice.net' => 'Paul Serice',
 'paul:wagland.net' => 'Paul Wagland', # lbdb
 'paulkf:microgate.com' => 'Paul Fulghum',
 'paulm:routefree.com' => 'Paul Mielke',
@@ -1398,6 +1474,7 @@
 'pavel:suse.cz' => 'Pavel Machek',
 'pavel:ucw.cz' => 'Pavel Machek',
 'pavlas:nextra.cz' => 'Zdenek Pavlas',
+'pavlic:de.ibm.com' => 'Frank Pavlic',
 'pavlin:icir.org' => 'Pavlin Radoslavov',
 'pazke:donpac.ru' => 'Andrey Panin',
 'pazke:orbita1.ru' => 'Andrey Panin',
@@ -1460,6 +1537,7 @@
 'pmeda:akamai.com' => 'Prasanna Meda',
 'pmenage:ensim.com' => 'Paul Menage',
 'porter:cox.net' => 'Matt Porter',
+'poup:poupinou.org' => 'Bruno Ducrot',
 'pp:ee.oulu.fi' => 'Pekka Pietikäinen',
 'pp:netppl.fi' => 'Pekka Pietikäinen',
 'ppc64:brule.rchland.ibm.com' => 'Peter Bergner',
@@ -1470,6 +1548,7 @@
 'proski:gnu.org' => 'Pavel Roskin',
 'proski:org.rmk' => 'Pavel Roskin',
 'proski:org.rmk.(none)' => 'Pavel Roskin',
+'psimmons:flash.net' => 'Patrick Simmons',
 'purna:jcom.home.ne.jp' => 'Yusuf Wilajati Purna',
 'pwaechtler:mac.com' => 'Peter Wächtler',
 'q:kampsax.dtu.dk' => 'Dennis Jørgensen',
@@ -1536,6 +1615,7 @@
 'robert.picco:hp.com' => 'Robert Picco',
 'robin.farine:ch.rmk.(none)' => 'Robin Farine',
 'robin.farine:org.rmk.(none)' => 'Robin Farine',
+'robin.jag:free.fr' => 'Gérard Robin',
 'robn:verdi.et.tudelft.nl' => 'Rob van Nieuwkerk',
 'roehrich:sgi.com' => 'Dean Roehrich',
 'rohde:duff.dk' => 'Rasmus Rohde',
@@ -1544,6 +1624,7 @@
 'roland:frob.com' => 'Roland McGrath',
 'roland:redhat.com' => 'Roland McGrath',
 'roland:topspin.com' => 'Roland Dreier',
+'roland:tospin.com' => 'Roland Dreier', # typo
 'romain.lievin:esisar.inpg.fr' => 'Romain Liévin',
 'romain.lievin:wanadoo.fr' => 'Romain Liévin',
 'romain:lievin.net' => 'Romain Liévin',
@@ -1554,6 +1635,8 @@
 'ross:datscreative.com.au' => 'Ross Dickson',
 'rread:clusterfs.com' => 'Robert Read',
 'rscott:attbi.com' => 'Rob Scott',
+'rsewell:cableone.net' => 'Rick Sewell',
+'rsewill:cableone.net' => 'Rick Sewill',
 'rth:are.twiddle.net' => 'Richard Henderson',
 'rth:dorothy.sfbay.redhat.com' => 'Richard Henderson',
 'rth:dot.sfbay.redhat.com' => 'Richard Henderson',
@@ -1572,6 +1655,7 @@
 'russell_d_cagle:mindspring.com' => 'Russell Cagle', # google
 'rusty:linux.co.intel.com' => 'Rusty Lynch',
 'rusty:rustcorp.com.au' => 'Rusty Russell',
+'rv:eychenne.org' => 'Hervé Eychenne',
 'rvinson:linuxbox.(none)' => 'Randy Vinson',
 'rvinson:mvista.com' => 'Randy Vinson',
 'rwhron:earthlink.net' => 'Randy Hron',
@@ -1605,6 +1689,7 @@
 'scole:zianet.com' => 'Steven Cole', # lk, Alan Cox 20030904
 'scott.bailey:eds.com' => 'Scott Bailey',
 'scott.feldman:intel.com' => 'Scott Feldman',
+'scott:concord.org' => 'Scott Cytacki',
 'scott_anderson:mvista.com' => 'Scott Anderson',
 'scottm:minion.yyz.somanetworks.com' => 'Scott Murray',
 'scottm:somanetworks.com' => 'Scott Murray',
@@ -1619,6 +1704,7 @@
 'sebastian.droege:gmx.de' => 'Sebastian Dröge',
 'sebek64:post.cz' => 'Marcel Sebek',
 'set:pobox.com' => 'Paul Thompson',
+'seto.hidetoshi:jp.fujitsu.com' => 'Hidetoshi Seto',
 'sezero:superonline.com' => 'Özkan Sezer',
 'sfbest:us.ibm.com' => 'Steve Best',
 'sfr:au1.ibm.com' => 'Stephen Rothwell',
@@ -1629,12 +1715,15 @@
 'shaggy:kleikamp.dyn.webahead.ibm.com' => 'Dave Kleikamp',
 'shaggy:shaggy.austin.ibm.com' => 'Dave Kleikamp', # lbdb
 'shai:ftcon.com' => 'Shai Fultheim',
+'shbader:de.ibm.com' => 'Stefan Bader',
 'sheilds:msrl.com' => 'Michael Shields', # typo
 'shemminger:osdl.org' => 'Stephen Hemminger',
 'shep:alum.mit.edu' => 'Tim Shepard',
 'shields:msrl.com' => 'Michael Shields',
 'shingchuang:via.com.tw' => 'Shing Chuang',
 'shmulik.hen:intel.com' => 'Shmulik Hen',
+'shurick:sectorb.msk.ru' => 'Alexander V. Inyukhin',
+'siegfried.hildebrand:fernuni-hagen.de' => 'Siegfried Hildebrand',
 'silicon:falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
 'simon:instant802.com' => 'Simon Barber',
 'simon:thekelleys.org.uk' => 'Simon Kelley',
@@ -1642,13 +1731,16 @@
 'skewer:terra.com.br' => 'Marcelo Abreu',
 'skip.ford:verizon.net' => 'Skip Ford',
 'skolodynski:com.rmk.(none)' => 'Slawomir Kolodynski',
+'skraw:ithnet.com' => 'Stephan von Krawczynski',
 'skyrelighten:yahoo.co.kr' => 'Donggyoo Lee',
 'sl:lineo.com' => 'Stuart Lynne',
+'slansky:usa.net' => 'Petr Slansky',
 'smb:smbnet.de' => 'Stefan M. Brandl',
 'smurf:osdl.org' => 'Nathan Dabney',
 'smurf:play.smurf.noris.de' => 'Matthias Urlichs',
 'snailtalk:linux-mandrake.com' => 'Geoffrey Lee', # by himself
 'sneakums:zork.net' => 'Sean Neakums',
+'soete.joel:tiscali.be' => 'Joel Soete',
 'sojka:planetarium.cz' => 'Michal Sojka',
 'solar:openwall.com' => 'Solar Designer',
 'solca:guug.org' => 'Otto Solares',
@@ -1656,6 +1748,7 @@
 'soruk:eridani.co.uk' => 'Michael McConnell',
 'sparker:sun.com' => 'Steven Parker', # by Duncan Laurie
 'sparse:chrisli.org' => 'Christopher Li',
+'spitalnik:penguin.cz' => 'Jan Spitalnik',
 'sprite:sprite.fr.eu.org' => 'Jeremie Koenig',
 'spse:secret.org.uk' => 'Simon Evans', # by Kristian Peters
 'spyro:com.rmk.(none)' => 'Ian Molton',
@@ -1691,6 +1784,7 @@
 'stevef:smfhome.smfdom' => 'Steve French',
 'stevef:smfhome.smfsambadom' => 'Steve French',
 'stevef:smfhome1.austin.rr.com' => 'Steve French',
+'stevef:smfhome1.smfdom' => 'Steve French',
 'stevef:smfhome1.smfsambadom' => 'Steve French',
 'stevef:smfhome2.austin.rr.com' => 'Steve French',
 'stevef:stevef95.austin.ibm.com' => 'Steve French',
@@ -1704,6 +1798,7 @@
 'stuart_hayes:dell.com' => 'Stuart Hayes',
 'stuartm:connecttech.com' => 'Stuart MacDonald',
 'stuber:loria.fr' => 'Jürgen Stuber',
+'sud:latinsud.com' => 'Alex Grijander',
 'sullivan:austin.ibm.com' => 'Mike Sullivan',
 'suncobalt.adm:hostme.bitkeeper.com' => 'Tim Hockin', # by Duncan Laurie
 'sunil.saxena:intel.com' => 'Sunil Saxena',
@@ -1764,6 +1859,7 @@
 'tmcreynolds:nvidia.com' => 'Tom McReynolds',
 'tmolina:cablespeed.com' => 'Thomas Molina',
 'tmolina:cox.net' => 'Thomas Molina',
+'tol:stacken.kth.se' => 'Tomas Olsson',
 'tom.l.nguyen:intel.com' => 'Nguyen, Tom L',
 'tomita:cinet.co.jp' => 'Osamu Tomita',
 'toml:us.ibm.com' => 'Tom Lendacky',
@@ -1777,8 +1873,10 @@
 'tony:cantech.net.au' => 'Anthony J. Breeds-Taurima',
 'tony:com.rmk.(none)' => 'Tony Lindgren',
 'tonyb:cybernetics.com' => 'Tony Battersby',
+'toojays:toojays.net' => 'John Steele Scott',
 'torben.mathiasen:hp.com' => 'Torben Mathiasen',
 'torque:ukrpost.net' => 'Yury Umanets',
+'torsten.scherer:uni-bielefeld.de' => 'Torsten Scherer',
 'torvalds:linux.local' => 'Linus Torvalds',
 'toshihiro.kobayashi:com.rmk.(none)' => 'Toshihiro Kobayashi',
 'tpoynor:mvista.com' => 'Todd Poynor',
@@ -1806,6 +1904,7 @@
 'tytso:think.thunk.org' => "Theodore Y. T'so", # guessed
 'u233:shaw.ca' => 'Trent Whaley',
 'uaca:alumni.uv.es' => 'Ulisses Alonso Camaró',
+'umka:namesys.com' => 'Yury Umanets',
 'urban.widmark:enlight.net' => 'Urban Widmark',
 'urban:teststation.com' => 'Urban Widmark',
 'uwe.bugla:gmx.de' => 'Uwe Bugla',
@@ -1889,13 +1988,17 @@
 'wtogami:redhat.com' => 'Warren Togami',
 'xavier.bru:bull.net' => 'Xavier Bru',
 'xkaspa06:stud.fee.vutbr.cz' => 'Tomas Kasparek',
+'xma:us.ibm.com' => 'Shirley Ma',
 'xose:wanadoo.es' => 'Xose Vazquez Perez', # lbdb
 'xschmi00:stud.feec.vutbr.cz' => 'Michal Schmidt',
 'y.rutschle:com.rmk.(none)' => 'Yves Rutschle',
 'y.rutschle:indigovision.com' => 'Yves Rutschle',
 'ya:slamail.org' => 'Yaacov Akiba Slama',
+'yanmin.zhang:intel.com' => 'Yanmin Zhang',
 'yasuyuki.kozakai:toshiba.co.jp' => 'Yasuyuki Kozakai',
 'yinah:couragetech.com.cn' => 'Yin Aihua',
+'yoav.zach:intel.com' => 'Yoav Zach',
+'yoav_zach:yahoo.com' => 'Yoav Zach',
 'yokota:netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
 'yoshfuji:linux-ipv6.org' => 'Hideaki Yoshifuji', # lbdb
 'yoshfuji:nuts.ninka.net' => 'Hideaki Yoshifuji',
@@ -1904,6 +2007,7 @@
 'yuasa:hh.iij4u.or.jp' => 'Yoichi Yuasa',
 'yuri:acronis.com' => 'Yuri Per', # lbdb
 'zaitcev:redhat.com' => 'Pete Zaitcev',
+'zap:ru.rmk.(none)' => 'Andrew Zabolotny',
 'zdzichu:irc.pl' => 'Tomasz Torcz',
 'zecke:flint.arm.linux.org.uk' => 'Holger Freyther',
 'zecke:org.rmk.(none)' => 'Holger Freyther',
@@ -2250,7 +2354,7 @@
   while($_ = $fh -> getline) {
     chomp;
     # grouped/full mode
-    if (/^<($nre)>:$/) {
+    if (/^<($nre)>:?$/) {
       my $a = $1;
       if ($a =~ /:/) { $a = unveil($a); }
       my $name = rmap_address($a, 1);
@@ -2406,7 +2510,7 @@
       print STDERR "AUTHOR $author\n" if $debug;
       $first = 1;
       $firstpar = 1;
-    } elsif (/^\s+From:\s*"?([^"]*)"?\s+\<(.*)\>\s*$/) {
+    } elsif (/^\s+From:?\s*"?([^"]*)"?\s+\<(.*)\>\s*$/) {
       my $tmp;
       $name = $1;
       $address = lc $2;
@@ -2421,6 +2525,21 @@
       }
       $author = treat_addr_name($address, $name);
       print STDERR " FROM  $author\n" if $debug;
+    } elsif (/^\s+Signed-off-by:\s*"?([^"]*)"?\s+\<(.*)\>\s*$/i) {
+      my $tmp;
+      $name = $1;
+      $address = lc $2;
+      if (($tmp = rmap_address($address, 0)) eq $address) {
+	if ($name =~ /\s+/) {
+	  # not found, but only add if two words or more in name.
+	  $address_found_in_from{$address} = sprintf "'%s' => '%s',",
+	  obfuscate $address, $name;
+	}
+      } else {
+	$name = $tmp;
+      }
+      $author = treat_addr_name($address, $name);
+      print STDERR " SIGNED-OFF-BY  $author\n" if $debug;
     } elsif ($first) {
       # we have a "first" line after an address, take it, 
       # strip common redundant tags

