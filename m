Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268283AbUJSCGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268283AbUJSCGN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 22:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268301AbUJSCGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 22:06:12 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:62903 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S268283AbUJSCCP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 22:02:15 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.324
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue,_19_Oct_2004_02_01_58_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20041019020158.1135FC0841@merlin.emma.line.org>
Date: Tue, 19 Oct 2004 04:01:58 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.324 has been released.

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
revision 0.324
date: 2004/10/19 01:59:56;  author: emma;  state: Exp;  lines: +125 -4
Pull in new BK revision as of 2004-10-19, to do a release.
----------------------------
revision 0.323
date: 2004/08/25 12:58:06;  author: vita;  state: Exp;  lines: +15 -1
merged Linus' additions (2 addresses); added 12 new addresses
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.323
retrieving revision 0.324
diff -u -r0.323 -r0.324
--- lk-changelog.pl	25 Aug 2004 12:58:06 -0000	0.323
+++ lk-changelog.pl	19 Oct 2004 01:59:56 -0000	0.324
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.323 2004/08/25 12:58:06 vita Exp $
+# $Id: lk-changelog.pl,v 0.324 2004/10/19 01:59:56 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -244,6 +244,7 @@
 'alex:clusterfs.com' => 'Alex Tomas',
 'alex:de.rmk.(none)' => 'Alexander Schulz',
 'alex:netchip.com' => 'Alex Sanks',
+'alex:skip86.com' => 'Alexander Clausen',
 'alex:ssi.bg' => 'Alexander Atanasov',
 'alex_williamson:attbi.com' => 'Alex Williamson', # lbdb
 'alex_williamson:com.rmk.(none)' => 'Alex Williamson',
@@ -265,6 +266,7 @@
 'amir.noam:intel.com' => 'Amir Noam',
 'amitg:edu.rmk.(none)' => 'Amit Gurdasani',
 'amn3s1a:ono.com' => 'Miguel A. Fosas',
+'amodra:bigpond.net.au' => 'Alan Modra',
 'amunoz:vmware.com' => 'Alberto Munoz',
 'ananth:in.ibm.com' => 'Ananth N. Mavinakayanahalli',
 'andersen:codepoet.org' => 'Erik Andersen',
@@ -274,6 +276,7 @@
 'andre.breiler:null-mx.org' => 'André Breiler',
 'andre.landwehr:gmx.net' => 'Andre Landwehr',
 'andre:linux-ide.org' => 'Andre Hedrick',
+'andrea:novell.com' => 'Andrea Arcangeli',
 'andrea:suse.de' => 'Andrea Arcangeli',
 'andreas:xss.co.at' => 'Andreas Haumer',
 'andrej.filipcic:ijs.si' => 'Andrej Filipcic',
@@ -284,6 +287,7 @@
 'andrew:lunn.ch' => 'Andrew Lunn',
 'andries.brouwer:cwi.nl' => 'Andries E. Brouwer',
 'andros:citi.umich.edu' => 'Andy Adamson',
+'andros:umich.edu' => 'Andy Adamson',
 'andyw:uk.ibm.com' => 'Andy Whitcroft',
 'aneesh.kumar:digital.com' => 'Aneesh Kumar KV',
 'aneesh.kumar:gmail.com' => 'Aneesh Kumar',
@@ -291,12 +295,15 @@
 'aniket:sgi.com' => 'Aniket Malatpure',
 'anil.s.keshavamurthy:intel.com' => 'Anil Keshavamurthy',
 'ankry:green.mif.pg.gda.pl' => 'Andrzej Krzysztofowicz',
+'annabellesgarden:yahoo.de' => 'Karsten Wiese',
 'anton:samba.org' => 'Anton Blanchard',
 'anton:superego.(none)' => 'Anton Blanchard',
 'anton:superego.ozlabs.ibm.com' => 'Anton Blanchard',
 'aoliva:redhat.com' => 'Alexandre Oliva',
 'ap:cipherica.com' => 'Alex Pankratov',
+'apm:brigitte.dna.fi' => 'Antti P. Miettinen',
 'apolkosnik:directvinternet.com' => 'Adam Polkosnik',
+'appro:fy.chalmers.se' => 'Andy Polyakov',
 'apw:shadowen.org' => 'Andy Whitcroft',
 'aradford:amcc.com' => 'Adam Radford',
 'arashi:yomerashi.yi.org' => 'Matt Reppert',
@@ -350,6 +357,8 @@
 'bart.de.schuyer:pandora.be' => 'Bart De Schuymer',
 'bart.de.schuymer:pandora.be' => 'Bart De Schuymer',
 'bart:samwel.tk' => 'Bart Samwel',
+'baruch:ev-en.org' => 'Baruch Even',
+'bastian:waldi.eu.org' => 'Bastian Blank',
 'bbosch:iphase.com' => 'Bradley A. Bosch',
 'bbuesker:qualcomm.com' => 'Brian Buesker',
 'bcasavan:sgi.com' => 'Brent Casavant',
@@ -364,7 +373,9 @@
 'beattie:beattie-home.net' => 'Brian Beattie', # from david.nelson
 'bellucda:tiscali.it' => 'Daniele Bellucci',
 'ben-linux:org.rmk.(none)' => 'Ben Dooks',
+'ben:simtec.co.uk' => 'Ben Dooks',
 'bengen:hilluzination.de' => 'Hilko Bengen',
+'benh:kenrel.crashing.org' => 'Benjamin Herrenschmidt', # typo
 'benh:kernel.crashing.org' => 'Benjamin Herrenschmidt',
 'benh:zion.wanadoo.fr' => 'Benjamin Herrenschmidt',
 'benjl:cse.unsw.edu.au' => 'Ben Leslie',
@@ -385,6 +396,7 @@
 'bhavesh:avaya.com' => 'Bhavesh P. Davda',
 'bheilbrun:paypal.com' => 'Brad Heilbrun', # by himself
 'bjoern:j3e.de' => 'Bjoern Jacke',
+'bjohnson:sgi.com' => 'Brian J. Johnson',
 'bjorn.andersson:erc.ericsson.se' => 'Björn Andersson', # google, guessed ö
 'bjorn.helgaas:com.rmk.(none)' => 'Bjorn Helgaas',
 'bjorn.helgaas:hp.com' => 'Bjorn Helgaas',
@@ -396,8 +408,11 @@
 'blaisorblade_spam:yahoo.it' => 'Paolo \'Blaisorblade\' Giarrusso',
 'blaschke:blaschke3.austin.ibm.com' => 'Dave Blaschke',
 'blazara:nvidia.com' => 'Brian Lazara',
+'blofeldus:com.rmk.(none)' => 'Roger Blofeld',
 'blueflux:koffein.net' => 'Oskar Andreasson',
 'bmatheny:purdue.edu' => 'Blake Matheny', # google
