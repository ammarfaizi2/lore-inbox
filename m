Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbVCDC6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbVCDC6p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 21:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262753AbVCDCsM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 21:48:12 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:29375 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262798AbVCDCha convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 21:37:30 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 
CC: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri,_04_Mar_2005_02_37_19_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20050304023719.757BE79DE1@merlin.emma.line.org>
Date: Fri,  4 Mar 2005 03:37:19 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version  has been released.

This script is used by Linus and Marcelo to rearrange and reformat BK
ChangeSet logs into a more human-readable format, and the official
repository is Parent repository is file://var/bitkeeper/BK-kernel-tools

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
revision 0.328
date: 2005-03-04 02:36:50 +0000;  author: emma;  state: Exp;  lines: +200 -3
Merge CVS <-> BK, dropping ID line which is sorta useless.
----------------------------
revision 0.327
date: 2004-12-02 11:10:20 +0000;  author: emma;  state: Exp;  lines: +68 -6
synch up CVS <-> BK
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.327
retrieving revision 0.328
diff -u -U2 -r0.327 -r0.328
--- lk-changelog.pl	2 Dec 2004 11:10:20 -0000	0.327
+++ lk-changelog.pl	4 Mar 2005 02:36:50 -0000	0.328
@@ -9,5 +9,4 @@
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.327 2004/12/02 11:10:20 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
@@ -117,4 +116,5 @@
 'davej:codemonkey.org.uk' => 'Dave Jones',
 'davej:delerium.codemonkey.org.uk' => 'Dave Jones',
+'davej:delerium.kernelslacker.org' => 'Dave Jones',
 'davej:wopr.codemonkey.org.uk' => 'Dave Jones',
 'davem:cheetah.ninka.net' => 'David S. Miller',
@@ -152,4 +152,5 @@
 'aaron.baranoff:tsc.tdk.com' => 'Aaron Baranoff',
 'abbotti:mev.co.uk' => 'Ian Abbott',
+'abem.se:shinybook.infradead.org' => 'Per Hedblom',
 'abraham:2d3d.co.za' => 'Abraham van der Merwe',
 'abslucio:terra.com.br' => 'Lucio Maciel',
@@ -167,4 +168,5 @@
 'acme:dhcp197.conectiva' => 'Arnaldo Carvalho de Melo',
 'acme:parisc.kerneljanitors.org' => 'Arnaldo Carvalho de Melo',
+'acme:toy.ghostprotocols.net' => 'Arnaldo Carvalho de Melo',
 'acme:toy.kerneljanitors.org' => 'Arnaldo Carvalho de Melo',
 'acurtis:onz.com' => 'Allen Curtis',
@@ -222,4 +224,5 @@
 'ak:suse.de' => 'Andi Kleen',
 'akepner:sgi.com' => 'Arthur Kepner',
+'akeptner:sgi.com' => 'Arthur Kepner',
 'akiyama.nobuyuk:jp.fujitsu.com' => 'Akiyama Nobuyuki',
 'akm:osdl.org' => 'Andrew Morton', # typo?
@@ -241,7 +244,10 @@
 'albert:users.sf.net' => 'Albert Cahalan',
 'albert:users.sourceforge.net' => 'Albert Cahalan',
+'albert_herranz:yahoo.es' => 'Albert Herranz',
+'albertcc:tw.ibm.com' => 'Albert Lee',
 'albertogli:telpin.com.ar' => 'Alberto Bertogli',
 'alborchers:steinerpoint.com' => 'Al Borchers',
 'alessandro.zummo:towertech.it' => 'Alessandro Zummo',
+'alex.butcher:assursys.co.uk' => 'Alex Butcher',
 'alex.kern:gmx.de' => 'Alexander Kern',
 'alex.kiernan:gmail.com' => 'Alex Kiernan',
@@ -292,4 +298,5 @@
 'andreas:xss.co.at' => 'Andreas Haumer',
 'andrej.filipcic:ijs.si' => 'Andrej Filipcic',
+'andrew-lists:optusnet.com.au' => 'Andrew Dennison',
 'andrew.grover:intel.com' => 'Andy Grover', # "Andy" to match former entries
 'andrew.patterson:hp.com' => 'Andrew Patterson',
@@ -378,4 +385,5 @@
 'baldrick:wanadoo.fr' => 'Duncan Sands',
 'ballabio_dario:emc.com' => 'Dario Ballabio',
+'baris:idealteknoloji.com' => 'M. Baris Demiray',
 'barrow_dj:yahoo.com' => 'D. J. Barrow',
 'barryn:pobox.com' => 'Barry K. Nathan', # lbdb
@@ -384,4 +392,5 @@
 'bart:samwel.tk' => 'Bart Samwel',
 'baruch:ev-en.org' => 'Baruch Even',
+'basic:mozdev.org' => 'Pang Lih Wuei',
 'bastian:waldi.eu.org' => 'Bastian Blank',
 'bbosch:iphase.com' => 'Bradley A. Bosch',
@@ -390,4 +399,5 @@
 'bcollins:debian.org' => 'Ben Collins',
 'bcrl:bob.home.kvack.org' => 'Benjamin LaHaise',
+'bcrl:kvack.org' => 'Benjamin LaHaise',
 'bcrl:redhat.com' => 'Benjamin LaHaise',
 'bcrl:toomuch.toronto.redhat.com' => 'Benjamin LaHaise', # guessed
@@ -395,6 +405,8 @@
 'bde:nwlink.com' => 'Bruce D. Elliott',
 'bdschuym:pandora.be' => 'Bart De Schuymer',
+'bdschuym:telenet.be' => 'Bart De Schuymer',
 'bdshuym:pandora.be' => 'Bart De Schuymer', # it's typo IMHO
 'beattie:beattie-home.net' => 'Brian Beattie', # from david.nelson
+'becky.gill:freescale.com' => 'Becky Gill',
 'bellucda:tiscali.it' => 'Daniele Bellucci',
 'ben-linux:fluff.org' => 'Ben Dooks',
@@ -411,4 +423,5 @@
 'bergner:cannon.rchland.ibm.com' => 'Peter Bergner',
 'bergner:vnet.ibm.com' => 'Peter Bergner',
+'bernard:blackham.com.au' => 'Bernard Blackham',
 'bernhard.kaindl:gmx.de' => 'Bernhard Kaindl',
 'bernie:develer.com' => 'Bernardo Innocenti',
@@ -426,4 +439,5 @@
 'bjoern:j3e.de' => 'Bjoern Jacke',
 'bjohnson:sgi.com' => 'Brian J. Johnson',
+'bjorn-helgaas:comcast.net' => 'Bjorn Helgaas',
 'bjorn.andersson:erc.ericsson.se' => 'Björn Andersson', # google, guessed ö
 'bjorn.helgaas:com.rmk.(none)' => 'Bjorn Helgaas',
@@ -434,4 +448,5 @@
 'bjorn_helgaas:hp.com' => 'Bjorn Helgaas',
 'bk:suse.de' => 'Bernhard Kaindl',
+'blaisorblade:yahoo.it' => 'Paolo \'Blaisorblade\' Giarrusso',
 'blaisorblade_spam:yahoo.it' => 'Paolo \'Blaisorblade\' Giarrusso',
 'blaschke:blaschke3.austin.ibm.com' => 'Dave Blaschke',
@@ -442,4 +457,6 @@
 'bo.henriksen:com.rmk.(none)' => 'Bo Henriksen',
 'bo.henriksen:nordicid.com' => 'Bo Henriksen',
+'bob.picco:hp.com' => 'Bob Picco',
+'bodo.stroesser:fujitsu-siemens.com' => 'Bodo Stroesser',
 'bogdan.costescu:iwr.uni-heidelberg.de' => 'Bogdan Costescu',
 'bombe:informatik.tu-muenchen.de' => 'Andreas Bombe',
