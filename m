Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271044AbUJUWqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271044AbUJUWqY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271054AbUJUWn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:43:56 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:31716 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S271055AbUJUWkk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:40:40 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.325
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu,_21_Oct_2004_22_40_35_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20041021224035.F24F1D9A49@merlin.emma.line.org>
Date: Fri, 22 Oct 2004 00:40:35 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.325 has been released.

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
revision 0.325
date: 2004/10/21 22:39:50;  author: emma;  state: Exp;  lines: +53 -3
vita: 50 new addresses
ma: Correct Petri T. Koistinen's name.
----------------------------
revision 0.324
date: 2004/10/19 01:59:56;  author: emma;  state: Exp;  lines: +125 -4
Pull in new BK revision as of 2004-10-19, to do a release.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.324
retrieving revision 0.325
diff -u -U2 -r0.324 -r0.325
--- lk-changelog.pl	19 Oct 2004 01:59:56 -0000	0.324
+++ lk-changelog.pl	21 Oct 2004 22:39:50 -0000	0.325
@@ -9,5 +9,5 @@
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.324 2004/10/19 01:59:56 emma Exp $
+# $Id: lk-changelog.pl,v 0.325 2004/10/21 22:39:50 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
@@ -217,8 +217,10 @@
 'ak:colin2.muc.de' => 'Andi Kleen',
 'ak:muc.de' => 'Andi Kleen',
+'ak:sensi.org' => 'Alex Kanavin',
 'ak:suse.de' => 'Andi Kleen',
 'akepner:sgi.com' => 'Arthur Kepner',
 'akiyama.nobuyuk:jp.fujitsu.com' => 'Akiyama Nobuyuki',
 'akm:osdl.org' => 'Andrew Morton', # typo?
+'akonovalov:ru.mvista.com' => 'Andrei Konovalov',
 'akpm:digeo.com' => 'Andrew Morton',
 'akpm:org.rmk.(none)' => 'Andrew Morton',
@@ -235,4 +237,5 @@
 'alanh:tungstengraphics.com' => 'Alan Hourihane',
 'albert.cahalan:ccur.com' => 'Albert Cahalan',
+'albert:users.sf.net' => 'Albert Cahalan',
 'albert:users.sourceforge.net' => 'Albert Cahalan',
 'albertogli:telpin.com.ar' => 'Alberto Bertogli',
@@ -279,4 +282,5 @@
 'andrea:novell.com' => 'Andrea Arcangeli',
 'andrea:suse.de' => 'Andrea Arcangeli',
+'andreas:fjortis.info' => 'Andreas Henriksson',
 'andreas:xss.co.at' => 'Andreas Haumer',
 'andrej.filipcic:ijs.si' => 'Andrej Filipcic',
@@ -288,4 +292,5 @@
 'andries.brouwer:cwi.nl' => 'Andries E. Brouwer',
 'andros:citi.umich.edu' => 'Andy Adamson',
+'andros:thnk.citi.umich.edu' => 'William A. Adamson',
 'andros:umich.edu' => 'Andy Adamson',
 'andyw:uk.ibm.com' => 'Andy Whitcroft',
@@ -300,4 +305,5 @@
 'anton:superego.(none)' => 'Anton Blanchard',
 'anton:superego.ozlabs.ibm.com' => 'Anton Blanchard',
+'aoki:sdl.hitachi.co.jp' => 'Hideo Aoki',
 'aoliva:redhat.com' => 'Alexandre Oliva',
 'ap:cipherica.com' => 'Alex Pankratov',
@@ -337,4 +343,5 @@
 'ast:domdv.de' => 'Andreas Steinmetz',
 'async:cc.gatech.edu' => 'Rob Melby',
+'atomenergie:t-online.de' => 'Stephan Fuhrmann',
 'atul.mukker:lsil.com' => 'Atul Mukker',
 'atulm:lsil.com' => 'Atul Mukker',
@@ -347,4 +354,5 @@
 'axboe:suse.de' => 'Jens Axboe',
 'azarah:gentoo.org' => 'Martin Schlemmer',
+'azarah:nosferatu.za.org' => 'Martin Schlemmer',
 'aziz:hp.com' => 'Khalid Aziz', # Alan
 'b.zolnierkiewicz:elka.pw.edu.pl' => 'Bartlomiej Zolnierkiewicz',
@@ -373,5 +381,7 @@
 'beattie:beattie-home.net' => 'Brian Beattie', # from david.nelson
 'bellucda:tiscali.it' => 'Daniele Bellucci',
+'ben-linux:fluff.org' => 'Ben Dooks',
 'ben-linux:org.rmk.(none)' => 'Ben Dooks',
+'ben:fluff.org' => 'Ben Dooks',
 'ben:simtec.co.uk' => 'Ben Dooks',
 'bengen:hilluzination.de' => 'Hilko Bengen',