+'bo.henriksen:com.rmk.(none)' => 'Bo Henriksen',
+'bo.henriksen:nordicid.com' => 'Bo Henriksen',
 'bogdan.costescu:iwr.uni-heidelberg.de' => 'Bogdan Costescu',
 'bombe:informatik.tu-muenchen.de' => 'Andreas Bombe',
 'boris.hu:intel.com' => 'Boris Hu',
@@ -424,13 +439,17 @@
 'bugfixer:list.ru' => 'Nick Orlov',
 'bunk:de.rmk.(none)' => 'Adrian Bunk', # guessed
 'bunk:fs.tum.de' => 'Adrian Bunk',
+'bunk:stusta.de' => 'Adrian Bunk',
 'buytenh:gnu.org' => 'Lennert Buytenhek',
+'buytenh:org.rmk.(none)' => 'Lennert Buytenhek',
 'buytenh:wantstofly.org' => 'Lennert Buytenhek',
 'bwa:us.ibm.com' => 'Bruce Allan',
 'bwheadley:earthlink.net' => 'Bryan W. Headley',
 'bwindle:fint.org' => 'Burton N. Windle',
 'bzeeb-lists:lists.zabbadoz.net' => 'Björn A. Zeeb', # lbdb
 'bzolnier:elka.pw.edu.pl' => 'Bartlomiej Zolnierkiewicz',
+'bzolnier:gmail.com' => 'Bartlomiej Zolnierkiewicz',
+'bzolnier:trik.(none)' => 'Bartlomiej Zolnierkiewicz',
 'bzzz:gerasimov.net' => 'Alex Tomas',
 'bzzz:tmi.comex.ru' => 'Alex Tomas',
 'c-d.hailfinger.kernel.2002-07:gmx.net' => 'Carl-Daniel Hailfinger',
@@ -441,7 +460,9 @@
 'cagle:mindspring.com' => 'John Cagle', # Alan
 'calum.mackay:cdmnet.org' => 'Calum Mackay', # lbdb
 'cananian:lesser-magoo.lcs.mit.edu' => 'C. Scott Ananian',
+'cannam:all-day-breakfast.com' => 'Chris Cannam',
 'car.busse:gmx.de' => 'Carsten Busse',	# verified by Greg KH
+'castet.matthieu:free.fr' => 'Matthieu Castet',
 'castor:3pardata.com' => 'Castor Fu',
 'cat:zip.com.au' => 'CaT',
 'catalin.marinas:com.rmk.(none)' => 'Catalin Marinas',
@@ -467,6 +488,7 @@
 'chan:aleph1.co.uk' => 'Tak-Shing Chan',
 'char:cmf.nrl.navy.mil' => 'Chas Williams', # typo ???
 'charles.white:hp.com' => 'Charles White',
+'chaus:cs.uni-potsdam.de' => 'Carsten Haustein',
 'chessman:tux.org' => 'Samuel S. Chessman',
 'chip:pobox.com' => 'Chip Salzenberg', # lbdb
 'chris:heathens.co.nz' => 'Chris Heath',
@@ -476,6 +498,7 @@
 'chrisg:etnus.com' => 'Chris Gottbrath',
 'chrisl:vmware.com' => 'Christopher Li',
 'christer:weinigel.se' => 'Christer Weinigel', # from shortlog
+'christian:borntraeger.net' => 'Christian Borntraeger',
 'christoph:graphe.net' => 'Christoph Lameter',
 'christophe:saout.de' => 'Christophe Saout',
 'christopher.leech:intel.com' => 'Christopher Leech',
@@ -515,7 +538,9 @@
 'cp:absolutedigital.net' => 'Cal Peake',
 'cpg:aladdin.de' => 'Christian Groessler',
 'cpg:puchol.com' => 'Carlos Puchol',
+'cph:cph.demon.co.uk' => 'Colin Phipps',
 'cph:zurich.ai.mit.edu' => 'Chris Hanson',
+'cr7:os.inf.tu-dresden.de' => 'Carsten Rietzschel',
 'cr:sap.com' => 'Christoph Rohland',
 'craig.nadler:arc.com' => 'Craig Nadler',
 'craig:homerjay.homelinux.org' => 'Craig Wilkie',
@@ -567,8 +592,10 @@
 'davej:suse.de' => 'Dave Jones',
 'davej:tetrachloride.(none)' => 'Dave Jones',
 'davem:cheetah.(none)' => 'David S. Miller',
+'davem:davemloft.net' => 'David S. Miller',
 'davem:hera.kernel.org' => 'David S. Miller',
 'davem:kernel.bkbits.net' => 'David S. Miller',
+'davem:netfilter.org' => 'David S. Miller',
 'davem:nuts.davemloft.net' => 'David S. Miller',
 'davem:redhat.co' => 'David S. Miller',
 'davem:redhat.com' => 'David S. Miller',
@@ -607,6 +634,7 @@
 'dent:cosy.sbg.ac.at' => "Thomas 'Dent' Mirlacher",
 'der.eremit:email.de' => 'Pascal Schmidt',
 'derek:ihtfp.com' => 'Derek Atkins',
+'dev:sw.ru' => 'Kirill Korotaev',
 'devel:brodo.de' => 'Dominik Brodowski',
 'devenyga:mcmaster.ca' => 'Gabriel Devenyi',
 'devik:cdi.cz' => 'Martin Devera',
@@ -641,6 +669,7 @@
 'dok:directfb.org' => 'Denis Oliver Kropp',
 'dolbeau:irisa.fr' => 'Romain Dolbeau',
 'domen:coderock.org' => 'Domen Puncer',
+'doug:easyco.com' => 'Doug Dumitru',
 'dougg:torque.net' => 'Douglas Gilbert',
 'doyle:primenet.com' => 'Bob Doyle',
 'drambo:broadcom.com' => 'Darwin Rambo',
@@ -648,8 +677,12 @@
 'drepper:redhat.com' => 'Ulrich Drepper',
 'drewie:freemail.hu' => 'Andras Bali',
 'driver:huey.jpl.nasa.gov' => 'Bryan B. Whitehead', # google
+'drizzd:aon.at' => 'Clemens Buchacher',
 'drow:false.org' => 'Daniel Jacobowitz',
 'drow:nevyn.them.org' => 'Daniel Jacobowitz',
+'drzeus-list:cx.rmk.(none)' => 'Pierre Ossman',
+'drzeus-list:drzeus.cx' => 'Pierre Ossman',
+'ds-fraser:comcast.net' => 'Douglas Fraser',
 'dsaxena:com.rmk' => 'Deepak Saxena',
 'dsaxena:com.rmk.(none)' => 'Deepak Saxena',
 'dsaxena:mvista.com' => 'Deepak Saxena',
@@ -669,6 +702,7 @@
 'duwe:suse.de' => 'Torsten Duwe',
 'dvrabel:arcom.com' => 'David Vrabel',
 'dvrabel:com.rmk.(none)' => 'David Vrabel',
