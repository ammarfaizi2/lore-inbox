Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUHDJB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUHDJB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 05:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbUHDJB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 05:01:59 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:41135 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261724AbUHDJAs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 05:00:48 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed_Aug__4_09_00_40_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040804090040.68DC9BD2C3@merlin.emma.line.org>
Date: Wed,  4 Aug 2004 11:00:40 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.207, 2004-08-04 11:00:08+02:00, matthias.andree@gmx.de
  Add lots of new addresses.

ChangeSet@1.206, 2004-07-23 13:45:30+02:00, matthias.andree@gmx.de
  vita: 2 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |  155 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 154 insertions(+), 1 deletion(-)

##### GNUPATCH #####
--- 1.178/shortlog	2004-07-16 14:51:37 +02:00
+++ 1.180/shortlog	2004-08-04 11:00:08 +02:00
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.314 2004/07/16 12:51:21 emma Exp $
+# $Id: lk-changelog.pl,v 0.316 2004/08/04 09:00:07 emma Exp $
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
+'fbl:netbank.com.br' => 'Flavio B. Leitner',
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
@@ -954,6 +1011,7 @@
 'jgrimm:touki.qip.austin.ibm.com' => 'Jon Grimm', # google
 'jgt:pobox.com' => 'Jon Thackray',
 'jh:sgi.com' => 'John Hesterberg',
+'jh:suse.cz' => 'Jan Hubicka',
 'jhammer:us.ibm.com' => 'Jack Hammer',
 'jhartmann:addoes.com' => 'Jeff Hartmann',
 'jheffner:psc.edu' => 'John Heffner',
@@ -964,6 +1022,7 @@
 'jim.hague:acm.org' => 'Jim Hague',
 'jim.houston:attbi.com' => 'Jim Houston',
 'jim.houston:comcast.net' => 'Jim Houston',
+'jim:hamachi.net' => 'Jim Collette',
 'jk:ozlabs.org' => 'Jeremy Kerr',
 'jkenisto:us.ibm.com' => 'James Keniston',
 'jkluebs:com.rmk.(none)' => 'John K. Luebs',
@@ -1006,6 +1065,7 @@
 'johnstul:us.ibm.com' => 'John Stultz',
 'jon:ballardtech.com' => 'Jon Neal',
 'jon:focalhost.com' => 'Jon Oberheide',
+'jon:jon-foster.co.uk' => 'Jon Foster',
 'jonas.larsson:net.rmk.(none)' => 'Jonas Larsson',
 'jonas:thornblad.net' => 'Jonas Thornblad',
 'jones:ingate.com' => 'Jones Desougi',
@@ -1014,13 +1074,16 @@
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
@@ -1038,7 +1101,9 @@
 'juhl-lkml:dif.dk' => 'Jesper Juhl',
 'jun.nakajima:intel.com' => 'Jun Nakajima',
 'jung-ik.lee:intel.com' => 'Jung-Ik Lee',
+'junkio:cox.net' => 'Junio C. Hamano',
 'jurgen:botz.org' => 'Jürgen Botz',
+'jwboyer:charter.net' => 'Josh Boyer',
 'jwoithe:physics.adelaide.edu.au' => 'Jonathan Woithe',
 'k-suganuma:mvj.biglobe.ne.jp' => 'Kimio Suganuma',
 'k.kasprzak:box43.pl' => 'Karol Kasprzak', # by Kristian Peters
@@ -1071,13 +1136,18 @@
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
@@ -1101,11 +1171,16 @@
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
@@ -1115,6 +1190,7 @@
 'kpfleming:cox.net' => 'Kevin P. Fleming',
 'kraxel:bytesex.org' => 'Gerd Knorr',
 'kraxel:suse.de' => 'Gerd Knorr',
+'krh:bitplanet.net' => 'Kristian Høgsberg',
 'krishnakumar:naturesoft.net' => 'Krishna Kumar',
 'krkumar:us.ibm.com' => 'Krishna Kumar',
 'kronos:kronoz.cjb.net' => 'Luca Tettamanti',
@@ -1166,6 +1242,7 @@
 'linux-kernel:vortech.net' => 'Joshua Jackson',
 'linux-usb:gemeinhardt.info' => 'Lars Gemeinhardt',
 'linux-usb:nerds-incorporated.org' => 'Sepp Wijnands',