@@ -464,4 +481,5 @@
 'brm:murphy.dk' => 'Brian Murphy',
 'brownfld:irridia.com' => 'Ken Brownfield',
+'brugolsky:telemetry-investments.com' => 'Bill Rugolsky',
 'bryan:staidm.org' => 'Bryan Rittmeyer',
 'bryder:paradise.net.nz' => 'Bill Ryder',
@@ -488,4 +506,5 @@
 'c-d.hailfinger.kernel.2003:gmx.net' => 'Carl-Daniel Hailfinger', # himself
 'c-d.hailfinger.kernel.2004:gmx.net' => 'Carl-Daniel Hailfinger',
+'c.lucas@com.rmk.(none)' => 'Christophe Lucas',
 'c.lucas:ifrance.com' => 'Christophe Lucas',
 'cagle:mindspring.com' => 'John Cagle', # Alan
@@ -498,4 +517,5 @@
 'castor:3pardata.com' => 'Castor Fu',
 'cat:zip.com.au' => 'CaT',
+'catab at umbrella.ro' => 'Catalin Boie',
 'catab:deuroconsult.ro' => 'Catalin Boie',
 'catab:umbrella.ro' => 'Catalin Boie',
@@ -546,6 +566,8 @@
 'cieciwa:alpha.zarz.agh.edu.pl' => 'Wojciech Cieciwa',
 'cip307:cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
+'ckoerner:sysgo.com' => 'Christian Koerner',
 'ckulesa:as.arizona.edu' => 'Craig Kulesa',
 'clameter:sgi.com' => 'Christoph Lameter',
+'clear.zhang:uli.com.tw' => 'Clear Zhang',
 'clemens-dated-1061728015.bf63:endorphin.org' => 'Fruhwirth Clemens',
 'clemens:endorphin.org' => 'Fruhwirth Clemens',
@@ -574,4 +596,5 @@
 'cotte:de.ibm.com' => 'Carsten Otte',
 'coughlan:redhat.com' => 'Tom Coughlan',
+'coywolf:gmail.com' => 'Coywolf Qi Hunt',
 'coywolf:greatcn.org' => 'Coywolf Qi Hunt',
 'cp:absolutedigital.net' => 'Cal Peake',
@@ -586,5 +609,7 @@
 'craig:homerjay.homelinux.org' => 'Craig Wilkie',
 'cramerj:intel.com' => 'Jeb J. Cramer',
+'crn:netunix.com' => 'Chris Newport',
 'cruault:724.com' => 'Charles-Edouard Ruault',
+'cs.helsinki.fi:shinybook.infradead.org' => 'Heikki Lindholm',
 'cspalletta:yahoo.com' => 'Carl Spalletta',
 'ctindel:cup.hp.com' => 'Chad N. Tindel',
@@ -594,4 +619,5 @@
 'cw:sgi.com' => 'Chris Wedgwood',
 'cweidema:indiana.edu' => 'Christoph Weidemann',
+'cwernham:airspan.com' => 'Colin P. Wernham',
 'cwf:sgi.com' => 'Charles Fumuso',
 'cyeoh:samba.org' => 'Christopher Yeoh',
@@ -606,5 +632,7 @@
 'dalecki:evision-ventures.com' => 'Martin Dalecki',
 'dalecki:evision.ag' => 'Martin Dalecki',
+'dalto:austin.ibm.com' => 'Dave Altobelli',
 'damien.morange:hp.com' => 'Damien Morange',
+'damm:opensource.se' => 'Magnus Damm',
 'dan.zink:hp.com' => 'Dan Zink',
 'dan:debian.org' => 'Daniel Jacobowitz',
@@ -657,4 +685,5 @@
 'davidm:hpl.hp.com' => 'David Mosberger',
 'davidm:napali.hpl.hp.com' => 'David Mosberger',
+'davidm:snapgear.com' => 'David McCullough',
 'davidm:tiger.hpl.hp.com' => 'David Mosberger',
 'davidm:wailua.hpl.hp.com' => 'David Mosberger',
@@ -672,4 +701,5 @@
 'debian:sternwelten.at' => 'Maximilian Attems',
 'dedekind:infradead.org' => 'Artem Bityuckiy',
+'dedekind:yandex.ru' => 'Artem Bityuckiy',
 'deepfire:sic-elvis.zel.ru' => 'Samium Gromoff',
 'defouwj:purdue.edu' => 'Jeff DeFouw',
@@ -702,4 +732,5 @@
 'dirk.behme:de.bosch.com' => 'Dirk Behme',
 'dirk.uffmann:nokia.com' => 'Dirk Uffmann',
+'djwong:us.ibm.com' => 'Darrick Wong',
 'dkrivoschokov:dev.rtsoft.ru' => 'Dmitry Krivoschokov',
 'dkuhlen:fhm.edu' => 'Dominik Kuhlen',
@@ -713,7 +744,9 @@
 'dlstevens:us.ibm.com' => 'David Stevens',
 'dlsy:snoqualmie.dp.intel.com' => 'Dely Sy',
+'dmarlin:redhat.com' => 'David Marlin',
 'dmccr:us.ibm.com' => 'Dave McCracken',
 'dmilburn:redhat.com' => 'David Milburn',
 'dmo:osdl.org' => 'Dave Olien',
+'dmp:davidmpye.dyndns.org' => 'David Pye',
 'doj:cubic.org' => 'Dirk Jagdmann',
 'dok:directfb.org' => 'Denis Oliver Kropp',
@@ -733,4 +766,5 @@
 'drzeus-list:cx.rmk.(none)' => 'Pierre Ossman',
 'drzeus-list:drzeus.cx' => 'Pierre Ossman',
+'drzeus:cx.rmk.(none)' => 'Pierre Ossman',
 'ds-fraser:comcast.net' => 'Douglas Fraser',
 'dsaxena:com.rmk' => 'Deepak Saxena',
@@ -752,4 +786,5 @@
 'duwe:suse.de' => 'Torsten Duwe',
 'dvhltc:us.ibm.com' => 'Darren Hart',
+'dvrabel:arcom.co.uk' => 'David Vrabel',
 'dvrabel:arcom.com' => 'David Vrabel',
 'dvrabel:com.rmk.(none)' => 'David Vrabel',
@@ -763,4 +798,5 @@
 'dwmw2:shinybook.infradead.org' => 'David Woodhouse',
 'dz:cs.unitn.it' => 'Massimo Dal Zotto',
+'e9925248:student.tuwien.ac.at' => 'Martin Kögler',
 'ebiederm:xmission.com' => 'Eric W. Biederman',
 'ebrower:gmail.com' => 'Eric Brower',
@@ -771,4 +807,5 @@
 'ecashin:uga.edu' => 'Ed L. Cashin',
 'ecd:skynet.be' => 'Eddie C. Dost',
+'echtler:fs.tum.de' => 'Florian Echtler',
 'ed:il.fontys.nl' => 'Ed Schouten',
 'eddie.williams:steeleye.com' => 'Eddie Williams',
@@ -807,4 +844,7 @@
 'engebret:us.ibm.com' => 'David Engebretsen',
 'engel:us.ibm.com' => 'John Engel',
+'enrico.scholz:informatik.tu-chemnitz.de' => 'Enrico Scholz',
+'eolson:mit.edu' => 'Edwin Olson',
+'eradicator:gentoo.org' => 'Jeremy Huddleston',
 'eranian:frankl.hpl.hp.com' => 'Stéphane Eranian',
 'eranian:hpl.hp.co' => 'Stéphane Eranian', # typo
@@ -812,4 +852,5 @@
 'erbenson:alaska.net' => 'Ethan Benson',
 'eric.lemoine:gmail.com' => 'Eric Lemoine',
+'eric.moore:lsil.com' => 'Eric Moore',
 'eric.piel:bull.net' => 'Eric Piel',
 'eric.valette:free.fr' => 'Eric Valette',