+'dwcraig:qualcomm.com' => 'Dave Craig',
 'dwg:au.ibm.com' => 'David Gibson',
 'dwg:au1.ibm.com' => 'David Gibson',
 'dwmw2:dwmw2.baythorne.internal' => 'David Woodhouse',
@@ -680,7 +714,8 @@
 'ebrower:resilience.com' => 'Eric Brower',
 'ebrower:usa.net' => 'Eric Brower',
 'ebs:ebshome.net' => 'Eugene Surovegin',
-'ecashin:uga.edu' => 'Ed L Cashin',
+'ecashin:coraid.com' => 'Ed L. Cashin',
+'ecashin:uga.edu' => 'Ed L. Cashin',
 'ecd:skynet.be' => 'Eddie C. Dost',
 'eddie.williams:steeleye.com' => 'Eddie Williams',
 'edv:macrolink.com' => 'Ed Vance',
@@ -716,6 +751,7 @@
 'eranian:hpl.hp.co' => 'Stéphane Eranian', # typo
 'eranian:hpl.hp.com' => 'Stéphane Eranian',
 'erbenson:alaska.net' => 'Ethan Benson',
+'eric.lemoine:gmail.com' => 'Eric Lemoine',
 'eric.piel:bull.net' => 'Eric Piel',
 'eric.valette:free.fr' => 'Eric Valette',
 'eric:lammerts.org' => 'Eric Lammerts',
@@ -724,6 +760,7 @@
 'erik:harddisk-recovery.nl' => 'Erik Mouw',
 'erik:rigtorp.com' => 'Erik Rigtorp',
 'erik_habbinga:hp.com' => 'Erik Habbinga',
+'erikj:sgi.com' => 'Erik Jacobson',
 'erikj:subway.americas.sgi.com' => 'Erik Jacobson',
 'erlend-a:us.his.no' => 'Erlend Aasland',
 'erlend-a:ux.his.no' => 'Erlend Aasland',
@@ -782,6 +819,7 @@
 'fscked:netvisao.pt' => 'Paulo André',
 'fsgqa:sgi.com' => 'Nathan Scott',
 'fubar:us.ibm.com' => 'Jay Vosburgh',
+'fujiwara:linux-m32r.org' => 'Hayato Fujiwara',
 'fw:deneb.enyo.de' => 'Florian Weimer', # lbdb
 'fzago:austin.rr.com' => 'Frank Zago', # google
 'g.liakhovetski:gmx.de' => 'Guennadi Liakhovetski',
@@ -800,6 +838,7 @@
 'gary_lerhaupt:dell.com' => 'Gary Lerhaupt',
 'garyhade:us.ibm.com' => 'Gary Hade',
 'gbarzini:virata.com' => 'Guido Barzini',
+'gcardwel:motorola.com' => 'Guy Cardwell',
 'gdavis:mvista.com' => 'George G. Davis',
 'geert.uytterhoeven:sonycom.com' => 'Geert Uytterhoeven',
 'geert:linux-m68k.org' => 'Geert Uytterhoeven',
@@ -818,6 +857,7 @@
 'giri:lmc.cs.sunysb.edu' => 'Giridhar Pemmasani',
 'giuseppe.furlan:systeam.it' => 'Giuseppe Furlan',
 'gj:pointblue.com.pl' => 'Grzegorz Jaskiewicz',
+'gjaeger:sysgo.com' => 'Gerhard Jaeger',
 'gkernel.adm:hostme.bitkeeper.com' => 'Jeff Garzik', # himself
 'gl:dsa-ac.de' => 'Guennadi Liakhovetski',
 'glee:gnupilgrims.org' => 'Geoffrey Lee', # lbdb
@@ -872,6 +912,7 @@
 'hare:suse.de' => 'Hannes Reinecke',
 'haveblue:us.ibm.com' => 'Dave Hansen',
 'hawkes:oss.sgi.com' => 'John Hawkes',
+'hbabu:us.ibm.com' => 'Haren Myneni',
 'hch:caldera.de' => 'Christoph Hellwig',
 'hch:com.rmk' => 'Christoph Hellwig',
 'hch:com.rmk.(none)' => 'Christoph Hellwig',
@@ -895,6 +936,7 @@
 'henrique2.gobbi:cyclades.com' => 'Henrique Gobbi',
 'henrique:cyclades.com' => 'Henrique Gobbi',
 'herbert:13thfloor.at' => 'Herbert Pötzl', # lbdb
+'herbert:gondor.apan.org.au' => 'Herbert Xu',
 'herbert:gondor.apana.org.au' => 'Herbert Xu',
 'herbet:gondor.apana.org.au' => 'Herbert Xu',
 'hermes:gibson.dropbear.id' => 'David Gibson',
@@ -922,9 +964,11 @@
 'hunold:convergence.de' => 'Michael Hunold',
 'hunold:linuxtv.org' => 'Michael Hunold',
 'hverhagen:dse.nl' => 'Harm Verhagen',
+'hvr:gnu.org' => 'Herbert V. Riedel',
 'hwahl:hwahl.de' => 'Hartmut Wahl',
 'hzhong:cisco.com' => 'Hua Zhong',
 'i.palsenberg:jdirmedia.nl' => 'Igmar Palsenberg', # lbdb
+'i:stingr.net' => 'Paul P. Komkoff Jr.',
 'ian.abbott:mev.co.uk' => 'Ian Abbott',
 'ianw:gelato.unsw.edu.au' => 'Ian Wienand', # lbdb
 'ica2_ts:csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
@@ -954,6 +998,7 @@
 'j.dittmer:portrix.net' => 'Jan Dittmer',
 'ja:ssi.bg' => 'Julian Anastasov',
 'jaap.keuter:xs4all.nl' => 'Jaap Keuter',
+'jacekpoplawski:wp.pl' => 'Jacek Poplawski',
 'jack:suse.cz' => 'Jan Kara',
 'jack:ucw.cz' => 'Jan Kara',
 'jack_hammer:adaptec.com' => 'Jack Hammer',
@@ -964,6 +1009,7 @@
 'jakub:redhat.com' => 'Jakub Jelínek',
 'jamagallon:able.es' => 'J. A. Magallon',
 'james.bottomley:steeleye.com' => 'James Bottomley',
+'james.smart:emulex.com' => 'James Smart',
 'james:cobaltmountain.com' => 'James Mayer',
 'james:superbug.demon.co.uk' => 'James Courtier-Dutton',
 'james_mcmechan:hotmail.com' => 'James McMechan',
@@ -980,7 +1026,9 @@
 'jani:astechnix.ro' => 'Jani Monoses',
 'jani:iv.ro' => 'Jani Monoses',
 'janiceg:us.ibm.com' => 'Janice M. Girouard',
+'janitor:at.none.(rmk)' => 'Maximilian Attems',
 'janitor:sternwelten.at' => 'Maximilian Attems',