+'linux:borntraeger.net' => 'Christian Bornträger',
 'linux:brodo.de' => 'Dominik Brodowski',
 'linux:de.rmk.(none)' => 'Dominik Brodowski',
 'linux:de.rmk.(none2)' => 'Sebastian Henschel',
@@ -1177,6 +1254,7 @@
 'linux:thorsten-knabe.de' => 'Thorsten Knabe',
 'linux:youmustbejoking.demon.co.uk' => 'Darren Salt',
 'linuxram:us.ibm.com' => 'Ram Pai',
+'linville:redhat.com' => 'John Linville',
 'lionel.bouton:inet6.fr' => 'Lionel Bouton',
 'lists:mdiehl.de' => 'Martin Diehl',
 'livio:ime.usp.br' => 'Livio Baldini Soares',
@@ -1196,6 +1274,7 @@
 'lord:penguin.americas.sgi.com' => 'Stephen Lord',
 'lord:sgi.com' => 'Stephen Lord',
 'louis.zhuang:linux.co.intel.com' => 'Louis Zhuang',
+'louis_zhuang:linux.co.intel.com' => 'Louis Zhuang',
 'louisk:cse.unsw.edu.au' => 'Louis Yu-Kiu Kwan',
 'lowekamp:cs.wm.edu' => 'Bruce B. Lowekamp', # lbdb
 'luben:splentec.com' => 'Luben Tuikov',
@@ -1216,10 +1295,12 @@
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
@@ -1242,6 +1323,7 @@
 'marcelo:plucky.distro.conectiva' => 'Marcelo Tosatti',
 'marchand:kde.org' => 'Mickael Marchand',
 'marco.cova:studio.unibo.it' => 'Marco Cova',
+'marcus:infa.abo.fi' => 'Marcus Alanen',
 'marcus:ingate.com' => 'Marcus Sundberg',
 'marekm:amelek.gda.pl' => 'Marek Michalkiewicz',
 'margitsw:t-online.de' => 'Margit Schubert-While',
@@ -1269,6 +1351,7 @@
 'maschaffner:gmx.ch' => 'Martin Schaffner',
 'mashirle:us.ibm.com' => 'Shirley Ma',
 'mason:suse.com' => 'Chris Mason',
+'master:sectorb.msk.ru' => 'Vladimir B. Savkin',
 'mathieu:newview.com' => 'Mathieu Chouquet-Stringer',
 'matt_domsch:dell.com' => 'Matt Domsch', # sent by himself
 'matthew:wil.cx' => 'Matthew Wilcox',
@@ -1283,12 +1366,14 @@
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
@@ -1308,12 +1393,16 @@
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
@@ -1330,6 +1419,7 @@
 'mikem:beardog.cca.cpqcorp.net' => 'Mike Miller',
 'mikenc:us.ibm.com' => 'Mike Christie',
 'mikep:linuxtr.net' => 'Mike Phillips',
+'miklos:szeredi.hu' => 'Miklos Szeredi',
 'mikpe:csd.uu.se' => 'Mikael Pettersson',
 'mikpe:user.it.uu.se' => 'Mikael Pettersson',
 'mikulas:artax.karlin.mff.cuni.cz' => 'Mikulas Patocka',
@@ -1339,6 +1429,7 @@
 'miles:megapathdsl.net' => 'Miles Lane',
 'milli:acmeps.com' => 'Michael Milligan',
 'miltonm:bga.com' => 'Milton Miller', # by Kristian Peters
+'miltonm:realtime.net' => 'Milton D. Miller II',
 'mingo:earth2.(none)' => 'Ingo Molnar',
 'mingo:elte.hu' => 'Ingo Molnar',
 'mingo:redhat.com' => 'Ingo Molnar',
@@ -1347,7 +1438,9 @@
 'mirage:kaotik.org' => 'Tiago Sousa',
 'mitch:sfgoth.com' => 'Mitchell Blank Jr.',
 'miura:da-cha.org' => 'Hiroshi Miura',
+'miurahr:nttdata.co.jp' => 'Hiroshi Miura',
 'miyazawa:linux-ipv6.org' => 'Kazunori Miyazawa',