@@ -830,7 +871,9 @@
 'eugeneteo:eugeneteo.net' => 'Eugene Teo',
 'evan.felix:pnl.gov' => 'Evan Felix',
+'evil:g-house.de' => 'Christian Kujau',
 'extreme:zayanionline.com' => 'Vineet Mehta',
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'f.duncan.m.haldane:worldnet.att.net' => 'Duncan Haldane',
+'fabbione:fabbione.net' => 'Fabio Massimo Di Nitto',
 'fabian.frederick:skynet.be' => 'Fabian Frederick',
 'faikuygur:tnn.net' => 'Faik Uygur',
@@ -838,4 +881,5 @@
 'faith:redhat.com' => 'Rik Faith',
 'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hüffner',
+'fanny.wakizaka:cyclades.com' => 'Fanny Wakizaka',
 'fb.arm:net.rmk.(none)' => 'Frank Becker',
 'fbecker:com.rmk.(none)' => 'Frank Becker',
@@ -858,4 +902,5 @@
 'flavien:lebarbe.net' => 'Flavien Lebarbé',
 'fletch:aracnet.com' => 'Martin J. Bligh',
+'fli:ati.com' => 'Frederick Li',
 'flo:rfc822.org' => 'Florian Lohoff',
 'florian.thiel:gmx.net' => 'Florian Thiel', # from shortlog
@@ -870,8 +915,10 @@
 'frank.a.uepping:t-online.de' => 'Frank A. Uepping',
 'frank.cornelis:elis.ugent.be' => 'Frank Cornelis',
+'frank:tuxrocks.com' => 'Frank Sorenson',
 'frank_borich:us.xyratex.com' => 'Frank Borich',
 'frankie:cse.unsw.edu.au' => 'Frank Engel',
 'franz.sirl-kernel:lauterbach.com' => 'Franz Sirl',
 'franz.sirl:lauterbach.com' => 'Franz Sirl',
+'franz_pletz:t-online.de' => 'Franz Pletz',
 'frederik.deweerdt:laposte.net' => 'Frederik Deweerdt',
 'frediano.ziglio:vodafone.com' => 'Frediano Ziglio',
@@ -882,8 +929,12 @@
 'fujiwara:linux-m32r.org' => 'Hayato Fujiwara',
 'fw:deneb.enyo.de' => 'Florian Weimer', # lbdb
+'fxhuehl:gmx.de' => 'Felix Kuehling',
 'fzago:austin.rr.com' => 'Frank Zago', # google
 'g.liakhovetski:gmx.de' => 'Guennadi Liakhovetski',
 'gaa:ulticom.com' => 'Gary Algier', # google
+'gaboregry:axelero.hu' => 'Gabor Egry',
 'galak:blarg.somerset.sps.mot.com' => 'Kumar Gala',
+'galak:freescale.com' => 'Kumar Gala',
+'galak:linen.sps.mot.com' => 'Kumar Gala',
 'galak:somerset.sps.mot.com' => 'Kumar Gala',
 'gamal:alternex.com.br' => 'Haroldo Gamal',
@@ -897,4 +948,5 @@
 'ganesh:vxindia.veritas.com' => 'Ganesh Varadarajan',
 'garloff:suse.de' => 'Kurt Garloff',
+'gary.spiess:intermec.com' => 'Gary N. Spiess',
 'gary_lerhaupt:dell.com' => 'Gary Lerhaupt',
 'garyhade:us.ibm.com' => 'Gary Hade',
@@ -917,4 +969,5 @@
 'gibbs:scsiguy.com' => 'Justin T. Gibbs',
 'gilbertd:treblig.org' => 'Dr. David Alan Gilbert',
+'giorgio:org.rmk.(none)' => 'Giorgio Padrin',
 'giri:lmc.cs.sunysb.edu' => 'Giridhar Pemmasani',
 'giuseppe.furlan:systeam.it' => 'Giuseppe Furlan',
@@ -938,7 +991,9 @@
 'gordon.jin:intel.com' => 'Gordon Jin',
 'gorgo:thunderchild.debian.net' => 'Madarasz Gergely',
+'gortan:tttech.com' => 'Philipp Gortan',
 'gortmaker:yahoo.com' => 'Paul Gortmaker',
 'gotom:debian.or.jp' => 'Goto Masanori', # from shortlog
 'gphat:cafes.net' => 'Cory Watson',
+'grantma:anathoth.gen.nz' => 'Matthew Grant',
 'greearb:candelatech.com' => 'Ben Greear',
 'green:angband.namesys.com' => 'Oleg Drokin',
@@ -956,4 +1011,5 @@
 'grundym:us.ibm.com' => 'Michael Grundy',
 'gsromero:alumnos.euitt.upm.es' => 'Guillermo S. Romero',
+'gtj.member:com.rmk.(none)' => 'George T. Joseph',
 'gtoumi:laposte.net' => 'Ghozlane Toumi',
 'gtw:cs.bu.edu' => 'Gary Wong',
@@ -961,4 +1017,6 @@
 'guillaume.thouvenin:bull.net' => 'Guillaume Thouvenin',
 'guillaume:morinfr.org' => 'Guillaume Morin',
+'guninski:guninski.com' => 'Georgi Guninski',
+'gunther.mayer:gmx.net' => 'Gunther Mayer',
 'gwehrman:sgi.com' => 'Geoffrey Wehrman',
 'gwurster:scs.carleton.ca' => 'Glenn Wurster',
@@ -971,5 +1029,8 @@
 'hadi:znyx.com' => 'Jamal Hadi Salim', # typo
 'hadi:zynx.com' => 'Jamal Hadi Salim',
+'hager:cs.umu.se' => 'Peter Hagervall',
 'hall:vdata.com' => 'Jeff Hall',
+'hallyn:cs.wm.edu' => 'Serge Hallyn',
+'halr:voltaire.com' => 'Hal Rosenstock',
 'hammer:adaptec.com' => 'Jack Hammer',
 'hannal:us.ibm.com' => 'Hanna V. Linder',
@@ -1013,4 +1074,6 @@
 'hero:persua.de' => 'Heiko Ronsdorf',
 'herry:sgi.com' => 'Herry Wiputra',
+'hfvogt:arcor.de' => 'Hans-Frieder Vogt',
+'hifumi.hisashi:lab.ntt.co.jp' => 'Hisashi Hifumi',
 'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
 'hiroshi_doyu:montavista.co.jp' => 'Hiroshi Doyu',
@@ -1018,7 +1081,10 @@
 'hjl:lucon.org' => 'H. J. Lu',
 'hjm:redhat.com' => 'Heinz Mauelshagen', # lbdb
+'hkneissel:gmx.de' => 'Hermann Kneissel',
+'hkneissel:t-online.de' => 'Hermann Kneissel',
 'hno:marasystems.com' => 'Henrik Nordstrom',
 'hoho:binbash.net' => 'Colin Slater',
 'holger.smolinski:de.ibm.com' => 'Holger Smolinski',
+'holindho:cs.helsinki.fi' => 'Heikki O. Lindholm',
 'holland:loser.net' => 'Shannon Holland',
 'hollis:austin.ibm.com' => 'Hollis Blanchard',
@@ -1084,4 +1150,5 @@
 'james.bottomley:steeleye.com' => 'James Bottomley',
 'james.smart:emulex.com' => 'James Smart',
+'james4765:cwazy.co.uk' => 'James Nelson',
 'james4765:gmail.com' => 'James Nelson',
 'james4765:verizon.net' => 'James Nelson',
@@ -1105,4 +1172,6 @@
 'janitor:at.rmk.(none)' => 'Maximilian Attems',
 'janitor:sternwelten.at' => 'Maximilian Attems',