+'jason.davis:unisys.com' => 'Jason Davis',
 'jasper:vs19.net' => 'Jasper Spaans',
 'javaman:katamail.com' => 'Paulo Ornati',
 'javier:tudela.mad.ttd.net' => 'Javier Achirica',
@@ -995,13 +1043,15 @@
 'jbm:joshisanerd.com' => 'Josh Myer',
 'jbourne:hardrock.org' => 'James Bourne',
 'jcdutton:users.sourceforge.net' => 'James Courtier-Dutton',
+'jd:rightthere.net' => 'Jason Davis',
 'jdavid:farfalle.com' => 'David Ruggiero',
 'jdewand:redhat.com' => 'Julie DeWandel',
-'jdgaston:snoqualmie.dp.intel.com' => 'Jason D Gaston',
+'jdgaston:snoqualmie.dp.intel.com' => 'Jason D. Gaston',
 'jdike:addtoit.com' => 'Jeff Dike',
 'jdike:jdike.wstearns.org' => 'Jeff Dike',
 'jdike:karaya.com' => 'Jeff Dike',
 'jdike:uml.karaya.com' => 'Jeff Dike',
+'jdow:earthlink.net' => 'Joanne Dow',
 'jdr:farfalle.com' => 'David Ruggiero',
 'jdthood:yahoo.co.uk' => 'Thomas Hood',
 'jean-luc.richier:imag.fr' => 'Jean-Luc Richier',
@@ -1014,10 +1064,13 @@
 'jeffpc:optonline.net' => 'Josef \'Jeff\' Sipek',
 'jeffs:accelent.com' => 'Jeff Sutherland', # lbdb
 'jejb:fuzzy.(none)' => 'James Bottomley',
+'jejb:ios.(none)' => 'James Bottomley',
 'jejb:jet.(none)' => 'James Bottomley', # wild guess
 'jejb:malley.(none)' => 'James Bottomley',
 'jejb:mulgrave.(none)' => 'James Bottomley', # from shortlog
+'jejb:pashleys.(none)' => 'James Bottomley',
 'jejb:raven.il.steeleye.com' => 'James Bottomley',
+'jejb:titanic.il.steeleye.com' => 'James Bottomley',
 'jelenz:edu.rmk.(none)' => 'John Lenz',
 'jelenz:students.wisc.edu' => 'John Lenz',
 'jenna.s.hall:intel.com' => 'Jenna S. Hall', # google
@@ -1072,6 +1125,7 @@
 'jmorris:intercode.com.au' => 'James Morris',
 'jmorris:redhat.com' => 'James Morris',
 'jmorros:intercode.com.au' => 'James Morris',	# it's typo IMHO
+'jmoyer:redhat.com' => 'Jeff Moyer',
 'jmunsin:iki.fi' => 'Jonas Munsin',
 'jnardelli:infosciences.com' => 'Joe Nardelli',
 'jo-lkml:suckfuell.net' => 'Jochen Suckfuell',
@@ -1085,6 +1139,7 @@
 'joel.buckley:sun.com' => 'Joel Buckley',
 'joergprante:netcologne.de' => 'Jörg Prante',
 'joern:infradead.org' => 'Jörn Engel',
+'joern:wh.fh-wedel.de' => 'Jorn Engel',
 'joern:wohnheim.fh-wedel.de' => 'Jörn Engel',
 'johan.adolfsson:axis.com' => 'Johan Adolfsson',
 'johann.cardon:free.fr' => 'Johann Cardon',
@@ -1109,6 +1164,7 @@
 'jonas.larsson:net.rmk.(none)' => 'Jonas Larsson',
 'jonas:thornblad.net' => 'Jonas Thornblad',
 'jones:ingate.com' => 'Jones Desougi',
+'jonsmirl:gmail.com' => 'Jon Smirl',
 'jonsmirl:yahoo.com' => 'Jon Smirl',
 'joris:eljakim.nl' => 'Joris van Rantwijk',
 'joris:struyve.be' => 'Joris Struyve',
@@ -1143,12 +1199,14 @@
 'jun.nakajima:intel.com' => 'Jun Nakajima',
 'jung-ik.lee:intel.com' => 'Jung-Ik Lee',
 'junkio:cox.net' => 'Junio C. Hamano',
+'junx.yao:intel.com' => 'Yao Jun',
 'jurgen:botz.org' => 'Jürgen Botz',
 'jwboyer:charter.net' => 'Josh Boyer',
 'jwboyer:infradead.org' => 'Josh Boyer',
 'jwoithe:physics.adelaide.edu.au' => 'Jonathan Woithe',
 'k-suganuma:mvj.biglobe.ne.jp' => 'Kimio Suganuma',
 'k.kasprzak:box43.pl' => 'Karol Kasprzak', # by Kristian Peters
+'kaber:coreworks.de' => 'Patrick McHardy',
 'kaber:trash.net' => 'Patrick McHardy',
 'kadlec:blackhole.kfki.hu' => 'Jozsef Kadlecsik',
 'kai-germaschewski:uiowa.edu' => 'Kai Germaschewski',
@@ -1160,6 +1218,7 @@
 'kai:vaio.(none)' => 'Kai Germaschewski',
 'kai:zephyr.physics.uiowa.edu' => 'Kai Germaschewski',
 'kaie:kuix.de' => 'Kai Engert',
+'kaigai:ak.jp.nec.com' => 'KaiGai Kohei',
 'kala:pinerecords.com' => 'Tomas Szepe',
 'kalev:smartlink.ee' => 'Kalev Lember',
 'kalin:thinrope.net' => 'Kalin Rumenov Kozhuharov',
@@ -1183,6 +1242,7 @@
 'kde:myrealbox.com' => 'Ismail Donmez',
 'kdesler:soohrt.org' => 'Karsten Desler',
 'kdrader:us.ibm.com' => 'Kurtis D. Rader',
+'keith:tungstengraphics.com' => 'Keith Whitwell',
 'keithu:parl.clemson.edu' => 'Keith Underwood',
 'kenn:linux.ie' => 'Kenn Humborg',
 'kenneth.w.chen:intel.com' => 'Kenneth W. Chen',
@@ -1201,6 +1261,7 @@
 'kevin:koconnor.net' => 'Kevin O\'Connor',
 'kevin:org.rmk.(none)' => 'Kevin Hilman',
 'kevino:asti-usa.com' => 'Kevin Owen',
+'kevmack:accesscomm.ca' => 'Kevin Mack',
 'key:austin.ibm.com' => 'Kent Yoder',
 'khaho:koti.soon.fi' => 'Ari Juhani Hämeenaho',
 'khali:linux-fr.org' => 'Jean Delvare', # lbdb
@@ -1210,6 +1271,7 @@
 'khc:pc.waw.pl' => 'Krzysztof Halasa',
 'khc:pm.waw.pl' => 'Krzysztof Halasa',
 'kieran:mgpenguin.net' => 'Kieran Morrissey',