+'miyoshi:hpc.bs1.fc.nec.co.jp' => 'Kazuto Miyoshi',
 'mj:ucw.cz' => 'Martin Mares',
 'mk:linux-ipv6.org' => 'Mitsuru Kanda',
 'mkp:mkp.net' => 'Martin K. Petersen', # lbdb
@@ -1377,6 +1470,7 @@
 'mostrows:watson.ibm.com' => 'Michal Ostrowski',
 'movits:bloomberg.com' => 'Mordechai Ovits',
 'moz:compsoc.man.ac.uk' => 'John Levon',
+'mplayer:jburgess.uklinux.net' => 'Jon Burgess',
 'mpm:selenic.com' => 'Matt Mackall',
 'mporter:cox.net' => 'Matt Porter',
 'mporter:kernel.crashing.org' => 'Matt Porter',
@@ -1393,6 +1487,7 @@
 'my:post.utfors.se' => 'Mikael Ylikoski',
 'mzyngier:freesurf.fr' => 'Marc Zyngier',
 'n0ano:n0ano.com' => 'Don Dugger',
+'nacc:us.ibm.com' => 'Nishanth Aravamudan',
 'nahshon:actcom.co.il' => 'Itai Nahshon',
 'nakam:linux-ipv6.org' => 'Masahide Nakamura',
 'natalie.protasevich:unisys.com' => 'Natalie Protasevich',
@@ -1401,12 +1496,15 @@
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
@@ -1434,6 +1532,7 @@
 'notting:redhat.com' => 'Bill Nottingham',
 'nstraz:sgi.com' => 'Nathan Straz',
 'ntfs:flatcap.org' => 'Richard Russon', # lbdb
+'ntl:pobox.com' => 'Nathan T. Lynch',
 'numlock:freesurf.ch' => 'Joël Bourquard',
 'nuno:itsari.org' => 'Nuno Monteiro',
 'obelix123:toughguy.net' => 'Raj',		# Hmm..
@@ -1463,6 +1562,7 @@
 'otaylor:redhat.com' => 'Owen Taylor',
 'ouellettes:videotron.ca' => 'Stephane Ouellette',
 'overby:sgi.com' => 'Glen Overby',
+'oxymoron:waste.org' => 'Oliver Xymoron',
 'p.guehring:futureware.at' => 'Philipp Gühring',
 'p.lavarre:ieee.org' => 'Pat LaVarre',
 'p2:ace.ulyssis.sutdent.kuleuven.ac.be' => 'Peter De Shrijver',
@@ -1494,6 +1594,7 @@
 'paulkf:microgate.com' => 'Paul Fulghum',
 'paulm:routefree.com' => 'Paul Mielke',
 'paulmck:us.ibm.com' => 'Paul E. McKenney',
+'paulsch:haywired.net' => 'Paul B. Schroeder',
 'paulus:au1.ibm.com' => 'Paul Mackerras',
 'paulus:cargo.(none)' => 'Paul Mackerras',
 'paulus:nanango.paulus.ozlabs.org' => 'Paul Mackerras',
@@ -1552,10 +1653,12 @@
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
@@ -1568,15 +1671,19 @@
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
@@ -1595,19 +1702,23 @@
 'r.a.mercer:blueyonder.co.uk' => 'Adam Mercer',
 'r.e.wolff:bitwizard.nl' => 'Rogier Wolff', # lbdb
 'r.s.bultje:students.uu.nl' => 'Ronald S. Bultje',
+'radford:indigita.com' => 'Jim Radford',
 'ralf:dea.linux-mips.net' => 'Ralf Bächle',
 'ralf:linux-mips.org' => 'Ralf Bächle',
 'ralphs:org.rmk.(none)' => 'Ralph Siemsen',
+'ramon.rey:hispalinux.es' => 'Ramn Rey Vicente',
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
@@ -1624,6 +1735,7 @@
 'rgooch:atnf.csiro.au' => 'Richard Gooch',
 'rgooch:ras.ucalgary.ca' => 'Richard Gooch',
 'rgs:linalco.com' => 'Roberto Gordo Saez',
+'rhim:cc.gatech.edu' => 'Himanshu Raj',
 'rhirst:linuxcare.com' => 'Richard Hirst',
 'rhw:infradead.org' => 'Riley Williams',
 'richard.brunner:amd.com' => 'Richard Brunner',