+'jarkko.lavinen:nokia.com' => 'Jarkko Lavinen',
+'jason.d.gaston:intel.com' => 'Jason Gaston',
 'jason.davis:unisys.com' => 'Jason Davis',
 'jasonuhl:sgi.com' => 'Jason Uhlenkott',
@@ -1130,7 +1199,10 @@
 'jdike:uml.karaya.com' => 'Jeff Dike',
 'jdittmer:ppp0.net' => 'Jan Dittmer',
+'jdittmer:sfhq.hn.org' => 'Jan Dittmer',
+'jdmason:us.ibm.com' => 'Jon Mason',
 'jdow:earthlink.net' => 'Joanne Dow',
 'jdr:farfalle.com' => 'David Ruggiero',
 'jdthood:yahoo.co.uk' => 'Thomas Hood',
+'jdub:us.ibm.com' => 'Josh Boyer',
 'jean-luc.richier:imag.fr' => 'Jean-Luc Richier',
 'jeb.j.cramer:intel.com' => 'Jeb J. Cramer',
@@ -1160,4 +1232,6 @@
 'jeremy:sgi.com' => 'Jeremy Higdon',
 'jermar:itbs.cz' => 'Jakub Jermar',
+'jerome.forissier:hp.com' => 'Jerome Forissier',
+'jerone:gmail.com' => 'Jerone Young',
 'jes:trained-monkey.org' => 'Jes Sorensen',
 'jes:wildopensource.com' => 'Jes Sorensen',
@@ -1174,4 +1248,5 @@
 'jgarzik:tout.normnet.org' => 'Jeff Garzik',
 'jgmyers:netscape.com' => 'John Myers',
+'jgreen:users.sourceforge.net' => 'Josh Green',
 'jgrimm2:us.ibm.com' => 'Jon Grimm',
 'jgrimm:death.austin.ibm.com' => 'Jon Grimm',
@@ -1196,4 +1271,6 @@
 'jim.houston:comcast.net' => 'Jim Houston',
 'jim:hamachi.net' => 'Jim Collette',
+'jim:jtan.com' => 'Jim Paris',
+'jimix:watson.ibm.com' => 'Jimi Xenidis',
 'jk:ozlabs.org' => 'Jeremy Kerr',
 'jkenisto:us.ibm.com' => 'James Keniston',
@@ -1201,6 +1278,10 @@
 'jkmaline:cc.hut.fi' => 'Jouni Malinen',
 'jkt:helius.com' => 'Jack Thomasson',
+'jlamanna:gmail.com' => 'James Lamanna',
+'jlan:engr.sgi.com' => 'Jay Lan',
+'jlan:sgi.com' => 'Jay Lan',
 'jlcooke:certainkey.com' => 'Jean-Luc Cooke',
 'jmcmullan:linuxcare.com' => 'Jason McMullan',
+'jmforbes:linuxtx.org' => 'Justin M. Forbes',
 'jmm:informatik.uni-bremen.de' => 'Moritz Mühlenhoff',
 'jmorris:intercode.com.au' => 'James Morris',
@@ -1257,4 +1338,5 @@
 'josha:sgi.com' => 'Josh Aas',
 'joshk:triplehelix.org' => 'Joshua Kwan',
+'jpaana:s2.org' => 'Jarno Paananen',
 'jparadis:redhat.com' => 'Jim Paradis',
 'jparmele:wildbear.com' => 'Joseph Parmelee',
@@ -1263,4 +1345,5 @@
 'js189202:zodiac.mimuw.edu.pl' => 'Jerzy Szczepkowski',
 'js:convergence.de' => 'Johannes Stezenbach',
+'js:linuxtv.org' => 'Johannes Stezenbach',
 'jschopp:austin.ibm.com' => 'Joel Schopp',
 'jscross:veritas.com' => 'James Cross',
@@ -1289,4 +1372,6 @@
 'junx.yao:intel.com' => 'Yao Jun',
 'jurgen:botz.org' => 'Jürgen Botz',
+'jurij:woodyd.org' => 'Jurij Smakov',
+'jurij:wooyd.org' => 'Jurij Smakov',
 'jwboyer:charter.net' => 'Josh Boyer',
 'jwboyer:infradead.org' => 'Josh Boyer',
@@ -1314,7 +1399,9 @@
 'kalin:thinrope.net' => 'Kalin Rumenov Kozhuharov',
 'kambo77:hotmail.com' => 'Kambo Lohan',
+'kamezawa.hiroyu:jp.fujitsu.com' => 'Kamezawa Hiroyuki',
 'kaneshige.kenji:jp.fujitsu.com' => 'Kenji Kaneshige', # lbdb
 'kanoj:vger.kernel.org' => 'Kanoj Sarcar', # sent by Arnaldo Carvalho de Melo
 'kanojsarcar:yahoo.com' => 'Kanoj Sarcar',
+'kaos:melbourne.sgi.com' => 'Keith Owens',
 'kaos:ocs.com.au' => 'Keith Owens',
 'kaos:sgi.com' => 'Keith Owens', # sent by himself
@@ -1337,7 +1424,9 @@
 'keith:tungstengraphics.com' => 'Keith Whitwell',
 'keithu:parl.clemson.edu' => 'Keith Underwood',
+'keithw:tungstengraphics.com' => 'Keith Withwell',
 'kenn:linux.ie' => 'Kenn Humborg',
 'kenneth.w.chen:intel.com' => 'Kenneth W. Chen',
 'kernel-hacker:bennee.com' => 'Alex Bennee',
+'kernel-stuff:comcast.net' => 'Parag Warudkar',
 'kernel:axion.demon.nl' => 'Monchi Abbad',
 'kernel:cornelia-huck.de' => 'Cornelia Huck',
@@ -1366,4 +1455,5 @@
 'kieran:mgpenguin.net' => 'Kieran Morrissey',
 'kihara.seiji:lab.ntt.co.jp' => 'Seiji Kihara',
+'kilgota:banach.math.auburn.edu' => 'Theodore Kilgore',
 'killekulla:rdrz.de' => 'Raphael Zimmerer',
 'kingsley:aurema.com' => 'Cheung Kingsley',
@@ -1382,4 +1472,5 @@
 'klassert:mathematik.tu-chemnitz.de' => 'Steffen Klassert',
 'kmannth:us.ibm.com' => 'Keith Mannthey',
+'kmartens:sonologic.nl' => 'Koen Martens',
 'kml:patheticgeek.net' => 'Kevin Lahey',
 'kmsmith:umich.edu' => 'Kendrick M. Smith',
@@ -1395,4 +1486,5 @@
 'kpfleming:cox.net' => 'Kevin P. Fleming',
 'kpreslan:redhat.com' => 'Ken Preslan',
+'krautz:gmail.com' => 'Mikkel Krautz',
 'kravetz:us.ibm.com' => 'Mike Kravetz',
 'kraxel:bytesex.org' => 'Gerd Knorr',
@@ -1403,4 +1495,6 @@
 'kronos:kronoz.cjb.net' => 'Luca Tettamanti',
 'kronos:people.it' => 'Luca Tettamanti',
+'krzysztof.h1:wp.pl' => 'Krzysztof Helt',
+'ksakamot:linux-m32r.org' => 'Kei Sakamoto',
 'kszysiu:iceberg.elsat.net.pl' => 'Krzysztof Rusocki',
 'kuba:mareimbrium.org' => 'Kuba Ober',
@@ -1414,4 +1508,5 @@
 'kyle:debian.org' => 'Kyle McMartin',
 'kyle:engsoc.carleton.ca' => 'Kyle McMartin',
+'kyle:parisc-linux.org' => 'Kyle McMartin',
 'l.rossato:tiscali.it' => 'Luca Rossato',
 'l.s.r:web.de' => 'René Scharfe',
@@ -1436,6 +1531,8 @@
 'leachbj:bouncycastle.org' => 'Bernard Leach',
 'lee:compucrew.com' => 'Lee Nash', # lbdb