+'kihara.seiji:lab.ntt.co.jp' => 'Seiji Kihara',
 'killekulla:rdrz.de' => 'Raphael Zimmerer',
 'kingsley:aurema.com' => 'Cheung Kingsley',
 'kiran:in.ibm.com' => 'Ravikiran G. Thirumalai',
@@ -1219,6 +1281,8 @@
 'kkeil:isdn4linux.de' => 'Karsten Keil',
 'kkeil:suse.de' => 'Karsten Keil',
 'kkourt:cslab.ece.ntua.gr' => 'Kornilios Kourtis',
+'kksx:mail.ru' => 'Kirill Korotaev',
+'kksx:maul.ru' => 'Kirill Korotaev',
 'kl:gjs.cc' => 'Gert-Jan Spoelman',
 'klaas.de.waal:hccnet.nl' => 'Klaas de Waal',
 'klassert:mathematik.ru-chemnitz.de' => 'Steffen Klassert', # typo, leave in
@@ -1235,6 +1299,7 @@
 'komujun:nifty.com' => 'Jun Komuro', # google
 'kpc-usbdev:gelato.uiuc.edu' => 'Kevin Cernekee',
 'kpfleming:cox.net' => 'Kevin P. Fleming',
+'kpreslan:redhat.com' => 'Ken Preslan',
 'kravetz:us.ibm.com' => 'Mike Kravetz',
 'kraxel:bytesex.org' => 'Gerd Knorr',
 'kraxel:suse.de' => 'Gerd Knorr',
@@ -1250,6 +1315,7 @@
 'kumar.gala:motorola.com' => 'Kumar Gala',
 'kumarkr:us.ibm.com' => 'Krishna Kumar',
 'kunihiro:ipinfusion.com' => 'Kunihiro Ishiguro',
+'kunitake:anchor.jp' => 'KUNITAKE Koichi',
 'kurt.robideau:comtrol.com' => 'Kurt Robideau',	# wild guess
 'kyle:debian.org' => 'Kyle McMartin',
 'kyle:engsoc.carleton.ca' => 'Kyle McMartin',
@@ -1260,12 +1326,14 @@
 'laforge:gnumonks.org' => 'Harald Welte',
 'laforge:netfilter.org' => 'Harald Welte',
 'laforge:org.rmk.(none)' => 'Harald Welte', # guessed
+'lars.ellenberg:linbit.com' => 'Lars Ellenberg',
 'lathiat:sixlabs.org' => 'Trent Lathiat Lloyd',
 'latten:austin.ibm.com' => 'Joy Latten',
 'laubrycomm:free.fr' => 'Ludovic Aubry',
 'laurent:latil.nom.fr' => 'Laurent Latil',
 'lavarre:iomega.com' => 'Pat LaVarre',
 'lawrence:the-penguin.otak.com' => 'Lawrence Walton',
+'lcapitulino:conectiva.com.br' => 'Luiz Capitulino',
 'lcapitulino:prefeitura.sp.gov.br' => 'Luiz Capitulino',
 'ldb:ldb.ods.org' => 'Luca Barbieri',
 'ldl:aros.net' => 'Lou Langholtz',
@@ -1281,6 +1349,7 @@
 'lenb:dhcppc6.' => 'Len Brown',
 'lenehan:twibble.org' => 'Jamie Lenehan',
 'leoli:freescale.com' => 'Li Yang',
+'lesanti:sinectis.com.ar' => 'Leandro Santi',
 'lethal:linux-sh.org' => 'Paul Mundt',
 'lethal:unusual.internal.linux-sh.org' => 'Paul Mundt',
 'levon:movementarian.org' => 'John Levon',
@@ -1332,6 +1401,7 @@
 'louisk:cse.unsw.edu.au' => 'Louis Yu-Kiu Kwan',
 'lowekamp:cs.wm.edu' => 'Bruce B. Lowekamp', # lbdb
 'luben:splentec.com' => 'Luben Tuikov',
+'luben_tuikov:adaptec.com' => 'Luben Tuikov',
 'luc.vanoostenryck:easynet.be' => 'Luc Van Oostenryck', # lbdb
 'luca.risolia:studio.unibo.it' => 'Luca Risolia',
 'luca:libero.it' => 'Luca Risolia',
@@ -1398,6 +1468,7 @@
 'martin.bligh:us.ibm.com' => 'Martin J. Bligh',
 'martin.lubich:gmx.at' => 'Martin Lubich',
 'martin.schwidefsky:debitel.net' => 'Martin Schwidefsky',
+'martin.wilck:fujitsu-siemens.com' => 'Martin Wilck',
 'martin:bruli.net' => 'Martin Brulisauer',
 'martin:mdiehl.de' => 'Martin Diehl',
 'martin:meltin.net' => 'Martin Schwenke',
@@ -1414,6 +1485,7 @@
 'matthewc:cse.unsw.edu.au' => 'Matthew Chapman',
 'matthewn:snapgear.com' => 'Matthew Natalier',
 'matthias.andree:gmx.de' => 'Matthias Andree', # added by himself
+'mauelshagen:redhat.com' => 'Heinz J. Mauelshagen',
 'mauelshagen:sistina.com' => 'Heinz J. Mauelshagen',
 'maverick:eskuel.net' => 'Mathieu Lesniak',
 'maxim:de.ibm.com' => 'Maxim Shchetynin',
@@ -1446,6 +1518,7 @@
 'metolent:snoqualmie.dp.intel.com' => 'Matt Tolentino',
 'mfedyk:matchmail.com' => 'Mike Fedyk',
 'mgalgoci:redhat.com' => 'Matthew Galgoci',
+'mgoodman:csua.berkeley.edu' => 'Mark Goodman',
 'mgreer:mivsta.com' => 'Mark A. Greer', # typo
 'mgreer:mvista.com' => 'Mark A. Greer', # lbdb
 'mhf:linuxmail.org' => 'Michael Frank',
@@ -1495,6 +1568,7 @@
 'minyard:acm.org' => 'Corey Minyard',
 'miquels:cistron.nl' => 'Miquel van Smoorenburg',
 'mirage:kaotik.org' => 'Tiago Sousa',
+'mita:yacht.ocn.ne.jp' => 'Akinobu Mita',
 'mitch:sfgoth.com' => 'Mitchell Blank Jr.',
 'miura:da-cha.org' => 'Hiroshi Miura',
 'miurahr:nttdata.co.jp' => 'Hiroshi Miura',
@@ -1517,6 +1591,7 @@
 'mochel:geena.pdx.osdl.net' => 'Patrick Mochel',
 'mochel:hera.kernel.org' => 'Patrick Mochel',
 'mochel:kernel.bkbits.net' => 'Patrick Mochel',
+'mochel:linux.site' => 'Patrick Mochel',
 'mochel:osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdlab.org' => 'Patrick Mochel',