@@ -1636,6 +1748,7 @@
 'rjweryk:uwo.ca' => 'Rob Weryk',
 'rl:hellgate.ch' => 'Roger Luethi',
 'rlievin:free.fr' => 'Romain Liévin',
+'rmiller:duskglow.com' => 'Russell Miller',
 'rmk+lkml:arm.linux.org.uk' => 'Russell King',
 'rmk+pcmcia:arm.linux.org.uk' => 'Russell King',
 'rmk-pci:arm.linux.org.uk' => 'Russell King',
@@ -1664,11 +1777,17 @@
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
@@ -1688,8 +1807,10 @@
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
@@ -1704,6 +1825,7 @@
 'sam:ravnborg.org' => 'Sam Ravnborg',
 'samel:mail.cz' => 'Vitezslav Samel',
 'samuel.thibault:ens-lyon.fr' => 'Samuel Thibault',
+'samuel.thibault:ens-lyon.org' => 'Samuel Thibault',
 'samuel.thibault:fnac.net' => 'Samuel Thibault', # lbdb
 'samuel:ibrium.se' => 'Samuel Rydh',
 'sandeen:sgi.com' => 'Eric Sandeen',
@@ -1725,6 +1847,7 @@
 'scott.bailey:eds.com' => 'Scott Bailey',
 'scott.feldman:intel.com' => 'Scott Feldman',
 'scott:concord.org' => 'Scott Cytacki',
+'scott:pantastik.com' => 'Scott Russell',
 'scott_anderson:mvista.com' => 'Scott Anderson',
 'scottm:minion.yyz.somanetworks.com' => 'Scott Murray',
 'scottm:somanetworks.com' => 'Scott Murray',
@@ -1745,11 +1868,13 @@
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
@@ -1758,9 +1883,13 @@
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
@@ -1771,6 +1900,8 @@
 'skyrelighten:yahoo.co.kr' => 'Donggyoo Lee',
 'sl:lineo.com' => 'Stuart Lynne',
 'slansky:usa.net' => 'Petr Slansky',
+'sleddog:us.ibm.com' => 'Dave Boutcher',
+'sluskyb:paranoiacs.org' => 'Ben Slusky',
 'smb:smbnet.de' => 'Stefan M. Brandl',
 'smurf:osdl.org' => 'Nathan Dabney',
 'smurf:play.smurf.noris.de' => 'Matthias Urlichs',
@@ -1782,11 +1913,13 @@
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
@@ -1806,6 +1939,7 @@
 'stelian.pop:fr.alcove.com' => 'Stelian Pop',
 'stelian:popies.net' => 'Stelian Pop',
 'stephane.galles:free.fr' => 'Stephane Galles', # guessed
+'stephanm:muc.de' => 'Stephan Maciej',
 'stephen:phynp6.phy-astr.gsu.edu' => 'Stephen Leonard',
 'stern:rowland.harvard.edu' => 'Alan Stern',
 'stern:rowland.org' => 'Alan Stern', # lbdb
@@ -1829,6 +1963,8 @@
 'stewart:inverse.wetlogic.net' => 'Paul Stewart',
 'stewart:linux.org.au' => 'Stewart Smith',
 'stewart:wetlogic.net' => 'Paul Stewart',
+'stewartsmith:mac.com' => 'Stewart Smith',
+'stoffel:lucent.com' => 'John Stoffel',
 'strosake:us.ibm.com' => 'Michael Strosaker',
 'stsp:aknet.ru' => 'Stas Sergeev',
 'stuart_hayes:dell.com' => 'Stuart Hayes',
@@ -1850,6 +1986,8 @@
 'szuk:telusplanet.net' => 'Scott Zuk',
 't-kochi:bq.jp.nec.com' => 'Takayoshi Kochi', # not a typo
 't-kouchi:mvf.biglobe.ne.jp' => 'Takayoshi Kouchi',
+'t:timothyparkinson.com' => 'Timothy Parkinson',
+'tadavis:lbl.gov' => 'Thomas Davis',
 'tai:imasy.or.jp' => 'Taisuke Yamada',
 'taka:valinux.co.jp' => 'Hirokazu Takahashi',
 'takamiya:po.ntts.co.jp' => 'Noriaki Takamiya',