+'leendert:watson.ibm.com' => 'Leendert van Doorn',
 'legoll:free.fr' => 'Vincent Legoll', # correction sent by himself
 'leigh:solinno.co.uk' => 'Leigh Brown', # lbdb
+'len.brown2intel.com' => 'Len Brown',
 'len.brown:intel.com' => 'Len Brown',
 'lenb:dhcppc11.' => 'Len Brown',
@@ -1443,4 +1540,5 @@
 'lenb:dhcppc6.' => 'Len Brown',
 'lenehan:twibble.org' => 'Jamie Lenehan',
+'lenz:cs.wisc.edu' => 'John Lenz',
 'leoli:freescale.com' => 'Li Yang',
 'lesanti:sinectis.com.ar' => 'Leandro Santi',
@@ -1452,4 +1550,5 @@
 'liam.girdwood:com.rmk.(none)' => 'Liam Girdwood',
 'liam.girdwood:wolfsonmicro.com' => 'Liam Girdwood',
+'libor:topspin.com' => 'Libor Michalek',
 'linas:austin.ibm.com' => 'Linas Vepstas',
 'linas:linas.org' => 'Linas Vepstas',
@@ -1463,4 +1562,5 @@
 'linux:borntraeger.net' => 'Christian Bornträger',
 'linux:brodo.de' => 'Dominik Brodowski',
+'linux:broro.de' => 'Dominik Brodowski',	# typo
 'linux:de.rmk.(none)' => 'Dominik Brodowski',
 'linux:de.rmk.(none2)' => 'Sebastian Henschel',
@@ -1481,4 +1581,5 @@
 'livio:ime.usp.br' => 'Livio Baldini Soares',
 'liyang:nerv.cx' => 'Liyang Hu',
+'lklm:lengard.net' => 'Pascal Lengard',
 'lkml001:vrfy.org' => 'Kay Sievers',
 'lkml:felipe-alfaro.com' => 'Felipe Alfaro Solana',
@@ -1516,4 +1617,5 @@
 'lunz:falooley.org' => 'Jason Lunz',
 'luto:myrealbox.com' => 'Andy Lutomirski',
+'lw:de.rmk.(none)' => 'Lothar Wassmann',
 'lxie:us.ibm.com' => 'Linda Xie',
 'lxiep:linux.ibm.com' => 'Linda Xie',
@@ -1529,4 +1631,5 @@
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
 'macro:linux-mips.org' => 'Maciej W. Rozycki',
+'macro:mips.com' => 'Maciej W. Rozycki',
 'maeda.naoaki:jp.fujitsu.com' => 'Maeda Naoaki',
 'magnus.damm:gmail.com' => 'Magnus Damm',
@@ -1565,10 +1668,13 @@
 'margitsw:t-online.de' => 'Margit Schubert-While',
 'marijnk:gmx.co.uk' => 'Marijn Kruisselbrink',
+'marineam:gentoo.org' => 'Michael Marineau',
 'marius:citi.umich.edu' => 'Marius Aamodt Eriksen',
 'mark.fasheh:oracle.com' => 'Mark Fasheh',
+'mark.haigh:spirentcom.com' => 'Mark F. Haigh',
 'mark:alpha.dyndns.org' => 'Mark W. McClelland',
 'mark:hal9000.dyndns.org' => 'Mark W. McClelland',
 'mark:mtfhpc.demon.co.uk' => 'Mark Fortescue',
 'mark:net.rmk.(none)' => 'Mark Hindley',
+'mark_salyzyn:adaptec.com' => 'Mark Salyzyn',
 'markb:wetlettuce.com' => 'Mark Broadbent',
 'markgw:sgi.com' => 'Mark Goodwin',
@@ -1576,4 +1682,5 @@
 'markhe:veritas.com' => 'Mark Hemment',
 'markus.lidel:shadowconnect.com' => 'Markus Lidel',
+'markzzzsmith:yahoo.com.au' => 'Mark Smith',
 'marr:flex.com' => 'Bill Marr',
 'martin-langer:gmx.de' => 'Martin Langer',
@@ -1596,8 +1703,10 @@
 'mathieu:newview.com' => 'Mathieu Chouquet-Stringer',
 'matt_domsch:dell.com' => 'Matt Domsch', # sent by himself
+'matthew.e.tolentino:intel.com' => 'Matt Tolentino',
 'matthew:wil.cx' => 'Matthew Wilcox',
 'matthewc:cse.unsw.edu.au' => 'Matthew Chapman',
 'matthewn:snapgear.com' => 'Matthew Natalier',
 'matthias.andree:gmx.de' => 'Matthias Andree', # added by himself
+'matthias.christian:tiscali.de' => 'Matthias-Christian Ott',
 'matthias:net.rmk.(none)' => 'Matthias Burghardt',
 'mauelshagen:redhat.com' => 'Heinz J. Mauelshagen',
@@ -1609,4 +1718,5 @@
 'maxk:viper.qualcomm.com' => 'Maksim Krasnyanskiy',
 'mb:ozaba.mine.nu' => 'Magnus Boden',
+'mbellon:mvista.com' => 'Mark Bellon',
 'mbligh:aracnet.com' => 'Martin J. Bligh',
 'mbp:samba.org' => 'Martin Pool', # lbdb
@@ -1644,4 +1754,5 @@
 'mhtran:us.ibm.com' => 'Mike Tran',
 'mhuth:mvista.com' => 'Mark Huth',
+'mhw:wittsend.com' => 'Michael H. Warfield',
 'michael.kerrisk:gmx.net' => 'Michael Kerrisk',
 'michael.krauth:web.de' => 'Michael Krauth',
@@ -1650,4 +1761,5 @@
 'michael.waychison:sun.com' => 'Mike Waychison',
 'michael:com.rmk.(none)' => 'Michael Opdenacker',
+'michael:ellerman.id.au' => 'Michael Ellerman',
 'michael:metaparadigm.com' => 'Michael Clark',
 'michael_e_brown:dell.com' => 'Michael E. Brown', # lbdb
@@ -1672,6 +1784,8 @@
 'mikep:linuxtr.net' => 'Mike Phillips',
 'miklos:szeredi.hu' => 'Miklos Szeredi',
+'mikma:users.sourceforge.net' => 'Mikael Magnusson',
 'mikpe:csd.uu.se' => 'Mikael Pettersson',
 'mikpe:user.it.uu.se' => 'Mikael Pettersson',
+'mikukkon:gmail.com' => 'Mika Kukkonen',
 'mikulas:artax.karlin.mff.cuni.cz' => 'Mikulas Patocka',
 'miles:gnu.org' => 'Miles Bader',
@@ -1686,4 +1800,6 @@
 'mingo:redhat.com' => 'Ingo Molnar',
 'minyard:acm.org' => 'Corey Minyard',
+'minyard:mvista.com' => 'Corey Minyard',
+'miquels:cistron.net' => 'Miquel van Smoorenburg',
 'miquels:cistron.nl' => 'Miquel van Smoorenburg',
 'mirage:kaotik.org' => 'Tiago Sousa',
@@ -1700,4 +1816,6 @@
 'mk:linux-ipv6.org' => 'Mitsuru Kanda',
 'mkp:mkp.net' => 'Martin K. Petersen', # lbdb
+'mkrikis:yahoo.com' => 'Martins Krikis',
+'mlachwani:mvista.com' => 'Manish Lachwani',
 'mlang:delysid.org' => 'Mario Lang', # google
 'mlev:despammed.com' => 'Lev Makhlis',
@@ -1737,5 +1855,7 @@
 'mru:inprovide.com' => 'Måns Rullgård',
 'mru:kth.se' => 'Måns Rullgård',
+'msalter:redhat.com' => 'Mark Salter',
 'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