@@ -1566,6 +1641,7 @@
 'nemosoft:smcc.demon.nl' => 'Nemosoft Unv.',
 'netfilter:interlinx.bc.ca' => 'Brian J. Murrell',
 'nfont:austin.ibm.com' => 'Nathan Fontenot',
+'nhorman:redhat.com' => 'Neil Horman',
 'nick.holloway:pyrites.org.uk' => 'Nick Holloway',
 'nickpiggin:cyberone.com.au' => 'Nick Piggin',
 'nickpiggin:yahoo.com.au' => 'Nick Piggin',
@@ -1594,6 +1670,7 @@
 'normalperson:yhbt.net' => 'Eric Wong',
 'not:just.any.name' => 'John Fremlin',
 'notting:redhat.com' => 'Bill Nottingham',
+'nreilly:magma.ca' => 'Nicholas Reilly',
 'nstraz:sgi.com' => 'Nathan Straz',
 'ntfs:flatcap.org' => 'Richard Russon', # lbdb
 'ntl:pobox.com' => 'Nathan T. Lynch',
@@ -1621,6 +1698,7 @@
 'omkhar:rogers.com' => 'Omkhar Arasaratnam',
 'orange:fobie.net' => 'Örjan Persson',
 'orjan.friberg:axis.com' => 'Orjan Friberg',
+'ornati:fastwebnet.it' => 'Paolo Ornati',
 'os:emlix.com' => 'Oskar Schirmer', # sent by himself
 'ossi:kde.org' => 'Oswald Buddenhagen',
 'osst:riede.org' => 'Willem Riede',
@@ -1647,6 +1725,7 @@
 'patmans:us.ibm.com' => 'Patrick Mansfield',
 'patrick.boettcher:desy.de' => 'Patrick Boettcher',
 'patrick:dreker.de' => 'Patrick Dreker', # lbdb
+'patrick:tykepenguin.com' => 'Patrick Caulfield',
 'patrick:wildi.com' => 'Patrick Wildi',
 'paubert:iram.es' => 'Gabriel Paubert',
 'paul+nospam:wurtel.net' => 'Paul Slootman',
@@ -1685,6 +1764,7 @@
 'pee:erkkila.org' => 'Paul E. Erkkila',
 'pekon:informatics.muni.cz' => 'Petr Konecny',
 'pelle:dsv.su.se' => 'Per Olofsson',
+'penberg:cs.helsinki.fi' => 'Pekka Enberg',
 'pepe:attika.ath.cx' => 'Piotr Kaczuba',
 'pepinto:student.dei.uc.pt' => 'Pedro Emanuel M. D. Pinto',
 'per.winkvist:telia.com' => 'Per Winkvist',
@@ -1698,6 +1778,7 @@
 'peter:bergner.org' => 'Peter Bergner',
 'peter:cadcamlab.org' => 'Peter Samuelson',
 'peter:chubb.wattle.id.au' => 'Peter Chubb',
+'peter:pantasys.com' => 'Peter Buckingham',
 'peterc:chubb.wattle.id.au' => 'Peter Chubb',
 'peterc:gelato.unsw.edu.au' => 'Peter Chubb',
 'peterm:redhat.com' => 'Peter Martuccelli',
@@ -1728,8 +1809,10 @@
 'phillips:arcor.de' => 'Daniel Phillips',
 'piggin:cyberone.com.au' => 'Nick Piggin',
 'piggy:timesys.com' => 'La Monte H.P. Yarroll',
+'pilo.c:wanadoo.fr' => 'Pilo Chambert',
 'pixi:burble.org' => 'Maurice S. Barnum',
 'pj:sgi.com' => 'Paul Jackson',
+'pjones:redhat.com' => 'Peter Jones',
 'pkot:linuxnews.pl' => 'Pawel Kot',
 'pkot:ziew.org' => 'Pawel Kot',
 'plars:austin.ibm.com' => 'Paul Larson',
@@ -1741,13 +1824,16 @@
 'pmclean:linuxfreak.ca' => 'Patrick McLean',
 'pmeda:akamai.com' => 'Prasanna Meda',
 'pmenage:ensim.com' => 'Paul Menage',
+'pnelson:andrew.cmu.edu' => 'Peter Nelson',
 'pontus.fuchs:tactel.se' => 'Pontus Fuchs',
 'porter:cox.net' => 'Matt Porter',
 'poup:poupinou.org' => 'Bruno Ducrot',
+'pozsy:uhulinux.hu' => 'Pozsar Balazs',
 'pp:ee.oulu.fi' => 'Pekka Pietikäinen',
 'pp:netppl.fi' => 'Pekka Pietikäinen',
 'ppc64:brule.rchland.ibm.com' => 'Peter Bergner',
 'pragnesh.sampat:timesys.com' => 'Pragnesh Sampat',
+'praka:pobox.com' => 'Andrew Vasquez',
 'praka:users.sourceforge.net' => 'Andrew Vasquez',
 'prasanna:in.ibm.com' => 'Prasanna S. Panchamukhi', # lbdb
 'pratik.solanki:timesys.com' => 'Pratik Solanki',
@@ -1760,6 +1846,7 @@
 'ptiedem:de.ibm.com' => 'Peter Tiedemann',
 'purna:jcom.home.ne.jp' => 'Yusuf Wilajati Purna',
 'pwaechtler:mac.com' => 'Peter Wächtler',
+'pzad:pobox.sk' => 'Peter Zubaj',
 'q:kampsax.dtu.dk' => 'Dennis Jørgensen',
 'qboosh:pld-linux.org' => 'Jakub Bogusz',
 'qboosh:pld.org.pl' => 'Jakub Bogusz',
@@ -1800,15 +1887,18 @@
 'rem:osdl.org' => 'Bob Miller',
 'rene.herman:keyaccess.nl' => 'Rene Herman', # lbdb
 'rene.herman:nl.rmk.(none)' => 'Rene Herman',
+'rene.rebe:gmx.net' => 'Rene Rebe',
 'rgcrettol:datacomm.ch' => 'Roger Crettol',
 'rgooch:atnf.csiro.au' => 'Richard Gooch',
 'rgooch:ras.ucalgary.ca' => 'Richard Gooch',
+'rgooch:safe-mbox.com' => 'Richard Gooch',
 'rgs:linalco.com' => 'Roberto Gordo Saez',
 'rhim:cc.gatech.edu' => 'Himanshu Raj',
 'rhirst:linuxcare.com' => 'Richard Hirst',
 'rhw:infradead.org' => 'Riley Williams',
 'richard.brunner:amd.com' => 'Richard Brunner',
 'richard.curnow:superh.com' => 'Richard Curnow',
+'richm:oldelvet.org.uk' => 'Richard Mortimer',
 'ricklind:us.ibm.com' => 'Rick Lindsley',
 'riel:conectiva.com.br' => 'Rik van Riel',
 'riel:imladris.surriel.com' => 'Rik van Riel',