@@ -466,4 +476,6 @@
 'castor:3pardata.com' => 'Castor Fu',
 'cat:zip.com.au' => 'CaT',
+'catab:deuroconsult.ro' => 'Catalin Boie',
+'catab:umbrella.ro' => 'Catalin Boie',
 'catalin.marinas:com.rmk.(none)' => 'Catalin Marinas',
 'cattelan:lupo.thebarn.com' => 'Russell Cattelan',
@@ -490,4 +502,5 @@
 'charles.white:hp.com' => 'Charles White',
 'chaus:cs.uni-potsdam.de' => 'Carsten Haustein',
+'chaus:rz.uni-potsdam.de' => 'Carsten Haustein',
 'chessman:tux.org' => 'Samuel S. Chessman',
 'chip:pobox.com' => 'Chip Salzenberg', # lbdb
@@ -501,4 +514,5 @@
 'christian:borntraeger.net' => 'Christian Borntraeger',
 'christoph:graphe.net' => 'Christoph Lameter',
+'christoph:lameter.com' => 'Christoph Lameter',
 'christophe:saout.de' => 'Christophe Saout',
 'christopher.leech:intel.com' => 'Christopher Leech',
@@ -512,4 +526,5 @@
 'clameter:sgi.com' => 'Christoph Lameter',
 'clemens-dated-1061728015.bf63:endorphin.org' => 'Fruhwirth Clemens',
+'clemens:endorphin.org' => 'Fruhwirth Clemens',
 'clemens:ladisch.de' => 'Clemens Ladisch',
 'clemy:clemy.org' => 'Bernhard C. Schrenk',
@@ -544,4 +559,5 @@
 'cr:sap.com' => 'Christoph Rohland',
 'craig.nadler:arc.com' => 'Craig Nadler',
+'craig:gumstix.com' => 'Craig Hughes',
 'craig:homerjay.homelinux.org' => 'Craig Wilkie',
 'cramerj:intel.com' => 'Jeb J. Cramer',
@@ -588,4 +604,5 @@
 'dave:thedillows.org' => 'David Dillow',
 'davej:codmonkey.org.uk' => 'Dave Jones', # not matched by regexp above
+'davej:dhcp83-103.boston.redhat.com' => 'Dave Jones',
 'davej:hardwired.(none)' => 'Dave Jones',
 'davej:redhat.com' => 'Dave Jones', # lbdb
@@ -632,4 +649,5 @@
 'delaunay:lix.polytechnique.fr' => 'Eric Delaunay',
 'deller:gmx.de' => 'Helge Deller',
+'dely.l.sy:intel.com' => 'Dely Sy',
 'dent:cosy.sbg.ac.at' => "Thomas 'Dent' Mirlacher",
 'der.eremit:email.de' => 'Pascal Schmidt',
@@ -649,4 +667,6 @@
 'dilinger:mp3revolution.net' => 'Andres Salomon',
 'dilinger:voxel.net' => 'Andres Salomon',
+'dimitry.andric:tomtom.com' => 'Dimitry Andric',
+'dino:in.ibm.com' => 'Dinakar Guniguntala',
 'dipankar:in.ibm.com' => 'Dipankar Sarma',
 'dirk.behme:com.rmk.(none)' => 'Dirk Behme',
@@ -718,5 +738,7 @@
 'ecashin:uga.edu' => 'Ed L. Cashin',
 'ecd:skynet.be' => 'Eddie C. Dost',
+'ed:il.fontys.nl' => 'Ed Schouten',
 'eddie.williams:steeleye.com' => 'Eddie Williams',
+'edrossma:us.ibm.com' => 'Eric Rossman',
 'edv:macrolink.com' => 'Ed Vance',
 'edward_peng:dlink.com.tw' => 'Edward Peng',
@@ -728,4 +750,5 @@
 'egmont:uhulinux.hu' => 'Egmont Koblinger',
 'ehabkost:conectiva.com.br' => 'Eduardo Pereira Habkost',
+'eich:suse.de' => 'Egbert Eich',
 'eike-hotplug:sf-tec.de' => 'Rolf Eike Beer',
 'eike-kernel:sf-tec.de' => 'Rolf Eike Beer', # sent by himself
@@ -792,4 +815,5 @@
 'fenlason:redhat.com' => 'Jay Fenlason',
 'fero:sztalker.hu' => 'Bakonyi Ferenc',
+'fhirtz:redhat.com' => 'Frank Hirtz',
 'filip.sneppe:cronos.be' => 'Filip Sneppe',
 'fischer:linux-buechse.de' => 'Jürgen E. Fischer',
@@ -860,4 +884,5 @@
 'gjaeger:sysgo.com' => 'Gerhard Jaeger',
 'gkernel.adm:hostme.bitkeeper.com' => 'Jeff Garzik', # himself