+'mst:mellanox.co.il' => 'Michael S. Tsirkin',
 'msw:redhat.com' => 'Matt Wilson',
 'mtk-lkml:gmx.net' => 'Michael Kerrisk',
@@ -1747,4 +1867,5 @@
 'my:post.utfors.se' => 'Mikael Ylikoski',
 'mzyngier:freesurf.fr' => 'Marc Zyngier',
+'mzzhgg:de.rmk.(none)' => 'Lennart Poettering',
 'n0ano:n0ano.com' => 'Don Dugger',
 'nacc:us.ibm.com' => 'Nishanth Aravamudan',
@@ -1758,4 +1879,5 @@
 'nathans:sgi.com' => 'Nathan Scott',
 'naveenb:cisco.com' => 'Naveen Burmi', # lbdb
+'nboullis:debian.org' => 'Nicolas Boullis',
 'nbryant:optonline.net' => 'Nathan Bryant',
 'ncunningham:linuxmail.org' => 'Nigel Cunningham',
@@ -1768,5 +1890,7 @@
 'netfilter:interlinx.bc.ca' => 'Brian J. Murrell',
 'nfont:austin.ibm.com' => 'Nathan Fontenot',
+'nhorman:gmail.com' => 'Neil Horman',
 'nhorman:redhat.com' => 'Neil Horman',
+'nib:cookinglinux.org' => 'Nicolas Bouliane',
 'nick.holloway:pyrites.org.uk' => 'Nick Holloway',
 'nickpiggin:cyberone.com.au' => 'Nick Piggin',
@@ -1785,4 +1909,5 @@
 'niraj17:iitbombay.org' => 'Niraj Kumar',
 'nitin.a.kamble:intel.com' => 'Nitin A. Kamble',
+'nitin.hande:sun.com' => 'Nitin Hande',
 'niv:us.ibm.com' => 'Nivedita Singhvi',
 'nivedita:w-nivedita.beaverton.ibm.com' => 'Nivedita Singhvi',
@@ -1798,4 +1923,5 @@
 'not:just.any.name' => 'John Fremlin',
 'notting:redhat.com' => 'Bill Nottingham',
+'npollitt:mvista.com' => 'Nick Pollitt',
 'nreilly:magma.ca' => 'Nicholas Reilly',
 'nstraz:sgi.com' => 'Nathan Straz',
@@ -1806,4 +1932,5 @@
 'obelix123:toughguy.net' => 'Raj',		# Hmm..
 'obi:saftware.de' => 'Andreas Oberritter',
+'obiwan:mailmij.org' => 'Danny Tholen',
 'od:suse.de' => 'Olaf Dabrunz',
 'oe:port.de' => 'Heinz-Juergen Oertel',
@@ -1824,4 +1951,5 @@
 'oliver:vermuden.neukum.org' => 'Oliver Neukum',
 'olof:austin.ibm.com' => 'Olof Johansson',
+'olsimar:wanadoo.fr' => 'Olsimar',		# ??
 'omkhar:rogers.com' => 'Omkhar Arasaratnam',
 'orange:fobie.net' => 'Örjan Persson',
@@ -1830,4 +1958,5 @@
 'ortylp:3miasto.net' => 'Paul Ortyl',
 'os:emlix.com' => 'Oskar Schirmer', # sent by himself
+'oskar.senft:gmx.de' => 'Oskar Senft',
 'ossi:kde.org' => 'Oswald Buddenhagen',
 'osst:riede.org' => 'Willem Riede',
@@ -1868,4 +1997,5 @@
 'paul:serice.net' => 'Paul Serice',
 'paul:wagland.net' => 'Paul Wagland', # lbdb
+'pauld:egenera.com' => 'Philip R. Auld',
 'paulkf:microgate.com' => 'Paul Fulghum',
 'paulm:routefree.com' => 'Paul Mielke',
@@ -1879,7 +2009,9 @@
 'paulus:samba.org' => 'Paul Mackerras',
 'paulus:tango.paulus.ozlabs.org' => 'Paul Mackerras',
+'pavel (at) ucw.cz' => 'Pavel Machek',
 'pavel:janik.cz' => 'Pavel Janík',
 'pavel:suse.cz' => 'Pavel Machek',
 'pavel:ucw.cz' => 'Pavel Machek',
+'pavenis:latnet.lv' => 'Andris Pavenis',
 'pavlas:nextra.cz' => 'Zdenek Pavlas',
 'pavlic:de.ibm.com' => 'Frank Pavlic',
@@ -1897,5 +2029,7 @@
 'pekon:informatics.muni.cz' => 'Petr Konecny',
 'pelle:dsv.su.se' => 'Per Olofsson',
+'pelzi:flying-snail.de' => 'Andreas Feldner',
 'penberg:cs.helsinki.fi' => 'Pekka Enberg',
+'penguin:muskoka.com' => 'Paul Gortmaker',
 'pepe:attika.ath.cx' => 'Piotr Kaczuba',
 'pepinto:student.dei.uc.pt' => 'Pedro Emanuel M. D. Pinto',
@@ -1914,4 +2048,5 @@
 'peter:developers.dk' => 'Peter Christensen',
 'peter:pantasys.com' => 'Peter Buckingham',
+'peter:programming.kicks-ass.net' => 'Peter Zijlstra',
 'peter_pregler:email.com' => 'Peter Pregler',
 'peterc:au.rmk.(none)' => 'Peter Chubb',
@@ -1940,4 +2075,5 @@
 'phelps:dstc.edu.au' => 'Ted Phelps',
 'phil.el:wanadoo.fr' => 'Philippe Elie',
+'phil:fifi.org' => 'Philippe Troin',
 'phil:ipom.com' => 'Phil Dibowitz',
 'philipc:snapgear.com' => 'Philip Craig',
@@ -1949,4 +2085,5 @@
 'piggy:timesys.com' => 'La Monte H.P. Yarroll',
 'pilo.c:wanadoo.fr' => 'Pilo Chambert',
+'pisa:cmp.felk.cvut.cz' => 'Pavel Pisa',
 'pixi:burble.org' => 'Maurice S. Barnum',
 'pj:sgi.com' => 'Paul Jackson',
@@ -1961,8 +2098,10 @@
 'pmanolov:lnxw.com' => 'Petko Manolov',
 'pmarques:grupopie.com' => 'Paulo Marques',
+'pmaydell:chiark.greenend.org.uk' => 'Peter Maydell',
 'pmclean:linuxfreak.ca' => 'Patrick McLean',
 'pmeda:akamai.com' => 'Prasanna Meda',
 'pmenage:ensim.com' => 'Paul Menage',
 'pnelson:andrew.cmu.edu' => 'Peter Nelson',
+'pnelson:suse.cz' => 'Peter Nelson',
 'pontus.fuchs:tactel.se' => 'Pontus Fuchs',
 'porter:cox.net' => 'Matt Porter',
@@ -1976,4 +2115,7 @@
 'praka:pobox.com' => 'Andrew Vasquez',
 'praka:users.sourceforge.net' => 'Andrew Vasquez',
+'prakashkc:gmx.de' => 'Prakash Cheemplavam',
+'prakashp:arcor.de' => 'Prakash Punnoor',
+'prarit:sgi.com' => 'Prarit Bhargava',
 'prasanna:in.ibm.com' => 'Prasanna S. Panchamukhi', # lbdb
 'pratik.solanki:timesys.com' => 'Pratik Solanki',
@@ -1985,4 +2127,5 @@
 'psimmons:flash.net' => 'Patrick Simmons',
 'ptiedem:de.ibm.com' => 'Peter Tiedemann',
+'ptushnik:gmail.com' => 'Vasia Pupkin',
 'purna:jcom.home.ne.jp' => 'Yusuf Wilajati Purna',
 'pwaechtler:mac.com' => 'Peter Wächtler',