@@ -1817,6 +1907,7 @@
 'rjweryk:uwo.ca' => 'Rob Weryk',
 'rl:hellgate.ch' => 'Roger Luethi',
 'rlievin:free.fr' => 'Romain Liévin',
+'rlrevell:joe-job.com' => 'Lee Revell',
 'rmiller:duskglow.com' => 'Russell Miller',
 'rmk+lkml:arm.linux.org.uk' => 'Russell King',
 'rmk+pcmcia:arm.linux.org.uk' => 'Russell King',
@@ -1830,10 +1921,12 @@
 'rob:osinvestor.com' => 'Rob Radez',
 'robert.olsson:data.slu.se' => 'Robert Olsson',
 'robert.picco:hp.com' => 'Robert Picco',
+'robertd:vantagecontrols.com' => 'Robert Daniels',
 'robin.farine:ch.rmk.(none)' => 'Robin Farine',
 'robin.farine:org.rmk.(none)' => 'Robin Farine',
 'robin.jag:free.fr' => 'Gérard Robin',
 'robn:verdi.et.tudelft.nl' => 'Rob van Nieuwkerk',
+'roe:sgi.com' => 'Dean Roe',
 'roehrich:sgi.com' => 'Dean Roehrich',
 'rohde:duff.dk' => 'Rasmus Rohde',
 'rohit.seth:intel.com' => 'Seth Rohit',
@@ -1876,6 +1969,8 @@
 'rtjohnso:eecs.berkeley.edu' => 'Robert T. Johnson',
 'ruby.joker:op.pl' => 'Ruby Joker',
 'rui.sousa:laposte.net' => 'Rui Sousa',
+'runet:innovsys.com' => 'Rune Torgersen',
+'russb:emc.com' => 'Brett Russ',
 'russell_d_cagle:mindspring.com' => 'Russell Cagle', # google
 'rusty:au1.ibm.com' => 'Rusty Russell',
 'rusty:linux.co.intel.com' => 'Rusty Lynch',
@@ -1887,9 +1982,11 @@
 'rwhron:earthlink.net' => 'Randy Hron',
 'rwhron:net.rmk.(none)' => 'Randy Hron',
 'ryan:michonline.com' => 'Ryan Anderson',
+'ryan:spitfire.gotdns.org' => 'Ryan Cumming',
 'rz:linux-m68k.org' => 'Richard Zidlicky',
 's.doyon:videotron.ca' => 'Stéphane Doyon',
 'sabala:students.uiuc.edu' => 'Michal Sabala', # google
+'saidi:umich.edu' => 'Ali Saidi',
 'sailer:scs.ch' => 'Thomas Sailer',
 'sam:mars.ravnborg.org' => 'Sam Ravnborg',
 'sam:ravnborg.org' => 'Sam Ravnborg',
@@ -1903,6 +2000,8 @@
 'santil:us.ibm.com' => 'Santiago Leon',
 'sarolaht:cs.helsinki.fi' => 'Pasi Sarolahti',
 'sascha:de.rmk.(none)' => 'Sascha Hauer',
+'sashak:smlink.com' => 'Sasha Khapyorsky',
+'saw:saw.sw.com.sg' => 'Andrey V. Savochkin',
 'sawa:yamamoto.gr.jp' => 'sawa',
 'scameron:quandary.cca.cpqcorp.net' => 'Steve Cameron',
 'scd:broked.org' => 'Steven Dake',
@@ -1910,6 +2009,7 @@
 'schierlm:gmx.de' => 'Michael Schierl',
 'schlicht:uni-mannheim.de' => 'Thomas Schlichter',
 'schlicht:uni-mannheimn.de' => 'Thomas Schlichter',	# it's typo IMHO
+'schmitz:opal.biophys.uni-duesseldorf.de' => 'Michael Schmitz',
 'schoenfr:gaaertner.de' => 'Erik Schoenfelder',
 'scholnik:radar.nrl.navy.mil' => 'Dan Scholnik',
 'schwab:suse.de' => 'Andreas Schwab',
@@ -1932,6 +2032,7 @@
 'seanlkml:rogers.com' => 'Sean Estabrooks',
 'sebastian.droege:gmx.de' => 'Sebastian Dröge',
 'sebek64:post.cz' => 'Marcel Sebek',
+'seife:suse.de' => 'Stefan Seyfried',
 'sergio.gelato:astro.su.se' => 'Sergio Gelato',
 'set:pobox.com' => 'Paul Thompson',
 'seto.hidetoshi:jp.fujitsu.com' => 'Hidetoshi Seto',
@@ -1949,6 +2050,8 @@
 'shahamit:gmx.net' => 'Amit Shah',
 'shai:ftcon.com' => 'Shai Fultheim',
 'shai:scalex86.org' => 'Shai Fultheim',
+'shaoh.li:gmail.com' => 'Li Shaohua',
+'shaohua.li:intel.com' => 'Li Shaohua',
 'shbader:de.ibm.com' => 'Stefan Bader',
 'sheilds:msrl.com' => 'Michael Shields', # typo
 'shemminger:osdl.org' => 'Stephen Hemminger',
@@ -1987,17 +2090,20 @@
 'solar:openwall.com' => 'Solar Designer',
 'solca:guug.org' => 'Otto Solares',
 'solt:dns.toxicfilms.tv' => 'Maciej Soltysiak',
+'sonny:burdell.org' => 'Sonny Rao',
 'soruk:eridani.co.uk' => 'Michael McConnell',
 'sparclinux:abeckmann.de' => 'Andreas Beckmann',
 'sparker:sun.com' => 'Steven Parker', # by Duncan Laurie
 'sparse:chrisli.org' => 'Christopher Li',
 'spitalnik:penguin.cz' => 'Jan Spitalnik',
+'spock:gentoo.org' => 'Michal Januszewski',
 'sprite:sprite.fr.eu.org' => 'Jeremie Koenig',
 'spse:secret.org.uk' => 'Simon Evans', # by Kristian Peters
 'spstarr:sh0n.net' => 'Shawn Starr',
 'spyro:com.rmk.(none)' => 'Ian Molton',
 'spyro:f2s.com' => 'Ian Molton',
 'src:flint.arm.linux.org.uk' => 'Russell King',
+'sreenib:lsil.com' => 'Sreenivas Bagalkote',
 'sri:us.ibm.com' => 'Sridhar Samudrala',
 'sridhar:dyn9-47-18-140.beaverton.ibm.com' => 'Sridhar Samudrala',
 'sridhar:dyn9-47-18-86.beaverton.ibm.com' => 'Sridhar Samudrala',
@@ -2068,6 +2174,8 @@
 'tai:imasy.or.jp' => 'Taisuke Yamada',
 'taka:valinux.co.jp' => 'Hirokazu Takahashi',
 'takamiya:po.ntts.co.jp' => 'Noriaki Takamiya',
