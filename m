Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264609AbUHJMbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbUHJMbm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:31:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264665AbUHJMbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:31:41 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:6037 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264609AbUHJM0e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:26:34 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.319
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue,_10_Aug_2004_12_26_29_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040810122629.54C84C6A35@merlin.emma.line.org>
Date: Tue, 10 Aug 2004 14:26:29 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.319 has been released.

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
revision 0.319
date: 2004/08/10 12:26:04;  author: emma;  state: Exp;  lines: +2 -2
Add Linus to contributor list.
----------------------------
revision 0.318
date: 2004/08/10 12:19:52;  author: emma;  state: Exp;  lines: +10 -7
Linus Torvalds:
  Add a few names, and make the "signed-off" name have the lowest
  priority. I currently try to make sure that the BK name
  is the right one on anything that has been signed off..
----------------------------
revision 0.317
date: 2004/08/10 12:09:10;  author: emma;  state: Exp;  lines: +5 -5
Minor corrections suggested by vita.
----------------------------
revision 0.316
date: 2004/08/04 09:00:07;  author: emma;  state: Exp;  lines: +152 -1
Add lots of new addresses.
----------------------------
revision 0.315
date: 2004/07/23 11:35:24;  author: vita;  state: Exp;  lines: +3 -1
added 2 new addresses
----------------------------
revision 0.314
date: 2004/07/16 12:51:21;  author: emma;  state: Exp;  lines: +3 -3
Bugfix: do not strip Kishore A K -> K A. Reported by vita.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.314
retrieving revision 0.319
diff -u -r0.314 -r0.319
--- lk-changelog.pl	16 Jul 2004 12:51:21 -0000	0.314
+++ lk-changelog.pl	10 Aug 2004 12:26:04 -0000	0.319
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.314 2004/07/16 12:51:21 emma Exp $
+# $Id: lk-changelog.pl,v 0.319 2004/08/10 12:26:04 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -139,6 +139,8 @@
 undef @addresses_handled_in_regexp;
 
 my %addresses = (
+'33554432:mtu-net.ru' => 'Serge Belyshev',
+'76306.1226:compuserve.com' => 'Chuck Ebbert',
 '_nessuno_:katamail.com' => 'Davide Andrian',
 'a.kasparas:gmc.lt' => 'Aidas Kasparas',
 'a.othieno:bluewin.ch' => 'Arthur Othieno',
@@ -184,6 +186,7 @@
 'aebr:win.tue.nl' => 'Andries E. Brouwer',
 'agk:redhat.com' => 'Alasdair G. Kergon',
 'agl:us.ibm.com' => 'Adam Litke',
+'agoddard:purdue.edu' => 'Alex Goddard',
 'agrover:acpi3.(none)' => 'Andy Grover',
 'agrover:acpi3.jf.intel.com' => 'Andy Grover', # guessed
 'agrover:aracnet.com' => 'Andy Grover',
@@ -225,6 +228,7 @@
 'alain:linux.lu' => 'Alain Knaff',
 'alan:lxorguk.ukuu.org.uk' => 'Alan Cox',
 'alan:redhat.com' => 'Alan Cox',
+'alanh:tungstengraphics.com' => 'Alan Hourihane',
 'albert.cahalan:ccur.com' => 'Albert Cahalan',
 'albert:users.sourceforge.net' => 'Albert Cahalan',
 'albertogli:telpin.com.ar' => 'Alberto Bertogli',
@@ -248,6 +252,7 @@
 'alext:fc.hp.com' => 'Alex Tsariounov',
 'alfre:ibd.es' => 'Alfredo Sanjuán',
 'aliakc:web.de' => 'Ali Akcaagac', # lbdb
+'alsbergt:cs.huji.ac.il' => 'Tom Alsberg',
 'amalysh:web.de' => 'Alexander Malysh',
 'ambx1:com.rmk.(none)' => 'Adam Belay',
 'ambx1:neo.rr.com' => 'Adam Belay',
@@ -260,6 +265,7 @@
 'andikies:t-online.de' => 'Andreas Kies',
 'andmike:us.ibm.com' => 'Mike Anderson', # lbdb
 'andre.breiler:null-mx.org' => 'André Breiler',
+'andre.landwehr:gmx.net' => 'Andre Landwehr',
 'andre:linux-ide.org' => 'Andre Hedrick',
 'andrea:suse.de' => 'Andrea Arcangeli',
 'andreas:xss.co.at' => 'Andreas Haumer',
@@ -268,11 +274,15 @@
 'andrew.vasquez:qlogic.com' => 'Andrew Vasquez',
 'andrew.wood:ivarch.com' => 'Andrew Wood',
 'andrew:com.rmk.(none)' => 'Andrew Victor', # double-check
+'andrew:lunn.ch' => 'Andrew Lunn',
 'andries.brouwer:cwi.nl' => 'Andries E. Brouwer',
 'andros:citi.umich.edu' => 'Andy Adamson',
 'andyw:uk.ibm.com' => 'Andy Whitcroft',
+'aneesh.kumar:digital.com' => 'Aneesh Kumar KV',
 'aneesh.kumar:gmail.com' => 'Aneesh Kumar',
 'angus.sawyer:dsl.pipex.com' => 'Angus Sawyer',
+'aniket:sgi.com' => 'Aniket Malatpure',
+'anil.s.keshavamurthy:intel.com' => 'Anil Keshavamurthy',
 'ankry:green.mif.pg.gda.pl' => 'Andrzej Krzysztofowicz',
 'anton:samba.org' => 'Anton Blanchard',
 'anton:superego.(none)' => 'Anton Blanchard',
@@ -289,6 +299,7 @@
 'arjan:redhat.com' => 'Arjan van de Ven',
 'arjanv:redhat.com' => 'Arjan van de Ven',
 'armcc2000:com.rmk.(none)' => 'Andre McCurdy',
+'armcc2000:yahoo.com' => 'Andre McCurdy',
 'armin:melware.de' => 'Armin Schindler',
 'arnaud.quette:mgeups.com' => 'Arnaud Quette',
 'arnd:arndb.de' => 'Arnd Bergmann',
@@ -298,13 +309,17 @@
 'arubin:atl.lmco.com' => 'Aron Rubin',
 'arun.sharma:intel.com' => 'Arun Sharma',
 'arvidjaar:mail.ru' => 'Andrey Borzenkov',
+'arvind.kan:wipro.com' => 'Arvind Kandhare',
 'arzie:dds.nl' => 'Robert Zwerus',
 'aschultz:warp10.net' => 'Andreas Schultz',
+'asetlur:lucent.com' => 'Anand R. Setlur',
 'ashok.raj:intel.com' => 'Ashok Raj',
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
 'askulysh:image.kiev.ua' => 'Andriy Skulysh',
 'asl:launay.org' => 'Arnaud S. Launay',
+'aso:granite.phys.s.u-tokyo.ac.jp' => 'Youichi Aso',
 'aspicht:arkeia.com' => 'Arnaud Spicht',
+'ast:domdv.de' => 'Andreas Steinmetz',
 'async:cc.gatech.edu' => 'Rob Melby',
 'atul.mukker:lsil.com' => 'Atul Mukker',
 'atulm:lsil.com' => 'Atul Mukker',
@@ -355,6 +370,7 @@
 'bfields:citi.umich.edu' => 'J. Bruce Fields',
 'bfields:fieldses.org' => 'J. Bruce Fields',
 'bgerst:didntduck.org' => 'Brian Gerst',
+'bgerst:quark.didntduck.org' => 'Brian Gerst',
 'bhards:bigpond.net.au' => 'Brad Hards',
 'bhavesh:avaya.com' => 'Bhavesh P. Davda',
 'bheilbrun:paypal.com' => 'Brad Heilbrun', # by himself
@@ -363,6 +379,7 @@
 'bjorn.helgaas:com.rmk.(none)' => 'Bjorn Helgaas',
 'bjorn.helgaas:hp.com' => 'Bjorn Helgaas',
 'bjorn.wesen:axis.com' => 'Bjorn Wesen',
+'bjorn:haxx.se' => 'Bjorn Stenberg',
 'bjorn:mork.no' => 'Bjørn Mork',
 'bjorn_helgaas:hp.com' => 'Bjorn Helgaas',
 'bk:suse.de' => 'Bernhard Kaindl',
@@ -372,10 +389,14 @@
 'bmatheny:purdue.edu' => 'Blake Matheny', # google
 'bogdan.costescu:iwr.uni-heidelberg.de' => 'Bogdan Costescu',
 'bombe:informatik.tu-muenchen.de' => 'Andreas Bombe',
+'boris.hu:intel.com' => 'Boris Hu',
 'borisitk:fortunet.com' => 'Boris Itkis', # by Kristian Peters
+'bos:pathscale.com' => "Bryan O'Sullivan",
 'boutcher:us.ibm.com' => 'Dave Boutcher',
 'braam:clusterfs.com' => 'Peter Braam',
 'brad:wasp.net.au' => 'Brad Campbell',
+'brad_mssw:gentoo.org' => 'Brad House',
+'bram:sara.nl' => 'Bram Stolk',
 'braunu:de.ibm.com' => 'Ursula Braun-Krahl',
 'brazilnut:us.ibm.com' => 'Don Fry',
 'brett:bad-sports.com' => 'Brett Pemberton',
@@ -415,6 +436,7 @@
 'cattelan:naboo.americas.sgi.com' => 'Russell Cattelan',
 'cattelan:naboo.eagan' => 'Russell Cattelan',
 'cattelan:sgi.com' => 'Russell Cattelan', # google
+'cbajumpa:or8.net' => 'Chris Bajumpaa',
 'cborntra:de.ibm.com' => 'Christian Bornträger',
 'ccaputo:alt.net' => 'Chris Caputo',
 'ccheney:cheney.cx' => 'Christopher L. Cheney',
@@ -434,6 +456,7 @@
 'chessman:tux.org' => 'Samuel S. Chessman',
 'chip:pobox.com' => 'Chip Salzenberg', # lbdb
 'chris:heathens.co.nz' => 'Chris Heath',
+'chris:onestepahead.de' => 'Christian Meder',
 'chris:qwirx.com' => 'Chris Wilson',
 'chris:wirex.com' => 'Chris Wright',
 'chrisg:etnus.com' => 'Chris Gottbrath',
@@ -455,10 +478,12 @@
 'cloos:jhcloos.com' => 'James H. Cloos Jr.',
 'cloos:lugabout.jhcloos.org' => 'James H. Cloos Jr.',
 'cltien:cmedia.com.tw' => 'Chen Li Tien',
+'clubneon:hereintown.net' => 'Chris Meadors',
 'cmayor:ca.rmk.(none)' => 'Cam Mayor',
 'cminyard:mvista.com' => 'Corey Minyard',
 'cmm:us.ibm.com' => 'Mingming Cao',
 'cniehaus:handhelds.org' => 'Carsten Niehaus',
+'co2b:ceres.dti.ne.jp' => 'Kouichi Ono',
 'cobra:compuserve.com' => 'Kevin Brosius',
 'cohuck:de.ibm.com' => 'Cornelia Huck',
 'colin:colino.net' => 'Colin Leroy',
@@ -509,6 +534,7 @@
 'daniel.ritz:gmx.ch' => 'Daniel Ritz',
 'daniel:deadlock.et.tudelft.nl' => 'Daniël Mantione',
 'daniel:osdl.org' => 'Daniel McNeil',
+'daniel:rimspace.net' => 'Daniel Pittman',
 'daniela:cyclades.com' => 'Daniela Squassoni',
 'dank:kegel.com' => 'Dan Kegel',
 'danlee:informatik.uni-freiburg.de' => 'Sau Dan Lee',
@@ -537,6 +563,7 @@
 'david:gibson.dropbear.id.au' => 'David Gibson',
 'david_jeffery:adaptec.com' => 'David Jeffery',
 'davidel:xmailserver.org' => 'Davide Libenzi',
+'davidjoerg:web.de' => 'David Jörg',
 'davidm:hpl.hp.com' => 'David Mosberger',
 'davidm:napali.hpl.hp.com' => 'David Mosberger',
 'davidm:tiger.hpl.hp.com' => 'David Mosberger',
@@ -544,6 +571,7 @@
 'davids:youknow.youwant.to' => 'David Schwartz', # google
 'davidvh:cox.net' => 'David van Hoose',
 'davis_g:com.rmk.(none)' => 'George G. Davis',
+'davmac:ozonline.com.au' => 'Davin McCall',
 'dax:gurulabs.com' => 'Dax Kelson',
 'dbrownell:users.sourceforge.net' => 'David Brownell',
 'dcn:sgi.com' => 'Dean Nelson',
@@ -556,6 +584,7 @@
 'delaunay:lix.polytechnique.fr' => 'Eric Delaunay',
 'deller:gmx.de' => 'Helge Deller',
 'dent:cosy.sbg.ac.at' => "Thomas 'Dent' Mirlacher",
+'der.eremit:email.de' => 'Pascal Schmidt',
 'derek:ihtfp.com' => 'Derek Atkins',
 'devel:brodo.de' => 'Dominik Brodowski',
 'devenyga:mcmaster.ca' => 'Gabriel Devenyi',
@@ -569,6 +598,7 @@
 'dhylands:com.rmk.(none)' => 'Dave Hylands',
 'diegocg:teleline.es' => 'Diego Calleja García',
 'dilinger:mp3revolution.net' => 'Andres Salomon',
+'dilinger:voxel.net' => 'Andres Salomon',
 'dipankar:in.ibm.com' => 'Dipankar Sarma',
 'dirk.behme:com.rmk.(none)' => 'Dirk Behme',
 'dirk.behme:de.bosch.com' => 'Dirk Behme',
@@ -591,6 +621,8 @@
 'dolbeau:irisa.fr' => 'Romain Dolbeau',
 'domen:coderock.org' => 'Domen Puncer',
 'dougg:torque.net' => 'Douglas Gilbert',
+'doyle:primenet.com' => 'Bob Doyle',
+'drambo:broadcom.com' => 'Darwin Rambo',
 'drb:med.co.nz' => 'Ross Boswell',
 'drepper:redhat.com' => 'Ulrich Drepper',
 'drewie:freemail.hu' => 'Andras Bali',
@@ -612,8 +644,11 @@
 'dtor_core:ameritech.net' => 'Dmitry Torokhov',
 'ducrot:poupinou.org' => 'Bruno Ducrot',
 'duncan.sands:math.u-psud.fr' => 'Duncan Sands',
+'duncan:sun.com' => 'Duncan Laurie',
+'duwe:suse.de' => 'Torsten Duwe',
 'dvrabel:arcom.com' => 'David Vrabel',
 'dvrabel:com.rmk.(none)' => 'David Vrabel',
+'dwg:au.ibm.com' => 'David Gibson',
 'dwmw2:dwmw2.baythorne.internal' => 'David Woodhouse',
 'dwmw2:infradead.org' => 'David Woodhouse',
 'dwmw2:redhat.com' => 'David Woodhouse',
@@ -630,6 +665,7 @@
 'edward_peng:dlink.com.tw' => 'Edward Peng',
 'edwardsg:sgi.com' => 'Greg Edwards', # google
 'efocht:ess.nec.de' => 'Erich Focht',
+'egallego:telefonica.net' => 'Emilio Gallego Arias',
 'eger:havoc.gtf.org' => 'David Eger',
 'eger:theboonies.us' => 'David Eger',
 'egmont:uhulinux.hu' => 'Egmont Koblinger',
@@ -637,6 +673,7 @@
 'eike-hotplug:sf-tec.de' => 'Rolf Eike Beer',
 'eike-kernel:sf-tec.de' => 'Rolf Eike Beer', # sent by himself
 'eike:bilbo.math.uni-mannheim.de' => 'Rolf Eike Beer',
+'ekonijn:xs4all.nl' => 'Erik van Konijnenburg',
 'elenstev:com.rmk.(none)' => 'Steven Cole',
 'elenstev:mesatop.com' => 'Steven Cole',
 'elf:buici.com' => 'Marc Singer',
@@ -651,10 +688,13 @@
 'engebret:au1.ibm.com' => 'David Engebretsen',
 'engebret:brule.rchland.ibm.com' => 'David Engebretsen',
 'engebret:us.ibm.com' => 'David Engebretsen',
+'engel:us.ibm.com' => 'John Engel',
 'eranian:frankl.hpl.hp.com' => 'Stéphane Eranian',
 'eranian:hpl.hp.co' => 'Stéphane Eranian', # typo
 'eranian:hpl.hp.com' => 'Stéphane Eranian',
+'erbenson:alaska.net' => 'Ethan Benson',
 'eric.piel:bull.net' => 'Eric Piel',
+'eric.valette:free.fr' => 'Eric Valette',
 'eric:lammerts.org' => 'Eric Lammerts',
 'eric:yhbt.net' => 'Eric Wong',
 'erik:aarg.net' => 'Erik Arneson',
@@ -666,11 +706,13 @@
 'erlend-a:ux.his.no' => 'Erlend Aasland',
 'ernstp:mac.com' => 'Ernst Persson', # lbdb
 'errandir_news:mph.eclipse.co.uk' => 'Martin Habets',
+'error27:email.com' => 'Dan Carpenter',
 'eugene.teo:eugeneteo.net' => 'Eugene Teo',
 'eugeneteo:eugeneteo.net' => 'Eugene Teo',
 'evan.felix:pnl.gov' => 'Evan Felix',
 'extreme:zayanionline.com' => 'Vineet Mehta',
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
+'f.duncan.m.haldane:worldnet.att.net' => 'Duncan Haldane',
 'fabian.frederick:skynet.be' => 'Fabian Frederick',
 'faikuygur:tnn.net' => 'Faik Uygur',
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
@@ -679,6 +721,7 @@
 'fb.arm:net.rmk.(none)' => 'Frank Becker',
 'fbecker:com.rmk.(none)' => 'Frank Becker',
 'fbl:conectiva.com.br' => 'Flávio Bruno Leitner', # google
+'fbl:netbank.com.br' => 'Flávio Bruno Leitner',
 'fcusack:fcusack.com' => 'Frank Cusack',
 'fdavis:si.rr.com' => 'Frank Davis',
 'felipe_alfaro:linuxmail.org' => 'Felipe Alfaro Solana',
@@ -708,6 +751,7 @@
 'franz.sirl-kernel:lauterbach.com' => 'Franz Sirl',
 'franz.sirl:lauterbach.com' => 'Franz Sirl',
 'frederik.deweerdt:laposte.net' => 'Frederik Deweerdt',
+'frediano.ziglio:vodafone.com' => 'Frediano Ziglio',
 'frival:zk3.dec.com' => 'Peter Rival',
 'fscked:netvisao.pt' => 'Paulo André',
 'fsgqa:sgi.com' => 'Nathan Scott',
@@ -730,6 +774,7 @@
 'gary_lerhaupt:dell.com' => 'Gary Lerhaupt',
 'garyhade:us.ibm.com' => 'Gary Hade',
 'gbarzini:virata.com' => 'Guido Barzini',
+'gdavis:mvista.com' => 'George G. Davis',
 'geert.uytterhoeven:sonycom.com' => 'Geert Uytterhoeven',
 'geert:linux-m68k.org' => 'Geert Uytterhoeven',
 'geoffrey.levand:am.sony.com' => 'Geoffrey LEVAND',
@@ -751,6 +796,8 @@
 'glee:gnupilgrims.org' => 'Geoffrey Lee', # lbdb
 'glen:imodulo.com' => 'Glen Nakamura',
 'glenn:aoi-industries.com' => 'Glenn Burkhardt',
+'glynis:butterfly.hjsoft.com' => 'John M. Flinchbaugh',
+'gme:citi.umich.edu' => 'Galen Michael Elias',
 'gnb:alphalink.com.au' => 'Greg Banks',
 'gnb:melbourne.sgi.com' => 'Greg Banks',
 'gnb:sgi.com' => 'Greg Banks',
@@ -780,7 +827,9 @@
 'gtw:cs.bu.edu' => 'Gary Wong',
 'guillaume:morinfr.org' => 'Guillaume Morin',
 'gwehrman:sgi.com' => 'Geoffrey Wehrman',
+'gwurster:scs.carleton.ca' => 'Glenn Wurster',
 'h.schurig:de.rmk.(none)' => 'Holger Schurig',
+'h.schurig:mn-logistik.de' => 'Holger Schurig',
 'habanero:us.ibm.com' => 'Andrew Theurer',
 'hadi:cyberus.ca' => 'Jamal Hadi Salim',
 'hadi:shell.cyberus.ca' => 'Jamal Hadi Salim',
@@ -806,6 +855,7 @@
 'hch:pentafluge.infradead.org' => 'Christoph Hellwig',
 'hch:sb.bsdonline.org' => 'Christoph Hellwig', # by Kristian Peters
 'hch:sgi.com' => 'Christoph Hellwig',
+'hduston:speedscript.com' => 'Hal Duston',
 'heiko.carstens:de.ibm.com' => 'Heiko Carstens',
 'helgaas:fc.hp.com' => 'Bjorn Helgaas', # doesn't want ø/å
 'helgaas:hp.com' => 'Bjorn Helgaas', # guessed
@@ -824,6 +874,7 @@
 'hjl:lucon.org' => 'H. J. Lu',
 'hjm:redhat.com' => 'Heinz Mauelshagen', # lbdb
 'hoho:binbash.net' => 'Colin Slater',
+'hollis:austin.ibm.com' => 'Hollis Blanchard',
 'hollisb:us.ibm.com' => 'Hollis Blanchard',
 'holt:sgi.com' => 'Robin Holt',
 'holzheu:de.ibm.com' => 'Michael Holzheu',
@@ -839,11 +890,13 @@
 'hunold:linuxtv.org' => 'Michael Hunold',
 'hverhagen:dse.nl' => 'Harm Verhagen',
 'hwahl:hwahl.de' => 'Hartmut Wahl',
+'hzhong:cisco.com' => 'Hua Zhong',
 'i.palsenberg:jdirmedia.nl' => 'Igmar Palsenberg', # lbdb
 'ian.abbott:mev.co.uk' => 'Ian Abbott',
 'ianw:gelato.unsw.edu.au' => 'Ian Wienand', # lbdb
 'ica2_ts:csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
 'icampbell:com.rmk.(none)' => 'Ian Campbell',
+'icanoop:bitwiser.org' => 'Ryan Boder',
 'ilmari:ilmari.org' => 'Dagfinn Ilmari Mannsåker',
 'inaky.perez-gonzalez:intel.com' => 'Iñaky Pérez-González', # LK 20030829
 'info:gudeads.com' => 'Gude Analog- und Digitalsysteme GmbH',
@@ -859,8 +912,10 @@
 'irohlfs:irohlfs.de' => 'Ingo Rohlfs',
 'ishikawa:linux.or.jp' => 'Mutsumi Ishikawa',
 'ivangurdiev:linuxfreemail.com' => 'Ivan Gyurdiev',
+'iwamoto:valinux.co.jp' => 'Toshihiro Iwamoto',
 'iwi:atm.ox.ac.uk' => 'Alan Iwi',
 'j-nomura:ce.jp.nec.com' => 'Junichi Nomura',
+'j.blunck:tu-harburg.de' => 'Jan Blunck',
 'j.dittmer:portrix.net' => 'Jan Dittmer',
 'ja:ssi.bg' => 'Julian Anastasov',
 'jaap.keuter:xs4all.nl' => 'Jaap Keuter',
@@ -929,6 +984,8 @@
 'jelenz:edu.rmk.(none)' => 'John Lenz',
 'jelenz:students.wisc.edu' => 'John Lenz',
 'jenna.s.hall:intel.com' => 'Jenna S. Hall', # google
+'jeremy:classic.engr.sgi.com' => 'Jeremy Higdon',
+'jeremy:goop.org' => 'Jeremy Fitzhardinge',
 'jeremy:redfishsoftware.com.au' => 'Jeremy Kerr',
 'jeremy:sgi.com' => 'Jeremy Higdon',
 'jermar:itbs.cz' => 'Jakub Jermar',
@@ -954,8 +1011,10 @@
 'jgrimm:touki.qip.austin.ibm.com' => 'Jon Grimm', # google
 'jgt:pobox.com' => 'Jon Thackray',
 'jh:sgi.com' => 'John Hesterberg',
+'jh:suse.cz' => 'Jan Hubicka',
 'jhammer:us.ibm.com' => 'Jack Hammer',
 'jhartmann:addoes.com' => 'Jeff Hartmann',
+'jhe:us.ibm.com' => 'John Engel',
 'jheffner:psc.edu' => 'John Heffner',
 'jhf:rivenstone.net' => 'Joseph Fannin',
 'jhh:lucent.com' => 'Jorge Hernandez-Herrero',
@@ -964,6 +1023,7 @@
 'jim.hague:acm.org' => 'Jim Hague',
 'jim.houston:attbi.com' => 'Jim Houston',
 'jim.houston:comcast.net' => 'Jim Houston',
+'jim:hamachi.net' => 'Jim Collette',
 'jk:ozlabs.org' => 'Jeremy Kerr',
 'jkenisto:us.ibm.com' => 'James Keniston',
 'jkluebs:com.rmk.(none)' => 'John K. Luebs',
@@ -1006,6 +1066,7 @@
 'johnstul:us.ibm.com' => 'John Stultz',
 'jon:ballardtech.com' => 'Jon Neal',
 'jon:focalhost.com' => 'Jon Oberheide',
+'jon:jon-foster.co.uk' => 'Jon Foster',
 'jonas.larsson:net.rmk.(none)' => 'Jonas Larsson',
 'jonas:thornblad.net' => 'Jonas Thornblad',
 'jones:ingate.com' => 'Jones Desougi',
@@ -1014,13 +1075,16 @@
 'joris:struyve.be' => 'Joris Struyve',
 'josh:emperorlinux.com' => 'Josh Litherland',
 'josh:joshisanerd.com' => 'Josh Myer',
+'josha:sgi.com' => 'Josh Aas',
 'joshk:triplehelix.org' => 'Joshua Kwan',
 'jparadis:redhat.com' => 'Jim Paradis',
 'jparmele:wildbear.com' => 'Joseph Parmelee',
 'jpk:sgi.com' => 'Jon Krueger',
 'jrsantos:austin.ibm.com' => 'Jose R. Santos',
 'js189202:zodiac.mimuw.edu.pl' => 'Jerzy Szczepkowski',
+'js:convergence.de' => 'Johannes Stezenbach',
 'jschopp:austin.ibm.com' => 'Joel Schopp',
+'jscross:veritas.com' => 'James Cross',
 'jsiemes:web.de' => 'Josef Siemes',
 'jsimmons:heisenberg.transvirtual.com' => 'James Simmons',
 'jsimmons:infradead.org' => 'James Simmons',
@@ -1038,7 +1102,9 @@
 'juhl-lkml:dif.dk' => 'Jesper Juhl',
 'jun.nakajima:intel.com' => 'Jun Nakajima',
 'jung-ik.lee:intel.com' => 'Jung-Ik Lee',
+'junkio:cox.net' => 'Junio C. Hamano',
 'jurgen:botz.org' => 'Jürgen Botz',
+'jwboyer:charter.net' => 'Josh Boyer',
 'jwoithe:physics.adelaide.edu.au' => 'Jonathan Woithe',
 'k-suganuma:mvj.biglobe.ne.jp' => 'Kimio Suganuma',
 'k.kasprzak:box43.pl' => 'Karol Kasprzak', # by Kristian Peters
@@ -1071,19 +1137,25 @@
 'kaz:earth.email.ne.jp' => 'Kazuto Miyoshi',
 'kazunori:miyazawa.org' => 'Kazunori Miyazawa',
 'kberg:linux1394.org' => 'Steve Kinneberg',
+'kd6pag:qsl.net' => 'John Mock',
+'kde:myrealbox.com' => 'Ismail Donmez',
 'kdesler:soohrt.org' => 'Karsten Desler',
+'kdrader:us.ibm.com' => 'Kurtis D. Rader',
 'keithu:parl.clemson.edu' => 'Keith Underwood',
 'kenn:linux.ie' => 'Kenn Humborg',
 'kenneth.w.chen:intel.com' => 'Kenneth W. Chen',
 'kernel-hacker:bennee.com' => 'Alex Bennee',
+'kernel:axion.demon.nl' => 'Monchi Abbad',
 'kernel:jsl.com' => 'Jeffrey S. Laing',
 'kernel:kolivas.org' => 'Con Kolivas',
+'kernel:linuxace.com' => 'Phil Oester',
 'kernel:steeleye.com' => 'Paul Clements',
 'kettenis:gnu.org' => 'Mark Kettenis',
 'kevcorry:us.ibm.com' => 'Kevin Corry',
 'kevin.curtis:farsite.co.uk' => 'Kevin Curtis',
 'kevin.tian:intel.com' => 'Kevin Tian',
 'kevin:koconnor.net' => 'Kevin O\'Connor',
+'kevin:org.rmk.(none)' => 'Kevin Hilman',
 'kevino:asti-usa.com' => 'Kevin Owen',
 'key:austin.ibm.com' => 'Kent Yoder',
 'khaho:koti.soon.fi' => 'Ari Juhani Hämeenaho',
@@ -1101,11 +1173,16 @@
 'kisza:sch.bme.hu' => 'Andras Kis-Szabo', # google (netfilter-ext HOWTO)
 'kkeil:isdn4linux.de' => 'Karsten Keil',
 'kkeil:suse.de' => 'Karsten Keil',
+'kkourt:cslab.ece.ntua.gr' => 'Kornilios Kourtis',
+'kl:gjs.cc' => 'Gert-Jan Spoelman',
+'klaas.de.waal:hccnet.nl' => 'Klaas de Waal',
 'klassert:mathematik.ru-chemnitz.de' => 'Steffen Klassert', # typo, leave in
 'klassert:mathematik.tu-chemnitz.de' => 'Steffen Klassert',
+'kmannth:us.ibm.com' => 'Keith Mannthey',
 'kml:patheticgeek.net' => 'Kevin Lahey',
 'kmsmith:umich.edu' => 'Kendrick M. Smith',
 'knan:mo.himolde.no' => 'Erik Inge Bolsø',
+'knl_joi:yahoo.com.br' => 'Joilnen Leite',
 'knut_petersen:t-online.de' => 'Knut Petersen',
 'kochi:hpc.bs1.fc.nec.co.jp' => 'Kochi Takayoshi',
 'kolya:mit.edu' => 'Nickolai Zeldovich',
@@ -1115,6 +1192,7 @@
 'kpfleming:cox.net' => 'Kevin P. Fleming',
 'kraxel:bytesex.org' => 'Gerd Knorr',
 'kraxel:suse.de' => 'Gerd Knorr',
+'krh:bitplanet.net' => 'Kristian Høgsberg',
 'krishnakumar:naturesoft.net' => 'Krishna Kumar',
 'krkumar:us.ibm.com' => 'Krishna Kumar',
 'kronos:kronoz.cjb.net' => 'Luca Tettamanti',
@@ -1166,6 +1244,7 @@
 'linux-kernel:vortech.net' => 'Joshua Jackson',
 'linux-usb:gemeinhardt.info' => 'Lars Gemeinhardt',
 'linux-usb:nerds-incorporated.org' => 'Sepp Wijnands',
+'linux:borntraeger.net' => 'Christian Bornträger',
 'linux:brodo.de' => 'Dominik Brodowski',
 'linux:de.rmk.(none)' => 'Dominik Brodowski',
 'linux:de.rmk.(none2)' => 'Sebastian Henschel',
@@ -1177,6 +1256,7 @@
 'linux:thorsten-knabe.de' => 'Thorsten Knabe',
 'linux:youmustbejoking.demon.co.uk' => 'Darren Salt',
 'linuxram:us.ibm.com' => 'Ram Pai',
+'linville:redhat.com' => 'John Linville',
 'lionel.bouton:inet6.fr' => 'Lionel Bouton',
 'lists:mdiehl.de' => 'Martin Diehl',
 'livio:ime.usp.br' => 'Livio Baldini Soares',
@@ -1196,6 +1276,7 @@
 'lord:penguin.americas.sgi.com' => 'Stephen Lord',
 'lord:sgi.com' => 'Stephen Lord',
 'louis.zhuang:linux.co.intel.com' => 'Louis Zhuang',
+'louis_zhuang:linux.co.intel.com' => 'Louis Zhuang',
 'louisk:cse.unsw.edu.au' => 'Louis Yu-Kiu Kwan',
 'lowekamp:cs.wm.edu' => 'Bruce B. Lowekamp', # lbdb
 'luben:splentec.com' => 'Luben Tuikov',
@@ -1216,10 +1297,12 @@
 'mac:melware.de' => 'Armin Schindler',
 'macro:ds2.pg.dga.pl' => 'Maciej W. Rozycki',
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
+'macro:linux-mips.org' => 'Maciej W. Rozycki',
 'maeda.naoaki:jp.fujitsu.com' => 'Maeda Naoaki',
 'mail:de.rmk.(none)' => 'Peter Teichmann',
 'mail:gude.info' => 'Gude Analog- und Digitalsysteme GmbH',
 'mail:s-holst.de' => 'Stefan Holst',
+'maillist:jg555.com' => 'Jim Gifford',
 'makisara:abies.metla.fi' => 'Kai Mäkisara',
 'makovick:kmlinux.fjfi.cvut.cz' => 'Jindrich Makovicka',
 'maloi:phota.to' => 'Andy Molloy',
@@ -1242,6 +1325,7 @@
 'marcelo:plucky.distro.conectiva' => 'Marcelo Tosatti',
 'marchand:kde.org' => 'Mickael Marchand',
 'marco.cova:studio.unibo.it' => 'Marco Cova',
+'marcus:infa.abo.fi' => 'Marcus Alanen',
 'marcus:ingate.com' => 'Marcus Sundberg',
 'marekm:amelek.gda.pl' => 'Marek Michalkiewicz',
 'margitsw:t-online.de' => 'Margit Schubert-While',
@@ -1269,6 +1353,7 @@
 'maschaffner:gmx.ch' => 'Martin Schaffner',
 'mashirle:us.ibm.com' => 'Shirley Ma',
 'mason:suse.com' => 'Chris Mason',
+'master:sectorb.msk.ru' => 'Vladimir B. Savkin',
 'mathieu:newview.com' => 'Mathieu Chouquet-Stringer',
 'matt_domsch:dell.com' => 'Matt Domsch', # sent by himself
 'matthew:wil.cx' => 'Matthew Wilcox',
@@ -1283,12 +1368,14 @@
 'mb:ozaba.mine.nu' => 'Magnus Boden',
 'mbligh:aracnet.com' => 'Martin J. Bligh',
 'mbp:samba.org' => 'Martin Pool', # lbdb
+'mbp:sourcefrog.net' => 'Martin Pool',
 'mbp:vexed.ozlabs.hp.com' => 'Martin Pool',
 'mbuesch:freenet.de' => 'Michael Buesch',
 'mcgrof:ruslug.rutgers.edu' => 'Luis R. Rodriguez',
 'mcgrof:studorgs.rutgers.edu' => 'Luis R. Rodriguez',
 'mchan:broadcom.com' => 'Michael Chan',
 'mchouque:online.fr' => 'Mathieu Chouquet-Stringer',
+'mckellj:iomega.com' => 'John McKell',
 'mcp:linux-systeme.de' => 'Marc-Christian Petersen',
 'mdharm-scsi:one-eyed-alien.net' => 'Matthew Dharm',
 'mdharm-usb:one-eyed-alien.net' => 'Matthew Dharm',
@@ -1308,12 +1395,16 @@
 'mhf:linuxmail.org' => 'Michael Frank',
 'mhoffman:lightlink.com' => 'Mark M. Hoffman',
 'mhopf:innominate.com' => 'Mark-André Hopf',
+'mhtran:us.ibm.com' => 'Mike Tran',
 'mhuth:mvista.com' => 'Mark Huth',
+'michael.kerrisk:gmx.net' => 'Michael Kerrisk',
 'michael.krauth:web.de' => 'Michael Krauth',
+'michael.ni:hp.com' => 'Michael Ni',
 'michael.veeck:gmx.net' => 'Michael Veeck',
 'michael.waychison:sun.com' => 'Mike Waychison',
 'michael:metaparadigm.com' => 'Michael Clark',
 'michael_e_brown:dell.com' => 'Michael E. Brown', # lbdb
+'michael_pruznick:mvista.com' => 'Michael Pruznick',
 'michaelc:cs.wisc.edu' => 'Mike Christie', # lbdb
 'michaelw:foldr.org' => 'Michael Weber', # google
 'michal:harddata.com' => 'Michal Jaegermann',
@@ -1330,6 +1421,7 @@
 'mikem:beardog.cca.cpqcorp.net' => 'Mike Miller',
 'mikenc:us.ibm.com' => 'Mike Christie',
 'mikep:linuxtr.net' => 'Mike Phillips',
+'miklos:szeredi.hu' => 'Miklos Szeredi',
 'mikpe:csd.uu.se' => 'Mikael Pettersson',
 'mikpe:user.it.uu.se' => 'Mikael Pettersson',
 'mikulas:artax.karlin.mff.cuni.cz' => 'Mikulas Patocka',
@@ -1338,7 +1430,8 @@
 'miles:mctpc71.ucom.lsi.nec.co.jp' => 'Miles Bader',
 'miles:megapathdsl.net' => 'Miles Lane',
 'milli:acmeps.com' => 'Michael Milligan',
-'miltonm:bga.com' => 'Milton Miller', # by Kristian Peters
+'miltonm:bga.com' => 'Milton D. Miller II',
+'miltonm:realtime.net' => 'Milton D. Miller II',
 'mingo:earth2.(none)' => 'Ingo Molnar',
 'mingo:elte.hu' => 'Ingo Molnar',
 'mingo:redhat.com' => 'Ingo Molnar',
@@ -1347,7 +1440,9 @@
 'mirage:kaotik.org' => 'Tiago Sousa',
 'mitch:sfgoth.com' => 'Mitchell Blank Jr.',
 'miura:da-cha.org' => 'Hiroshi Miura',
+'miurahr:nttdata.co.jp' => 'Hiroshi Miura',
 'miyazawa:linux-ipv6.org' => 'Kazunori Miyazawa',
+'miyoshi:hpc.bs1.fc.nec.co.jp' => 'Kazuto Miyoshi',
 'mj:ucw.cz' => 'Martin Mares',
 'mk:linux-ipv6.org' => 'Mitsuru Kanda',
 'mkp:mkp.net' => 'Martin K. Petersen', # lbdb
@@ -1377,6 +1472,7 @@
 'mostrows:watson.ibm.com' => 'Michal Ostrowski',
 'movits:bloomberg.com' => 'Mordechai Ovits',
 'moz:compsoc.man.ac.uk' => 'John Levon',
+'mplayer:jburgess.uklinux.net' => 'Jon Burgess',
 'mpm:selenic.com' => 'Matt Mackall',
 'mporter:cox.net' => 'Matt Porter',
 'mporter:kernel.crashing.org' => 'Matt Porter',
@@ -1393,20 +1489,25 @@
 'my:post.utfors.se' => 'Mikael Ylikoski',
 'mzyngier:freesurf.fr' => 'Marc Zyngier',
 'n0ano:n0ano.com' => 'Don Dugger',
+'nacc:us.ibm.com' => 'Nishanth Aravamudan',
 'nahshon:actcom.co.il' => 'Itai Nahshon',
 'nakam:linux-ipv6.org' => 'Masahide Nakamura',
+'nanhai.zou:intel.com' => 'Zou Nanhai',
 'natalie.protasevich:unisys.com' => 'Natalie Protasevich',
 'nathanl:austin.ibm.com' => 'Nathan Lynch',
 'nathans:bruce.melbourne.sgi.com' => 'Nathan Scott',
 'nathans:sgi.com' => 'Nathan Scott',
 'naveenb:cisco.com' => 'Naveen Burmi', # lbdb
 'ncunningham:users.sourceforge.net' => 'Nigel Cunningham',
+'neal:bakerst.org' => 'Neal Stephenson',
 'neil:bortnak.com' => 'Neil Bortnak',
 'neilb:cse.unsw.edu.au' => 'Neil Brown',
 'neilt:slimy.greenend.org.uk' => 'Neil Turton',
 'nemosoft:smcc.demon.nl' => 'Nemosoft Unv.',
 'netfilter:interlinx.bc.ca' => 'Brian J. Murrell',
+'nfont:austin.ibm.com' => 'Nathan Fontenot',
 'nick.holloway:pyrites.org.uk' => 'Nick Holloway',
+'nickpiggin:cyberone.com.au' => 'Nick Piggin',
 'nickpiggin:yahoo.com.au' => 'Nick Piggin',
 'nico:cam.org' => 'Nicolas Pitre',
 'nico:org.rmk' => 'Nicolas Pitre',
@@ -1434,6 +1535,7 @@
 'notting:redhat.com' => 'Bill Nottingham',
 'nstraz:sgi.com' => 'Nathan Straz',
 'ntfs:flatcap.org' => 'Richard Russon', # lbdb
+'ntl:pobox.com' => 'Nathan T. Lynch',
 'numlock:freesurf.ch' => 'Joël Bourquard',
 'nuno:itsari.org' => 'Nuno Monteiro',
 'obelix123:toughguy.net' => 'Raj',		# Hmm..
@@ -1463,6 +1565,7 @@
 'otaylor:redhat.com' => 'Owen Taylor',
 'ouellettes:videotron.ca' => 'Stephane Ouellette',
 'overby:sgi.com' => 'Glen Overby',
+'oxymoron:waste.org' => 'Oliver Xymoron',
 'p.guehring:futureware.at' => 'Philipp Gühring',
 'p.lavarre:ieee.org' => 'Pat LaVarre',
 'p2:ace.ulyssis.sutdent.kuleuven.ac.be' => 'Peter De Shrijver',
@@ -1494,6 +1597,7 @@
 'paulkf:microgate.com' => 'Paul Fulghum',
 'paulm:routefree.com' => 'Paul Mielke',
 'paulmck:us.ibm.com' => 'Paul E. McKenney',
+'paulsch:haywired.net' => 'Paul B. Schroeder',
 'paulus:au1.ibm.com' => 'Paul Mackerras',
 'paulus:cargo.(none)' => 'Paul Mackerras',
 'paulus:nanango.paulus.ozlabs.org' => 'Paul Mackerras',
@@ -1552,10 +1656,12 @@
 'petrides:redhat.com' => 'Ernie Petrides',
 'pfg:sgi.com' => 'Pat Gefre',
 'pg:futureware.at' => 'Philipp Gühring',
+'phelps:dstc.edu.au' => 'Ted Phelps',
 'phil.el:wanadoo.fr' => 'Philippe Elie',
 'philipc:snapgear.com' => 'Philip Craig',
 'philipp:void.at' => 'Philipp Friedrich',
 'phillim2:comcast.net' => 'Mike Phillips',
+'phillips:arcor.de' => 'Daniel Phillips',
 'piggin:cyberone.com.au' => 'Nick Piggin',
 'piggy:timesys.com' => 'La Monte H.P. Yarroll',
 'pixi:burble.org' => 'Maurice S. Barnum',
@@ -1568,15 +1674,19 @@
 'pluto:pld-linux.org' => 'Pawel Sikora',
 'pmanolov:lnxw.com' => 'Petko Manolov',
 'pmarques:grupopie.com' => 'Paulo Marques',
+'pmclean:linuxfreak.ca' => 'Patrick McLean',
 'pmeda:akamai.com' => 'Prasanna Meda',
 'pmenage:ensim.com' => 'Paul Menage',
+'pontus.fuchs:tactel.se' => 'Pontus Fuchs',
 'porter:cox.net' => 'Matt Porter',
 'poup:poupinou.org' => 'Bruno Ducrot',
 'pp:ee.oulu.fi' => 'Pekka Pietikäinen',
 'pp:netppl.fi' => 'Pekka Pietikäinen',
 'ppc64:brule.rchland.ibm.com' => 'Peter Bergner',
+'pragnesh.sampat:timesys.com' => 'Pragnesh Sampat',
 'praka:users.sourceforge.net' => 'Andrew Vasquez',
 'prasanna:in.ibm.com' => 'Prasanna S. Panchamukhi', # lbdb
+'pratik.solanki:timesys.com' => 'Pratik Solanki',
 'prof.bj:freemail.hu' => 'Prof. BJ',
 'prom:berlin.ccc.de' => 'Ingo Albrecht',
 'proski:gnu.org' => 'Pavel Roskin',
@@ -1595,19 +1705,23 @@
 'r.a.mercer:blueyonder.co.uk' => 'Adam Mercer',
 'r.e.wolff:bitwizard.nl' => 'Rogier Wolff', # lbdb
 'r.s.bultje:students.uu.nl' => 'Ronald S. Bultje',
+'radford:indigita.com' => 'Jim Radford',
 'ralf:dea.linux-mips.net' => 'Ralf Bächle',
 'ralf:linux-mips.org' => 'Ralf Bächle',
 'ralphs:org.rmk.(none)' => 'Ralph Siemsen',
+'ramon.rey:hispalinux.es' => 'Ramón Rey Vicente',
 'ramune:net-ronin.org' => 'Daniel A. Nobuto',
 'randolph:tausq.org' => 'Randolph Chung',
 'randy.dunlap:verizon.net' => 'Randy Dunlap',
 'ranty:debian.org' => 'Manuel Estrada Sainz',
+'ranty:ranty.pantax.net' => 'Manuel Estrada Sainz',
 'rask:sygehus.dk' => 'Rask Ingemann Lambertsen',
 'rathamahata:php4.ru' => 'Sergey S. Kostyliov',
 'raul:pleyades.net' => 'Raul Nunez de Arenas Coronado',
 'raven:themaw.net' => 'Ian Kent',
 'ray-lk:madrabbit.org' => 'Ray Lee',
 'rbh00:utsglobal.com' => 'Richard Hitt', # asked him, he prefers Richard
+'rbradetich:uswest.net' => 'Ryan Bradetich',
 'rbt:mtlb.co.uk' => 'Robert Cardell',
 'rbultje:ronald.bitfreak.net' => 'Ronald Bultje',
 'rct:gherkin.frus.com' => 'Bob Tracy',
@@ -1624,6 +1738,7 @@
 'rgooch:atnf.csiro.au' => 'Richard Gooch',
 'rgooch:ras.ucalgary.ca' => 'Richard Gooch',
 'rgs:linalco.com' => 'Roberto Gordo Saez',
+'rhim:cc.gatech.edu' => 'Himanshu Raj',
 'rhirst:linuxcare.com' => 'Richard Hirst',
 'rhw:infradead.org' => 'Riley Williams',
 'richard.brunner:amd.com' => 'Richard Brunner',
@@ -1636,6 +1751,7 @@
 'rjweryk:uwo.ca' => 'Rob Weryk',
 'rl:hellgate.ch' => 'Roger Luethi',
 'rlievin:free.fr' => 'Romain Liévin',
+'rmiller:duskglow.com' => 'Russell Miller',
 'rmk+lkml:arm.linux.org.uk' => 'Russell King',
 'rmk+pcmcia:arm.linux.org.uk' => 'Russell King',
 'rmk-pci:arm.linux.org.uk' => 'Russell King',
@@ -1664,11 +1780,17 @@
 'romain.lievin:wanadoo.fr' => 'Romain Liévin',
 'romain:lievin.net' => 'Romain Liévin',
 'romain:orebokech.com' => 'Romain Francoise',
+'roman.fietze:telemotive.de' => 'Roman Fietze',
 'romieu:cogenit.fr' => 'François Romieu',
 'romieu:fr.zoreil.com' => 'François Romieu',
+'ron:rongage.org' => 'Ron Gage',
+'root:coderock.org' => 'Domen Puncer',
 'root:viper.(none)' => 'Maxim Krasnyansky',
 'ross:datscreative.com.au' => 'Ross Dickson',
+'rostedt:goodmis.org' => 'Steven Rostedt',
+'rover:tob.ru' => 'Sergei Golod',
 'rread:clusterfs.com' => 'Robert Read',
+'rsa:us.ibm.com' => 'Ryan S. Arnold',
 'rscott:attbi.com' => 'Rob Scott',
 'rsewell:cableone.net' => 'Rick Sewell',
 'rsewill:cableone.net' => 'Rick Sewill',
@@ -1688,8 +1810,10 @@
 'rtjohnso:eecs.berkeley.edu' => 'Robert T. Johnson',
 'rui.sousa:laposte.net' => 'Rui Sousa',
 'russell_d_cagle:mindspring.com' => 'Russell Cagle', # google
+'rusty:au1.ibm.com' => 'Rusty Russell',
 'rusty:linux.co.intel.com' => 'Rusty Lynch',
 'rusty:rustcorp.com.au' => 'Rusty Russell',
+'rusty:stinkycat.com' => 'Rusty Lynch',
 'rv:eychenne.org' => 'Hervé Eychenne',
 'rvinson:linuxbox.(none)' => 'Randy Vinson',
 'rvinson:mvista.com' => 'Randy Vinson',
@@ -1704,6 +1828,7 @@
 'sam:ravnborg.org' => 'Sam Ravnborg',
 'samel:mail.cz' => 'Vitezslav Samel',
 'samuel.thibault:ens-lyon.fr' => 'Samuel Thibault',
+'samuel.thibault:ens-lyon.org' => 'Samuel Thibault',
 'samuel.thibault:fnac.net' => 'Samuel Thibault', # lbdb
 'samuel:ibrium.se' => 'Samuel Rydh',
 'sandeen:sgi.com' => 'Eric Sandeen',
@@ -1725,6 +1850,7 @@
 'scott.bailey:eds.com' => 'Scott Bailey',
 'scott.feldman:intel.com' => 'Scott Feldman',
 'scott:concord.org' => 'Scott Cytacki',
+'scott:pantastik.com' => 'Scott Russell',
 'scott_anderson:mvista.com' => 'Scott Anderson',
 'scottm:minion.yyz.somanetworks.com' => 'Scott Murray',
 'scottm:somanetworks.com' => 'Scott Murray',
@@ -1745,11 +1871,13 @@
 'sfbest:us.ibm.com' => 'Steve Best',
 'sfr:au1.ibm.com' => 'Stephen Rothwell',
 'sfr:canb.auug.org.au' => 'Stephen Rothwell',
+'sfrench:us.ibm.com' => 'Steve French',
 'sfrost:snowman.net' => 'Stephen Frost',
 'shaggy:austin.ibm.com' => 'Dave Kleikamp',
 'shaggy:kleikamp.austin.ibm.com' => 'Dave Kleikamp',
 'shaggy:kleikamp.dyn.webahead.ibm.com' => 'Dave Kleikamp',
 'shaggy:shaggy.austin.ibm.com' => 'Dave Kleikamp', # lbdb
+'shahamit:gmx.net' => 'Amit Shah',
 'shai:ftcon.com' => 'Shai Fultheim',
 'shbader:de.ibm.com' => 'Stefan Bader',
 'sheilds:msrl.com' => 'Michael Shields', # typo
@@ -1758,9 +1886,13 @@
 'shields:msrl.com' => 'Michael Shields',
 'shingchuang:via.com.tw' => 'Shing Chuang',
 'shmulik.hen:intel.com' => 'Shmulik Hen',
+'shoujun:masterofpi.org' => 'Timmy Yee',
+'shrybman:sympatico.ca' => 'Shane Shrybman',
+'shrybman:aei.ca' => 'Shane Shrybman',
 'shurick:sectorb.msk.ru' => 'Alexander V. Inyukhin',
 'siegfried.hildebrand:fernuni-hagen.de' => 'Siegfried Hildebrand',
 'silicon:falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
+'simcha:chatka.org' => 'Jan Topinski',
 'simon:instant802.com' => 'Simon Barber',
 'simon:thekelleys.org.uk' => 'Simon Kelley',
 'simonb:lipsyncpost.co.uk' => 'Simon Burley',
@@ -1771,6 +1903,8 @@
 'skyrelighten:yahoo.co.kr' => 'Donggyoo Lee',
 'sl:lineo.com' => 'Stuart Lynne',
 'slansky:usa.net' => 'Petr Slansky',
+'sleddog:us.ibm.com' => 'Dave Boutcher',
+'sluskyb:paranoiacs.org' => 'Ben Slusky',
 'smb:smbnet.de' => 'Stefan M. Brandl',
 'smurf:osdl.org' => 'Nathan Dabney',
 'smurf:play.smurf.noris.de' => 'Matthias Urlichs',
@@ -1782,11 +1916,13 @@
 'solca:guug.org' => 'Otto Solares',
 'solt:dns.toxicfilms.tv' => 'Maciej Soltysiak',
 'soruk:eridani.co.uk' => 'Michael McConnell',
+'sparclinux:abeckmann.de' => 'Andreas Beckmann',
 'sparker:sun.com' => 'Steven Parker', # by Duncan Laurie
 'sparse:chrisli.org' => 'Christopher Li',
 'spitalnik:penguin.cz' => 'Jan Spitalnik',
 'sprite:sprite.fr.eu.org' => 'Jeremie Koenig',
 'spse:secret.org.uk' => 'Simon Evans', # by Kristian Peters
+'spstarr:sh0n.net' => 'Shawn Starr',
 'spyro:com.rmk.(none)' => 'Ian Molton',
 'spyro:f2s.com' => 'Ian Molton',
 'src:flint.arm.linux.org.uk' => 'Russell King',
@@ -1806,6 +1942,7 @@
 'stelian.pop:fr.alcove.com' => 'Stelian Pop',
 'stelian:popies.net' => 'Stelian Pop',
 'stephane.galles:free.fr' => 'Stephane Galles', # guessed
+'stephanm:muc.de' => 'Stephan Maciej',
 'stephen:phynp6.phy-astr.gsu.edu' => 'Stephen Leonard',
 'stern:rowland.harvard.edu' => 'Alan Stern',
 'stern:rowland.org' => 'Alan Stern', # lbdb
@@ -1829,6 +1966,8 @@
 'stewart:inverse.wetlogic.net' => 'Paul Stewart',
 'stewart:linux.org.au' => 'Stewart Smith',
 'stewart:wetlogic.net' => 'Paul Stewart',
+'stewartsmith:mac.com' => 'Stewart Smith',
+'stoffel:lucent.com' => 'John Stoffel',
 'strosake:us.ibm.com' => 'Michael Strosaker',
 'stsp:aknet.ru' => 'Stas Sergeev',
 'stuart_hayes:dell.com' => 'Stuart Hayes',
@@ -1850,6 +1989,8 @@
 'szuk:telusplanet.net' => 'Scott Zuk',
 't-kochi:bq.jp.nec.com' => 'Takayoshi Kochi', # not a typo
 't-kouchi:mvf.biglobe.ne.jp' => 'Takayoshi Kouchi',
+'t:timothyparkinson.com' => 'Timothy Parkinson',
+'tadavis:lbl.gov' => 'Thomas Davis',
 'tai:imasy.or.jp' => 'Taisuke Yamada',
 'taka:valinux.co.jp' => 'Hirokazu Takahashi',
 'takamiya:po.ntts.co.jp' => 'Noriaki Takamiya',
@@ -1882,6 +2023,8 @@
 'thomr9am:ss1000.ms.mff.cuni.cz' => 'Rudo Thomas',
 'thornber:redhat.com' => 'Joe Thornber',
 'thornber:sistina.com' => 'Joe Thornber',
+'thunder7:xs4all.nl' => 'Jurriaan Kalkman',
+'thunder:keepsake.ch' => 'Tonnerre Anklin',
 'thunder:ngforever.de' => 'Thunder From The Hill',
 'tigran:aivazian.name' => 'Tigran Aivazian',
 'tigran:veritas.com' => 'Tigran Aivazian',
@@ -1896,6 +2039,7 @@
 'tmcreynolds:nvidia.com' => 'Tom McReynolds',
 'tmolina:cablespeed.com' => 'Thomas Molina',
 'tmolina:cox.net' => 'Thomas Molina',
+'tnt:246tnt.com' => 'Sylvain Munaut',
 'tol:stacken.kth.se' => 'Tomas Olsson',
 'tom.l.nguyen:intel.com' => 'Tom L. Nguyen',
 'tomd:csds.uidaho.edu' => 'Thomas DuBuisson',
@@ -1925,11 +2069,13 @@
 'trini:mvista.com' => 'Tom Rini',
 'trini:opus.bloom.county' => 'Tom Rini',
 'trini:org.rmk.(none)' => 'Tom Rini',
+'tripperda:nvidia.com' => 'Terence Ripperda',
 'tritol:trilogic.cz' => 'Lubomír Bláha',
 'trivial:rustcorp.com.au' => 'Rusty Russell',
 'trond.myklebust:fys.uio.no' => 'Trond Myklebust',
 'tsk:ibakou.com' => 'Kawazoe Tomonori',
 'tspat:de.ibm.com' => 'Thomas Spatzier',
+'ttodorov:web.de' => 'Todor Todorov',
 'tuncer.ayaz:gmx.de' => 'Tuncer M. Zayamut Ayaz', # lbdb
 'tv:debian.org' => 'Tommi Virtanen',
 'tv:tv.debian.net' => 'Tommi Virtanen',
@@ -1945,6 +2091,7 @@
 'umka:namesys.com' => 'Yury Umanets',
 'urban.widmark:enlight.net' => 'Urban Widmark',
 'urban:teststation.com' => 'Urban Widmark',
+'uros:kss-loka.si' => 'Uros Bizjak',
 'utz.bacher:de.ibm.com' => 'Utz Bacher',
 'uwe.bugla:gmx.de' => 'Uwe Bugla',
 'uwe.koziolek:gmx.net' => 'Uwe Koziolek',
@@ -1968,6 +2115,7 @@
 'vince:kyllikki.org' => 'Vincent Sanders',
 'vinsci:floss.(none)' => 'Leonard Norrgard',
 'viro:math.psu.edu' => 'Alexander Viro',
+'viro:parcelfarce.linux.org.uk' => 'Alexander Viro',
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'viro:www.linux.org.uk' => 'Alexander Viro',
 'vmlinuz386:yahoo.com.ar' => 'Gerardo Exequiel Pozzi', # lbdb
@@ -1978,6 +2126,7 @@
 'vojtech:suse.cz' => 'Vojtech Pavlik',
 'vojtech:twilight.ucw.cz' => 'Vojtech Pavlik',
 'vojtech:ucw.cz' => 'Vojtech Pavlik', # added by himself
+'vrajesh:eecs.umich.edu' => 'Rajesh Venkatasubramanian',
 'vrajesh:umich.edu' => 'Rajesh Venkatasubramanian',
 'vs:tribesman.namesys.com' => 'Vladimir Saveliev',
 'vsu:altlinux.ru' => 'Sergey Vlasov',
@@ -2000,14 +2149,17 @@
 'wein:de.ibm.com' => 'Stefan Weinhuber',
 'wellnhofer:aevum.de' => 'Nick Wellnhofer',
 'wensong:linux-vs.org' => 'Wensong Zhang',
+'werner:almesberger.net' => 'Werner Almesberger',
 'wes:infosink.com' => 'Wes Schreiner',
 'wesolows:foobazco.org' => 'Keith M. Wesolowski',
 'wessmith:sgi.com' => 'Wesley Smith',
+'wfg:mail.ustc.edu.cn' => 'Fengguang Wu',
 'wg:malloc.de' => 'Wolfram Gloger', # lbdb
 'wharms:bfs.de' => 'Walter Harms',
 'whitney:math.berkeley.edu' => 'Wayne Whitney',
 'whydoubt:yahoo.com' => 'Jeff Smith',
 'will:sowerbutts.com' => 'William R. Sowerbutts',
+'will_dyson:pobox.com' => 'Will Dyson',
 'willschm:us.ibm.com' => 'Will Schmidt',
 'willy:debian.org' => 'Matthew Wilcox',
 'willy:fc.hp.com' => 'Matthew Wilcox',
@@ -2027,6 +2179,7 @@
 'wstinson:infonie.fr' => 'William Stinson',
 'wstinson:wanadoo.fr' => 'William Stinson',
 'wtogami:redhat.com' => 'Warren Togami',
+'xavier.bestel:free.fr' => 'Xavier Bestel',
 'xavier.bru:bull.net' => 'Xavier Bru',
 'xkaspa06:stud.fee.vutbr.cz' => 'Tomas Kasparek',
 'xma:us.ibm.com' => 'Shirley Ma',
@@ -2037,6 +2190,7 @@
 'ya:slamail.org' => 'Yaacov Akiba Slama',
 'yanmin.zhang:intel.com' => 'Yanmin Zhang',
 'yasuyuki.kozakai:toshiba.co.jp' => 'Yasuyuki Kozakai',
+'yi.zhu:intel.com' => 'Yi Zhu',
 'yinah:couragetech.com.cn' => 'Yin Aihua',
 'yoav.zach:intel.com' => 'Yoav Zach',
 'yoav_zach:yahoo.com' => 'Yoav Zach',
@@ -2048,10 +2202,12 @@
 'yuasa:hh.iij4u.or.jp' => 'Yoichi Yuasa',
 'yuri:acronis.com' => 'Yuri Per', # lbdb
 'zaitcev:redhat.com' => 'Pete Zaitcev',
+'zap:homelink.ru' => 'Andrew Zabolotny',
 'zap:ru.rmk.(none)' => 'Andrew Zabolotny',
 'zdzichu:irc.pl' => 'Tomasz Torcz',
 'zecke:flint.arm.linux.org.uk' => 'Holger Freyther',
 'zecke:org.rmk.(none)' => 'Holger Freyther',
+'zeevon:debian.org' => 'Warren A. Layton',
 'zinx:epicsol.org' => 'Zinx Verituse',
 'zippel:linux-m68k.org' => 'Roman Zippel',
 'zli4:cs.uiuc.edu' => 'Zhenmin Li',
@@ -2537,15 +2693,15 @@
   my @cur = ();
   my $first = 0;
   my $firstpar = 0;
-  my $namepref = 0; # where address is from
-  # 0 - BK; 1 - Signed-off-by; 2 - From
+  my $namepref = 1; # where address is from
+  # 1 - BK; 0 - Signed-off-by; 2 - From
   undef $address;
 
   ###############################################################
   # Linus' intended logic is:
   # - preference is given to From: (namepref 2)
   # - lacking From:, use the first Signed-off-by: we encounter
-  #   (namepref 1)
+  #   (namepref 1) (BUT this really doesn't work too well)
   # - lacking that information, use BK user info (namepref 0)
   ###############################################################
 
@@ -2587,7 +2743,7 @@
       $first = 1;
       $firstpar = 1;
       print STDERR " BK-CHANGESET $author\n" if $debug;
-      $namepref = 0;
+      $namepref = 1;
     } elsif (/^\s+From:?\s*"?([^"]*)"?\s+\<(.*)\>\s*$/) {
       my @nameauthor = treat_address($1, $2);
       if ($namepref < 2) {
@@ -2599,9 +2755,9 @@
       }
     } elsif (/^\s+Signed-off-by:\s*"?([^"]*)"?\s+\<(.*)\>\s*$/i) {
       my @nameauthor = treat_address($1, $2);
-      if ($namepref < 1) {
+      if ($namepref < 0) {
 	  ($name, $address, $author) = @nameauthor;
-	  $namepref = 1;
+	  $namepref = 0;
 	  print STDERR " SIGNED-OFF-BY  $author\n" if $debug;
       } else {
 	  print STDERR " SKIPPED SIGNED-OFF-BY  $author\n" if $debug;
@@ -3011,7 +3167,7 @@
 
 Albert D. Cahalan <acahalan@cs.uml.edu>, Robinson Maureira Castillo
 <rmaureira@alumno.inacap.cl>, Greg Kroah-Hartman <greg@kroah.com>, Zack
-Brown <zbrown@tumblerings.org>.
+Brown <zbrown@tumblerings.org>, Linus Torvalds <torvalds@osdl.org>.
 
 =back
 