@@ -1997,8 +2140,12 @@
 'r.a.mercer:blueyonder.co.uk' => 'Adam Mercer',
 'r.e.wolff:bitwizard.nl' => 'Rogier Wolff', # lbdb
+'r.e.wolff:harddisk-recovery.nl' => 'Rogier Wolff',
 'r.marek:sh.cvut.cz' => 'Rudolf Marek',
 'r.s.bultje:students.uu.nl' => 'Ronald S. Bultje',
 'radford:indigita.com' => 'Jim Radford',
+'rafael.espindola:gmail.com' => 'Rafael Ávila de Espíndola',
+'raghavendra.koushik:s2io.com' => 'Raghavendra Koushik',
 'rainer.weikusat:sncag.com' => 'Rainer Weikusat',
+'raivis:mt.lv' => 'Raivis Bucis',
 'ralf:dea.linux-mips.net' => 'Ralf Bächle',
 'ralf:linux-mips.org' => 'Ralf Bächle',
@@ -2008,4 +2155,5 @@
 'randolph:tausq.org' => 'Randolph Chung',
 'randy.dunlap:verizon.net' => 'Randy Dunlap',
+'rankincj:yahoo.com' => 'Chris Rankin',
 'ranty:debian.org' => 'Manuel Estrada Sainz',
 'ranty:ranty.pantax.net' => 'Manuel Estrada Sainz',
@@ -2015,4 +2163,6 @@
 'raul:pleyades.net' => 'Raul Nunez de Arenas Coronado',
 'raven:themaw.net' => 'Ian Kent',
+'ravinandan.arakali:neterion.com' => 'Ravinandan Arakali',
+'ravinandan.arakali:s2io.com' => 'Ravinandan Arakali',
 'ray-lk:madrabbit.org' => 'Ray Lee',
 'rbh00:utsglobal.com' => 'Richard Hitt', # asked him, he prefers Richard
@@ -2030,4 +2180,5 @@
 'reiser:namesys.com' => 'Hans Reiser',
 'rem:osdl.org' => 'Bob Miller',
+'remy.bruno:trinnov.com' => 'Remy Bruno',
 'rene.herman:keyaccess.nl' => 'Rene Herman', # lbdb
 'rene.herman:nl.rmk.(none)' => 'Rene Herman',
@@ -2049,5 +2200,9 @@
 'riel:redhat.com' => 'Rik van Riel',
 'riel:surriel.com' => 'Rik van Riel',
+'rja:sgi.com' => 'Russ Anderson',
+'rjmx:rjmx.net' => 'Ron Murray',
+'rjw:sisk.pl' => 'Rafael J. Wysocki',
 'rjweryk:uwo.ca' => 'Rob Weryk',
+'rkagan:mail.ru' => 'Roman Kagan',
 'rl:hellgate.ch' => 'Roger Luethi',
 'rlievin:free.fr' => 'Romain Liévin',
@@ -2095,4 +2250,6 @@
 'rover:tob.ru' => 'Sergei Golod',
 'rpjday:mindspring.com' => 'Robert P. J. Day',
+'rpurdie:net.rmk.(none)' => 'Richard Purdie',
+'rpurdie:rpsys.net' => 'Richard Purdie',
 'rread:clusterfs.com' => 'Robert Read',
 'rsa:us.ibm.com' => 'Ryan S. Arnold',
@@ -2138,4 +2295,5 @@
 'saidi:umich.edu' => 'Ali Saidi',
 'sailer:scs.ch' => 'Thomas Sailer',
+'sakugawa:linux-m32r.org' => 'Mamoru Sakugawa',
 'sam:mars.ravnborg.org' => 'Sam Ravnborg',
 'sam:ravnborg.org' => 'Sam Ravnborg',
@@ -2172,4 +2330,5 @@
 'scott:concord.org' => 'Scott Cytacki',
 'scott:pantastik.com' => 'Scott Russell',
+'scott:sonic.net' => 'Scott Doty',
 'scott_anderson:mvista.com' => 'Scott Anderson',
 'scottm:minion.yyz.somanetworks.com' => 'Scott Murray',
@@ -2180,5 +2339,7 @@
 'sds:epoch.ncsc.mil' => 'Stephen D. Smalley',
 'sds:tislabs.com' => 'Stephen D. Smalley',
+'sds:tycho.nsa.gov' => 'Stephen D. Smalley',
 'se.witt:gmx.net' => 'Sebastian Witt',
+'sean.hefty:intel.com' => 'Sean Hefty',
 'sean.mcgoogan:superh.com' => 'Sean McGoogan',
 'sean:mess.org' => 'Sean Young',
@@ -2188,4 +2349,5 @@
 'seife:suse.de' => 'Stefan Seyfried',
 'sergio.gelato:astro.su.se' => 'Sergio Gelato',
+'serue:us.ibm.com' => 'Serge Hallyn',
 'set:pobox.com' => 'Paul Thompson',
 'seto.hidetoshi:jp.fujitsu.com' => 'Hidetoshi Seto',
@@ -2196,6 +2358,9 @@
 'sfr:au1.ibm.com' => 'Stephen Rothwell',
 'sfr:canb.auug.org.au' => 'Stephen Rothwell',
+'sfrench:sambaltcdom.austin.ibm.com' => 'Steve French',
+'sfrench:smft41.(none)' => 'Steve French',
 'sfrench:us.ibm.com' => 'Steve French',
 'sfrost:snowman.net' => 'Stephen Frost',
+'sgrubb:redhat.com' => 'Steve Grubb',
 'shaggy:austin.ibm.com' => 'Dave Kleikamp',
 'shaggy:kleikamp.austin.ibm.com' => 'Dave Kleikamp',
@@ -2221,4 +2386,5 @@
 'silicon:falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
 'simcha:chatka.org' => 'Jan Topinski',
+'simlo:phys.au.dk' => 'Esben Nielsen',
 'simon.derr:bull.net' => 'Simon Derr',
 'simon:instant802.com' => 'Simon Barber',
@@ -2226,4 +2392,7 @@
 'simonb:lipsyncpost.co.uk' => 'Simon Burley',
 'sivanich:sgi.com' => 'Dimitri Sivanich',
+'sjackman:gmail.com' => 'Shaun Jackman',
+'sjean:cookinglinux.org' => 'Samuel Jean',
+'sjhill:realitydiluted.com' => 'Steven J. Hill',
 'skewer:terra.com.br' => 'Marcelo Abreu',
 'skip.ford:verizon.net' => 'Skip Ford',
@@ -2234,4 +2403,5 @@
 'slansky:usa.net' => 'Petr Slansky',
 'sleddog:us.ibm.com' => 'Dave Boutcher',
+'slpratt:austin.ibm.com' => 'Steven Pratt',
 'sluskyb:paranoiacs.org' => 'Ben Slusky',
 'sm0407:nurfuerspam.de' => 'Stefan Meyknecht',
@@ -2240,4 +2410,5 @@
 'smurf:play.smurf.noris.de' => 'Matthias Urlichs',
 'snailtalk:linux-mandrake.com' => 'Geoffrey Lee', # by himself
+'sndirsch:suse.de' => 'Stefan Dirsch',
 'sneakums:zork.net' => 'Sean Neakums',
 'soete.joel:tiscali.be' => 'Joel Soete',
@@ -2277,4 +2448,5 @@
 'stefan.becker:nokia.com' => 'Stefan Becker',
 'stefan.eletzhofer:eletztrick.de' => 'Stefan Eletzhofer',
+'stefan.macher:web.de' => 'Stefan Macher',
 'steiner:sgi.com' => 'Jack Steiner',
 'stekloff:w-stekloff.beaverton.ibm.com' => 'Daniel Stekloff',
@@ -2304,9 +2476,12 @@
 'stevef:steveft21.austin.ibm.com' => 'Steve French',
 'stevef:steveft21.ltcsamba' => 'Steve French',