+'takata.hirokazu:renesas.com' => 'Hirokazu Takata',
+'takata:linux-m32r.org' => 'Hirokazu Takata',
 'tao:acc.umu.se' => 'David Weinehall', # by himself
 'tao:kernel.org' => 'David Weinehall', # by himself
 'tapio:iptime.fi' => 'Tapio Laxström',
@@ -2078,14 +2186,17 @@
 'tejohnson:yahoo.com' => 'Todd E. Johnson',
 'tes:sgi.com' => 'Timothy Shimmin',
 'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
+'tglx:linutronix.de' => 'Thomas Gleixner',
 'tgraf:suug.ch' => 'Thomas Graf',
 'th122948:scl1.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
 'th122948:scl3.sfbay.sun.com' => 'Tim Hockin', # by Duncan Laurie
+'tharbaugh:lnxi.com' => 'Thayne Harbaugh',
 'thchou:ali.com.tw' => 'T. H. Chou', # Alan Cox
 'thiel:ksan.de' => 'Florian Thiel', # lbdb
 'thockin:freakshow.cobalt.com' => 'Tim Hockin',
 'thockin:sun.com' => 'Tim Hockin',
 'thoffman:arnor.net' => 'Torrey Hoffman',
+'thomas.koeller:baslerweb.com' => 'Thomas Koeller',
 'thomas.schlichter:web.de' => 'Thomas Schlichter',
 'thomas.wahrenbruch:kobil.com' => 'Thomas Wahrenbruch',
 'thomas:bender.thinknerd.de' => 'Thomas Walpuski',
@@ -2098,6 +2209,7 @@
 'thor:math.tu-berlin.de' => 'Thomas Richter',
 'thornber:redhat.com' => 'Joe Thornber',
 'thornber:sistina.com' => 'Joe Thornber',
+'thoss:de.ibm.com' => 'Steffen Thoss',
 'thunder7:xs4all.nl' => 'Jurriaan Kalkman',
 'thunder:keepsake.ch' => 'Tonnerre Anklin',
 'thunder:ngforever.de' => 'Thunder From The Hill',
@@ -2109,6 +2221,8 @@
 'timw:splhi.com' => 'Tim Wright',
 'tinglett:vnet.ibm.com' => 'Todd Inglett',
 'tiwai:suse.de' => 'Takashi Iwai',
+'tj:home-tj.org' => 'Tejun Heo',
+'tkooda-patch-kernel:devsec.org' => 'Thor Kooda',
 'tlnguyen:snoqualmie.dp.intel.com' => 'Tom L. Nguyen',
 'tmattox:engr.uky.edu' => 'Tim Mattox',
 'tmcreynolds:nvidia.com' => 'Tom McReynolds',
@@ -2124,6 +2238,7 @@
 'tomlins:cam.org' => 'Ed Tomlinson',
 'tommy.christensen:tpack.net' => 'Tommy Christensen',
 'tommy:home.tig-grr.com' => 'Tom Marshall',
+'tomy.luck:intel.com' => 'Tony Luck',
 'tony.cureington:hp.com' => 'Tony Cureington',
 'tony.luck:intel.com' => 'Tony Luck',
 'tony:atomide.com' => 'Tony Lindgren',
@@ -2149,6 +2264,7 @@
 'tritol:trilogic.cz' => 'Lubomír Bláha',
 'trivial:rustcorp.com.au' => 'Rusty Russell',
 'trond.myklebust:fys.uio.no' => 'Trond Myklebust',
+'trondmy:trondhjem.org' => 'Trond Myklebust',
 'tsk:ibakou.com' => 'Kawazoe Tomonori',
 'tspat:de.ibm.com' => 'Thomas Spatzier',
 'ttodorov:web.de' => 'Todor Todorov',
@@ -2182,8 +2298,10 @@
 'vatsa:in.ibm.com' => 'Srivatsa Vaddagiri',
 'vberon:mecano.gme.usherb.ca' => 'Vincent Béron',
 'vda:port.imtp.ilyichevsk.odessa.ua' => 'Denis Vlasenko',
+'vegarwa:online.no' => 'Vegard Wærp',
 'venkatesh.pallipadi:intel.com' => 'Venkatesh Pallipadi',
 'vernux:us.ibm.com' => 'Vernon Mauery',
+'vesely:gjh.sk' => 'Jozef Vesely',
 'vesselin:alphawave.com.au' => 'Vesselin Kostadiov',
 'vfort:provident-solutions.com' => 'Vernon A. Fort',
 'vherva:niksula.hut.fi' => 'Ville Herva',
@@ -2235,6 +2353,7 @@
 'wharms:bfs.de' => 'Walter Harms',
 'whitney:math.berkeley.edu' => 'Wayne Whitney',
 'whydoubt:yahoo.com' => 'Jeff Smith',
+'wiget:pld-linux.org' => 'Artur Frysiak',
 'will:sowerbutts.com' => 'William R. Sowerbutts',
 'will_dyson:pobox.com' => 'Will Dyson',
 'willschm:us.ibm.com' => 'Will Schmidt',
@@ -2272,12 +2391,14 @@
 'yoav.zach:intel.com' => 'Yoav Zach',
 'yoav_zach:yahoo.com' => 'Yoav Zach',
 'yokota:netlab.is.tsukuba.ac.jp' => 'Yokota Hiroshi',
+'yoshfuji:linux-ipv6.o0rg' => 'Hideaki Yoshifuji',
 'yoshfuji:linux-ipv6.org' => 'Hideaki Yoshifuji', # lbdb
 'yoshfuji:nuts.ninka.net' => 'Hideaki Yoshifuji',
 'ysato:users.sourceforge.jp' => 'Yoshinori Sato', # lbdb
 'ysauyuki.kozakai:toshiba.co.jp' => 'Yasuyuki Kozakai', # typo
 'yuasa:hh.iij4u.or.jp' => 'Yoichi Yuasa',
 'yuri:acronis.com' => 'Yuri Per', # lbdb
+'yuvalt:gmail.com' => 'Yuval Turgeman',
 'zach:vmware.com' => 'Zachary Amsden',
 'zaitcev:redhat.com' => 'Pete Zaitcev',
 'zap:homelink.ru' => 'Andrew Zabolotny',
@@ -2831,7 +2952,7 @@
       } else {
 	  print STDERR " SKIPPED FROM  $author\n" if $debug;
       }
-    } elsif (/^\s+Signed-off-by:\s*"?([^"]*)"?\s+\<(.*)\>\s*$/i) {
+    } elsif (/^\s+Signed[- _]off[- _]by:\s*"?([^"]*)"?\s+\<(.*)\>\s*$/i) {
       my @nameauthor = treat_address($1, $2);
       if ($namepref < 0) {
 	  ($name, $address, $author) = @nameauthor;