@@ -1882,6 +2020,8 @@
 'thomr9am:ss1000.ms.mff.cuni.cz' => 'Rudo Thomas',
 'thornber:redhat.com' => 'Joe Thornber',
 'thornber:sistina.com' => 'Joe Thornber',
+'thunder7:xs4all.nl' => 'Jurriaan Kalkman',
+'thunder:keepsake.ch' => 'Tonnerre Anklin',
 'thunder:ngforever.de' => 'Thunder From The Hill',
 'tigran:aivazian.name' => 'Tigran Aivazian',
 'tigran:veritas.com' => 'Tigran Aivazian',
@@ -1896,6 +2036,7 @@
 'tmcreynolds:nvidia.com' => 'Tom McReynolds',
 'tmolina:cablespeed.com' => 'Thomas Molina',
 'tmolina:cox.net' => 'Thomas Molina',
+'tnt:246tnt.com' => 'Sylvain Munaut',
 'tol:stacken.kth.se' => 'Tomas Olsson',
 'tom.l.nguyen:intel.com' => 'Tom L. Nguyen',
 'tomd:csds.uidaho.edu' => 'Thomas DuBuisson',
@@ -1925,11 +2066,13 @@
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
@@ -1945,6 +2088,7 @@
 'umka:namesys.com' => 'Yury Umanets',
 'urban.widmark:enlight.net' => 'Urban Widmark',
 'urban:teststation.com' => 'Urban Widmark',
+'uros:kss-loka.si' => 'Uros Bizjak',
 'utz.bacher:de.ibm.com' => 'Utz Bacher',
 'uwe.bugla:gmx.de' => 'Uwe Bugla',
 'uwe.koziolek:gmx.net' => 'Uwe Koziolek',
@@ -1968,6 +2112,7 @@
 'vince:kyllikki.org' => 'Vincent Sanders',
 'vinsci:floss.(none)' => 'Leonard Norrgard',
 'viro:math.psu.edu' => 'Alexander Viro',
+'viro:parcelfarce.linux.org.uk' => 'Al Viro',
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'viro:www.linux.org.uk' => 'Alexander Viro',
 'vmlinuz386:yahoo.com.ar' => 'Gerardo Exequiel Pozzi', # lbdb
@@ -1978,6 +2123,7 @@
 'vojtech:suse.cz' => 'Vojtech Pavlik',
 'vojtech:twilight.ucw.cz' => 'Vojtech Pavlik',
 'vojtech:ucw.cz' => 'Vojtech Pavlik', # added by himself
+'vrajesh:eecs.umich.edu' => 'Rajesh Venkatasubramanian',
 'vrajesh:umich.edu' => 'Rajesh Venkatasubramanian',
 'vs:tribesman.namesys.com' => 'Vladimir Saveliev',
 'vsu:altlinux.ru' => 'Sergey Vlasov',
@@ -2000,14 +2146,17 @@
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
@@ -2027,6 +2176,7 @@
 'wstinson:infonie.fr' => 'William Stinson',
 'wstinson:wanadoo.fr' => 'William Stinson',
 'wtogami:redhat.com' => 'Warren Togami',
+'xavier.bestel:free.fr' => 'Xavier Bestel',
 'xavier.bru:bull.net' => 'Xavier Bru',
 'xkaspa06:stud.fee.vutbr.cz' => 'Tomas Kasparek',
 'xma:us.ibm.com' => 'Shirley Ma',
@@ -2037,6 +2187,7 @@
 'ya:slamail.org' => 'Yaacov Akiba Slama',
 'yanmin.zhang:intel.com' => 'Yanmin Zhang',
 'yasuyuki.kozakai:toshiba.co.jp' => 'Yasuyuki Kozakai',
+'yi.zhu:intel.com' => 'Yi Zhu',
 'yinah:couragetech.com.cn' => 'Yin Aihua',
 'yoav.zach:intel.com' => 'Yoav Zach',
 'yoav_zach:yahoo.com' => 'Yoav Zach',
@@ -2048,10 +2199,12 @@
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



##### BKPATCH #####

## Wrapped with gzip_b64 ##
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