+'gkurz:meiosys.com' => 'Gregory Kurz',
 'gl:dsa-ac.de' => 'Guennadi Liakhovetski',
 'glee:gnupilgrims.org' => 'Geoffrey Lee', # lbdb
@@ -911,6 +936,8 @@
 'harald:gnumonks.org' => 'Harald Welte',
 'hare:suse.de' => 'Hannes Reinecke',
+'haroldo.gamal:infolink.com.br' => 'Haroldo Gamal',
 'haveblue:us.ibm.com' => 'Dave Hansen',
 'hawkes:oss.sgi.com' => 'John Hawkes',
+'hawkes:sgi.com' => 'John Hawkes',
 'hbabu:us.ibm.com' => 'Haren Myneni',
 'hch:caldera.de' => 'Christoph Hellwig',
@@ -946,4 +973,5 @@
 'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
 'hiroshi_doyu:montavista.co.jp' => 'Hiroshi Doyu',
+'hj.oertel:surfeu.de' => 'Heinz-Juergen Oertel',
 'hjl:lucon.org' => 'H. J. Lu',
 'hjm:redhat.com' => 'Heinz Mauelshagen', # lbdb
@@ -1059,4 +1087,6 @@
 'jef:linuxbe.org' => 'Jean-Francois Dive',
 'jeff.wiedemeier:hp.com' => 'Jeff Wiedemeier',
+'jeffm:csh.rit.edu' => 'Jeff Mahoney',
+'jeffm:novell.com' => 'Jeff Mahoney',
 'jeffm:suse.com' => 'Jeff Mahoney',
 'jeffm:suse.de' => 'Jeff Mahoney',
@@ -1189,4 +1219,5 @@
 'jsm:fc.hp.com' => 'John S. Marvin',
 'jsm:udlkern.fc.hp.com' => 'John S. Marvin',
+'jstultz:us.ibm.com' => 'John Stultz',
 'jsun:mvista.com' => 'Jun Sun',
 'jt:bougret.hpl.hp.com' => 'Jean Tourrilhes',
@@ -1236,4 +1267,5 @@
 'kasperd:daimi.au.dk' => 'Kasper Dupont',
 'katzj:redhat.com' => 'Jeremy Katz',
+'kay.sievers:vrfy.org' => 'Kay Sievers',
 'kaz:earth.email.ne.jp' => 'Kazuto Miyoshi',
 'kazunori:miyazawa.org' => 'Kazunori Miyazawa',
@@ -1353,4 +1385,5 @@
 'lethal:linux-sh.org' => 'Paul Mundt',
 'lethal:unusual.internal.linux-sh.org' => 'Paul Mundt',
+'lev_makhlis:bmc.com' => 'Lev Makhlis',
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
@@ -1387,4 +1420,5 @@
 'lkml:mathfillsmewithgreatjoy.com' => 'Michael Plump',
 'lkml:shemesh.biz' => 'Shachar Shemesh',
+'lkml:steffenspage.de' => 'Steffen Zieger',
 'lm:bitmover.com' => 'Larry McVoy',
 'lm:work.bitmover.com' => 'Larry McVoy',
@@ -1423,4 +1457,5 @@
 'macro:linux-mips.org' => 'Maciej W. Rozycki',
 'maeda.naoaki:jp.fujitsu.com' => 'Maeda Naoaki',
+'mahalcro:us.ibm.com' => 'Michael A. Halcrow',
 'mail:de.rmk.(none)' => 'Peter Teichmann',
 'mail:gude.info' => 'Gude Analog- und Digitalsysteme GmbH',
@@ -1514,4 +1549,5 @@
 'mebrown:michaels-house.net' => 'Michael E. Brown',
 'mec:shout.net' => 'Michael Elizabeth Chastain',
+'medaglia:undl.org.br' => 'Carlos Eduardo Medaglia Dyonisio',
 'meissner:suse.de' => 'Marcus Meissner',
 'menard.fabrice:wanadoo.fr' => 'Fabrice Menard',
@@ -1580,4 +1616,5 @@
 'mkp:mkp.net' => 'Martin K. Petersen', # lbdb
 'mlang:delysid.org' => 'Mario Lang', # google
+'mlev:despammed.com' => 'Lev Makhlis',
 'mlindner:syskonnect.de' => 'Mirko Lindner',
 'mlocke:mvista.com' => 'Montavista Software, Inc.',
@@ -1680,4 +1717,5 @@
 'obi:saftware.de' => 'Andreas Oberritter',
 'od:suse.de' => 'Olaf Dabrunz',
+'oe:port.de' => 'Heinz-Juergen Oertel',
 'ogasawara:osdl.org' => 'Leann Ogasawara',
 'okir:suse.de' => 'Olaf Kirch', # lbdb