+'stevel:mvista.com' => 'Steve Longerbeam',
 'stewart:inverse.wetlogic.net' => 'Paul Stewart',
 'stewart:linux.org.au' => 'Stewart Smith',
 'stewart:wetlogic.net' => 'Paul Stewart',
 'stewartsmith:mac.com' => 'Stewart Smith',
+'stkn:gentoo.org' => 'Stefan Knoblich',
 'stoffel:lucent.com' => 'John Stoffel',
+'stone_wang:sohu.com' => 'Stone Wang',
 'strosake:us.ibm.com' => 'Michael Strosaker',
 'stsp:aknet.ru' => 'Stas Sergeev',
@@ -2316,4 +2491,5 @@
 'suckfish:ihug.co.nz' => 'Ralph Loader',
 'sud:latinsud.com' => 'Alex Grijander',
+'sugai:isl.melco.co.jp' => 'Naoto Sugai',
 'sullivan:austin.ibm.com' => 'Mike Sullivan',
 'suncobalt.adm:hostme.bitkeeper.com' => 'Tim Hockin', # by Duncan Laurie
@@ -2329,4 +2505,5 @@
 'sxking:qwest.net' => 'Steven King',
 'sylvain.meyer:worldonline.fr' => 'Sylvain Meyer',
+'syntax:pa.net' => 'Daniel E. Markle',
 'syrjala:sci.fi' => 'Ville Syrjala',
 'szepe:pinerecords.com' => 'Tomas Szepe',
@@ -2349,10 +2526,15 @@
 'taral:taral.net' => 'Jean-Philippe Sugarbroad', # Muli Ben-Yehuda on lk
 'tausq:debian.org' => 'Randolph Chung',
+'tausq:parisc-linux.org' => 'Randolph Chung',
 'tcallawa:redhat.com' => "Tom 'spot' Callaway",
 'tchen:on-go.com' => 'Thomas Chen',
+'tduffy:sun.com' => 'Tom Duffy',
 'teanropo:cc.jyu.fi' => 'Tero Roponen',
 'tejohnson:yahoo.com' => 'Todd E. Johnson',
+'temnota+kernel:kmv.ru' => 'Andrey Melnikov',
+'temnota:kmv.ru' => 'Andrey Melnikov',
 'tes:sgi.com' => 'Timothy Shimmin',
 'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
+'tglx:de.rmk.(none)' => 'Thomas Gleixner',
 'tglx:linutronix.de' => 'Thomas Gleixner',
 'tgraf:suug.ch' => 'Thomas Graf',
@@ -2438,5 +2620,7 @@
 'trivial:rustcorp.com.au' => 'Rusty Russell',
 'trond.myklebust:fys.uio.no' => 'Trond Myklebust',
+'trond.myklebust:netapp.com' => 'Trond Myklebust',
 'trondmy:trondhjem.org' => 'Trond Myklebust',
+'tsbogend:alpha.franken.de' => 'Thomas Bogendoerfer',
 'tsk:ibakou.com' => 'Kawazoe Tomonori',
 'tspat:de.ibm.com' => 'Thomas Spatzier',
@@ -2447,4 +2631,5 @@
 'tv:tv.debian.net' => 'Tommi Virtanen',
 'tvignaud:mandrakesoft.com' => 'Thierry Vignaud',
+'tvrtko.ursulin:sophos.com' => 'Tvrtko A. Ursulin',
 'tvrtko:net4u.hr' => 'Tvrtko A. Ursulin',
 'twaugh:redhat.com' => 'Tim Waugh',
@@ -2483,4 +2668,5 @@
 'vesselin:alphawave.com.au' => 'Vesselin Kostadiov',
 'vfort:provident-solutions.com' => 'Vernon A. Fort',
+'vgoyal:in.ibm.com' => 'Vivek Goyal',
 'vherva:niksula.hut.fi' => 'Ville Herva',
 'vinay-rc:naturesoft.net' => 'Vinay K. Nallamothu',
@@ -2494,4 +2680,5 @@
 'viro:www.linux.org.uk' => 'Alexander Viro',
 'vladimir.grouzdev:jaluna.com' => 'Vladimir Grouzdev',
+'vladislav.yasevich:hp.com' => 'Vladislav Yasevich',
 'vlobanov:speakeasy.net' => 'Vadim Lobanov',
 'vmlinuz386:yahoo.com.ar' => 'Gerardo Exequiel Pozzi', # lbdb
@@ -2500,4 +2687,5 @@
 'vojta:math.berkeley.edu' => 'Paul Vojta',
 'vojtech:kernel.bkbits.net' => 'Vojtech Pavlik',
+'vojtech:silver.ucw.cz' => 'Vojtech Pavlik',
 'vojtech:suse.cz' => 'Vojtech Pavlik',
 'vojtech:twilight.ucw.cz' => 'Vojtech Pavlik',
@@ -2505,4 +2693,5 @@
 'vrajesh:eecs.umich.edu' => 'Rajesh Venkatasubramanian',
 'vrajesh:umich.edu' => 'Rajesh Venkatasubramanian',
+'vs:namesys.com' => 'Vladimir Saveliev',
 'vs:tribesman.namesys.com' => 'Vladimir Saveliev',
 'vsu:altlinux.ru' => 'Sergey Vlasov',
@@ -2512,4 +2701,5 @@
 'walter.harms:informatik.uni-oldenburg.de' => 'Walter Harms',
 'wang:ai.mit.edu' => 'Edward Wang',
+'wangzhongjun:ccoss.com.cn' => 'Wang Zhongjun',
 'warlord:mit.edu' => 'Derek Atkins',
 'warp:mercury.d2dc.net' => 'Zephaniah E. Hull',
@@ -2544,4 +2734,5 @@
 'willy:org.rmk' => 'Matthew Wilcox',
 'willy:org.rmk.(none)' => 'Matthew Wilcox',
+'willy:parisc-linux.org' => 'Matthew Wilcox',
 'willy:w.ods.org' => 'Willy Tarreau',
 'wilsonc:abocom.com.tw' => 'Wilson Chen', # google
@@ -2583,4 +2774,5 @@
 'yuasa:hh.iij4u.or.jp' => 'Yoichi Yuasa',
 'yuri:acronis.com' => 'Yuri Per', # lbdb
+'yust:anti-leasure.ru' => 'Alex Yustasov',
 'yuvalt:gmail.com' => 'Yuval Turgeman',
 'zach:vmware.com' => 'Zachary Amsden',
@@ -2593,4 +2785,5 @@
 'zecke:org.rmk.(none)' => 'Holger Freyther',
 'zeevon:debian.org' => 'Warren A. Layton',
+'zhenyu.z.wang:intel.com' => 'Zhenyu Z. Wang',
 'zinx:epicsol.org' => 'Zinx Verituse',
 'zippel:linux-m68k.org' => 'Roman Zippel',
@@ -3229,5 +3422,5 @@
 	    "swap!", "merge!", "warn!", "multi!", "abbreviate-names!",
 	    "by-surname!", "selftest", "ignoremerge!", "omitaddresses!",
-	    "obfuscate!");
+	    "obfuscate!", "warnverbose!");
 #	    "bitkeeper|bk!");
 
@@ -3387,5 +3580,5 @@
     }
   }
-  if (scalar keys %address_found_in_from) {
+  if ($opt{warnverbose} and scalar keys %address_found_in_from) {
     print STDERR "Info: these address mappings could be added after clean-up:\n";
     foreach (sort caseicmp keys %address_found_in_from) {
@@ -3424,4 +3617,8 @@
      --[no]multi     states that multiple changelogs are in one file
      --[no]warn      warn about unknown addresses. Default: set!
+     --[no]warnverbose
+                     suggest more addresses to be added from
+                     Signed-off-by and From lines. Default: unset.
+                     Use with caution!
      --[no]abbreviate-names
                      abbreviate all but the last name