@@ -1732,4 +1770,5 @@
 'paul.clements:steeleye.com' => 'Paul Clements',
 'paul.focke:pandora.be' => 'Paul Focke',
+'paul.mundt:nokia.com' => 'Paul Mundt',
 'paul.mundt:timesys.com' => 'Paul Mundt', # google
 'paul:allied-universal.com' => 'Paul King',
@@ -1794,8 +1833,9 @@
 'petkan:tequila.dce.bg' => 'Petko Manolov',
 'petkan:users.sourceforge.net' => 'Petko Manolov',
+'petkov:uni-muenster.de' => 'Borislav Petkov',
 'petr:scssoft.com' => 'Petr Sebor',
 'petr:vandrovec.name' => 'Petr Vandrovec',
-'petri.koistinen:fi.rmk.(none)' => 'Petri Koistinen',
-'petri.koistinen:iki.fi' => 'Petri Koistinen',
+'petri.koistinen:fi.rmk.(none)' => 'Petri T. Koistinen', # by himself
+'petri.koistinen:iki.fi' => 'Petri T. Koistinen', # by himself
 'petrides:redhat.com' => 'Ernie Petrides',
 'pfg:sgi.com' => 'Pat Gefre',
@@ -1847,4 +1887,5 @@
 'purna:jcom.home.ne.jp' => 'Yusuf Wilajati Purna',
 'pwaechtler:mac.com' => 'Peter Wächtler',
+'pwil3058:bigpond.net.au' => 'Peter Williams',
 'pzad:pobox.sk' => 'Peter Zubaj',
 'q:kampsax.dtu.dk' => 'Dennis Jørgensen',
@@ -1915,4 +1956,5 @@
 'rmk:arm.linux.org.uk' => 'Russell King',
 'rmk:flint.arm.linux.org.uk' => 'Russell King',
+'rml:novell.com' => 'Robert Love',
 'rml:tech9.net' => 'Robert Love',
 'rml:ximian.com' => 'Robert Love',
@@ -1968,4 +2010,5 @@
 'rth:vsop.sfbay.redhat.com' => 'Richard Henderson',
 'rtjohnso:eecs.berkeley.edu' => 'Robert T. Johnson',
+'ruben:ugr.es' => 'Ruben Garcia',
 'ruby.joker:op.pl' => 'Ruby Joker',
 'rui.sousa:laposte.net' => 'Rui Sousa',
@@ -2090,5 +2133,7 @@
 'solar:openwall.com' => 'Solar Designer',
 'solca:guug.org' => 'Otto Solares',
+'solt2:dns.toxicfilms.tv' => 'Maciej Soltysiak',
 'solt:dns.toxicfilms.tv' => 'Maciej Soltysiak',
+'songqf9:yahoo.ca' => 'Alex Song',
 'sonny:burdell.org' => 'Sonny Rao',
 'soruk:eridani.co.uk' => 'Michael McConnell',
@@ -2120,4 +2165,5 @@
 'stelian.pop:fr.alcove.com' => 'Stelian Pop',
 'stelian:popies.net' => 'Stelian Pop',
+'stephan.walter:epfl.ch' => 'Stephan Walter',
 'stephane.galles:free.fr' => 'Stephane Galles', # guessed
 'stephanm:muc.de' => 'Stephan Maciej',
@@ -2285,4 +2331,5 @@
 'urban:teststation.com' => 'Urban Widmark',
 'uros:kss-loka.si' => 'Uros Bizjak',
+'util:deuroconsult.ro' => 'Catalin Boie',
 'utz.bacher:de.ibm.com' => 'Utz Bacher',
 'uwe.bugla:gmx.de' => 'Uwe Bugla',
@@ -2314,4 +2361,5 @@
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'viro:www.linux.org.uk' => 'Alexander Viro',
+'vladimir.grouzdev:jaluna.com' => 'Vladimir Grouzdev',
 'vmlinuz386:yahoo.com.ar' => 'Gerardo Exequiel Pozzi', # lbdb
 'vnourval:tcs.hut.fi' => 'Ville Nuorvala',		# Can't spell his own login?
@@ -2371,4 +2419,5 @@
 'wolfgang:top.mynetix.de' => 'Wolfgang Mauerer',
 'woody:org.rmk.(none)' => 'Woody Suwalski',
+'wouter-kernel:fort-knox.rave.org' => 'Wouter Van Hemel',
 'wriede:riede.org' => 'Willem Riede',
 'wrlk:riede.org' => 'Willem Riede',
@@ -2402,4 +2451,5 @@
 'zach:vmware.com' => 'Zachary Amsden',
 'zaitcev:redhat.com' => 'Pete Zaitcev',
+'zaitcev:yahoo.com' => 'Pete Zaitcev',
 'zap:homelink.ru' => 'Andrew Zabolotny',
 'zap:ru.rmk.(none)' => 'Andrew Zabolotny',

