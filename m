Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271049AbUJUWvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271049AbUJUWvP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271048AbUJUWt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:49:56 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:29668 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S271051AbUJUWiw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:38:52 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu,_21_Oct_2004_22_38_45_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20041021223845.0BA65D9A4B@merlin.emma.line.org>
Date: Fri, 22 Oct 2004 00:38:45 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.236, 2004-10-22 00:37:25+02:00, matthias.andree@gmx.de
  Correct Petri T. Koistinen's name as per his own request.

ChangeSet@1.235, 2004-10-21 14:27:47+02:00, samel@mail.cz
  shortlog: 50 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 52 insertions(+), 2 deletions(-)

##### GNUPATCH #####
--- 1.206/shortlog	2004-10-19 03:59:57 +02:00
+++ 1.208/shortlog	2004-10-22 00:37:25 +02:00
@@ -216,10 +216,12 @@
 'ak:colin.muc.de' => 'Andi Kleen',
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
 'akpm:osdl.org' => 'Andrew Morton', # guessed
@@ -234,6 +236,7 @@
 'alanh:fairlite.demon.co.uk' => 'Alan Hourihane',
 'alanh:tungstengraphics.com' => 'Alan Hourihane',
 'albert.cahalan:ccur.com' => 'Albert Cahalan',
+'albert:users.sf.net' => 'Albert Cahalan',
 'albert:users.sourceforge.net' => 'Albert Cahalan',
 'albertogli:telpin.com.ar' => 'Alberto Bertogli',
 'alborchers:steinerpoint.com' => 'Al Borchers',
@@ -278,6 +281,7 @@
 'andre:linux-ide.org' => 'Andre Hedrick',
 'andrea:novell.com' => 'Andrea Arcangeli',
 'andrea:suse.de' => 'Andrea Arcangeli',
+'andreas:fjortis.info' => 'Andreas Henriksson',
 'andreas:xss.co.at' => 'Andreas Haumer',
 'andrej.filipcic:ijs.si' => 'Andrej Filipcic',
 'andrew.grover:intel.com' => 'Andy Grover', # "Andy" to match former entries
@@ -287,6 +291,7 @@
 'andrew:lunn.ch' => 'Andrew Lunn',
 'andries.brouwer:cwi.nl' => 'Andries E. Brouwer',
 'andros:citi.umich.edu' => 'Andy Adamson',
+'andros:thnk.citi.umich.edu' => 'William A. Adamson',
 'andros:umich.edu' => 'Andy Adamson',
 'andyw:uk.ibm.com' => 'Andy Whitcroft',
 'aneesh.kumar:digital.com' => 'Aneesh Kumar KV',
@@ -299,6 +304,7 @@
 'anton:samba.org' => 'Anton Blanchard',
 'anton:superego.(none)' => 'Anton Blanchard',
 'anton:superego.ozlabs.ibm.com' => 'Anton Blanchard',
+'aoki:sdl.hitachi.co.jp' => 'Hideo Aoki',
 'aoliva:redhat.com' => 'Alexandre Oliva',
 'ap:cipherica.com' => 'Alex Pankratov',
 'apm:brigitte.dna.fi' => 'Antti P. Miettinen',
@@ -336,6 +342,7 @@
 'aspicht:arkeia.com' => 'Arnaud Spicht',
 'ast:domdv.de' => 'Andreas Steinmetz',
 'async:cc.gatech.edu' => 'Rob Melby',
+'atomenergie:t-online.de' => 'Stephan Fuhrmann',
 'atul.mukker:lsil.com' => 'Atul Mukker',
 'atulm:lsil.com' => 'Atul Mukker',
 'augustus:linuxhardware.org' => 'Kris Kersey',
@@ -346,6 +353,7 @@
 'axboe:hera.kernel.org' => 'Jens Axboe',
 'axboe:suse.de' => 'Jens Axboe',
 'azarah:gentoo.org' => 'Martin Schlemmer',
+'azarah:nosferatu.za.org' => 'Martin Schlemmer',
 'aziz:hp.com' => 'Khalid Aziz', # Alan
 'b.zolnierkiewicz:elka.pw.edu.pl' => 'Bartlomiej Zolnierkiewicz',
 'baccala:vger.freesoft.org' => 'Brent Baccala',
@@ -372,7 +380,9 @@
 'bdshuym:pandora.be' => 'Bart De Schuymer', # it's typo IMHO
 'beattie:beattie-home.net' => 'Brian Beattie', # from david.nelson
 'bellucda:tiscali.it' => 'Daniele Bellucci',
+'ben-linux:fluff.org' => 'Ben Dooks',
 'ben-linux:org.rmk.(none)' => 'Ben Dooks',
+'ben:fluff.org' => 'Ben Dooks',
 'ben:simtec.co.uk' => 'Ben Dooks',
 'bengen:hilluzination.de' => 'Hilko Bengen',
 'benh:kenrel.crashing.org' => 'Benjamin Herrenschmidt', # typo
@@ -465,6 +475,8 @@
 'castet.matthieu:free.fr' => 'Matthieu Castet',
 'castor:3pardata.com' => 'Castor Fu',
 'cat:zip.com.au' => 'CaT',
+'catab:deuroconsult.ro' => 'Catalin Boie',
+'catab:umbrella.ro' => 'Catalin Boie',
 'catalin.marinas:com.rmk.(none)' => 'Catalin Marinas',
 'cattelan:lupo.thebarn.com' => 'Russell Cattelan',
 'cattelan:naboo.americas.sgi.com' => 'Russell Cattelan',
@@ -489,6 +501,7 @@
 'char:cmf.nrl.navy.mil' => 'Chas Williams', # typo ???
 'charles.white:hp.com' => 'Charles White',
 'chaus:cs.uni-potsdam.de' => 'Carsten Haustein',
+'chaus:rz.uni-potsdam.de' => 'Carsten Haustein',
 'chessman:tux.org' => 'Samuel S. Chessman',
 'chip:pobox.com' => 'Chip Salzenberg', # lbdb
 'chris:heathens.co.nz' => 'Chris Heath',
@@ -500,6 +513,7 @@
 'christer:weinigel.se' => 'Christer Weinigel', # from shortlog
 'christian:borntraeger.net' => 'Christian Borntraeger',
 'christoph:graphe.net' => 'Christoph Lameter',
+'christoph:lameter.com' => 'Christoph Lameter',
 'christophe:saout.de' => 'Christophe Saout',
 'christopher.leech:intel.com' => 'Christopher Leech',
 'christopher:intel.com' => 'Christopher Goldfarb',
@@ -511,6 +525,7 @@
 'ckulesa:as.arizona.edu' => 'Craig Kulesa',
 'clameter:sgi.com' => 'Christoph Lameter',
 'clemens-dated-1061728015.bf63:endorphin.org' => 'Fruhwirth Clemens',
+'clemens:endorphin.org' => 'Fruhwirth Clemens',
 'clemens:ladisch.de' => 'Clemens Ladisch',
 'clemy:clemy.org' => 'Bernhard C. Schrenk',
 'cloos:jhcloos.com' => 'James H. Cloos Jr.',
@@ -543,6 +558,7 @@
 'cr7:os.inf.tu-dresden.de' => 'Carsten Rietzschel',
 'cr:sap.com' => 'Christoph Rohland',
 'craig.nadler:arc.com' => 'Craig Nadler',
+'craig:gumstix.com' => 'Craig Hughes',
 'craig:homerjay.homelinux.org' => 'Craig Wilkie',
 'cramerj:intel.com' => 'Jeb J. Cramer',
 'cruault:724.com' => 'Charles-Edouard Ruault',
@@ -587,6 +603,7 @@
 'dave:qix.net' => 'Dave Maietta',
 'dave:thedillows.org' => 'David Dillow',
 'davej:codmonkey.org.uk' => 'Dave Jones', # not matched by regexp above
+'davej:dhcp83-103.boston.redhat.com' => 'Dave Jones',
 'davej:hardwired.(none)' => 'Dave Jones',
 'davej:redhat.com' => 'Dave Jones', # lbdb
 'davej:suse.de' => 'Dave Jones',
@@ -631,6 +648,7 @@
 'defouwj:purdue.edu' => 'Jeff DeFouw',
 'delaunay:lix.polytechnique.fr' => 'Eric Delaunay',
 'deller:gmx.de' => 'Helge Deller',
+'dely.l.sy:intel.com' => 'Dely Sy',
 'dent:cosy.sbg.ac.at' => "Thomas 'Dent' Mirlacher",
 'der.eremit:email.de' => 'Pascal Schmidt',
 'derek:ihtfp.com' => 'Derek Atkins',
@@ -648,6 +666,8 @@
 'diegocg:teleline.es' => 'Diego Calleja García',
 'dilinger:mp3revolution.net' => 'Andres Salomon',
 'dilinger:voxel.net' => 'Andres Salomon',
+'dimitry.andric:tomtom.com' => 'Dimitry Andric',
+'dino:in.ibm.com' => 'Dinakar Guniguntala',
 'dipankar:in.ibm.com' => 'Dipankar Sarma',
 'dirk.behme:com.rmk.(none)' => 'Dirk Behme',
 'dirk.behme:de.bosch.com' => 'Dirk Behme',
@@ -717,7 +737,9 @@
 'ecashin:coraid.com' => 'Ed L. Cashin',
 'ecashin:uga.edu' => 'Ed L. Cashin',
 'ecd:skynet.be' => 'Eddie C. Dost',
+'ed:il.fontys.nl' => 'Ed Schouten',
 'eddie.williams:steeleye.com' => 'Eddie Williams',
+'edrossma:us.ibm.com' => 'Eric Rossman',
 'edv:macrolink.com' => 'Ed Vance',
 'edward_peng:dlink.com.tw' => 'Edward Peng',
 'edwardsg:sgi.com' => 'Greg Edwards', # google
@@ -727,6 +749,7 @@
 'eger:theboonies.us' => 'David Eger',
 'egmont:uhulinux.hu' => 'Egmont Koblinger',
 'ehabkost:conectiva.com.br' => 'Eduardo Pereira Habkost',
+'eich:suse.de' => 'Egbert Eich',
 'eike-hotplug:sf-tec.de' => 'Rolf Eike Beer',
 'eike-kernel:sf-tec.de' => 'Rolf Eike Beer', # sent by himself
 'eike:bilbo.math.uni-mannheim.de' => 'Rolf Eike Beer',
@@ -791,6 +814,7 @@
 'fenghua.yu:intel.com' => 'Fenghua Yu', # google
 'fenlason:redhat.com' => 'Jay Fenlason',
 'fero:sztalker.hu' => 'Bakonyi Ferenc',
+'fhirtz:redhat.com' => 'Frank Hirtz',
 'filip.sneppe:cronos.be' => 'Filip Sneppe',
 'fischer:linux-buechse.de' => 'Jürgen E. Fischer',
 'fishor:gmx.net' => 'Alexey Fisher',
@@ -859,6 +883,7 @@
 'gj:pointblue.com.pl' => 'Grzegorz Jaskiewicz',
 'gjaeger:sysgo.com' => 'Gerhard Jaeger',
 'gkernel.adm:hostme.bitkeeper.com' => 'Jeff Garzik', # himself
+'gkurz:meiosys.com' => 'Gregory Kurz',
 'gl:dsa-ac.de' => 'Guennadi Liakhovetski',
 'glee:gnupilgrims.org' => 'Geoffrey Lee', # lbdb
 'glen:imodulo.com' => 'Glen Nakamura',
@@ -910,8 +935,10 @@
 'hanno:gmx.de' => 'Hanno Böck',
 'harald:gnumonks.org' => 'Harald Welte',
 'hare:suse.de' => 'Hannes Reinecke',
+'haroldo.gamal:infolink.com.br' => 'Haroldo Gamal',
 'haveblue:us.ibm.com' => 'Dave Hansen',
 'hawkes:oss.sgi.com' => 'John Hawkes',
+'hawkes:sgi.com' => 'John Hawkes',
 'hbabu:us.ibm.com' => 'Haren Myneni',
 'hch:caldera.de' => 'Christoph Hellwig',
 'hch:com.rmk' => 'Christoph Hellwig',
@@ -945,6 +972,7 @@
 'herry:sgi.com' => 'Herry Wiputra',
 'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
 'hiroshi_doyu:montavista.co.jp' => 'Hiroshi Doyu',
+'hj.oertel:surfeu.de' => 'Heinz-Juergen Oertel',
 'hjl:lucon.org' => 'H. J. Lu',
 'hjm:redhat.com' => 'Heinz Mauelshagen', # lbdb
 'hoho:binbash.net' => 'Colin Slater',
@@ -1058,6 +1086,8 @@
 'jeb.j.cramer:intel.com' => 'Jeb J. Cramer',
 'jef:linuxbe.org' => 'Jean-Francois Dive',
 'jeff.wiedemeier:hp.com' => 'Jeff Wiedemeier',
+'jeffm:csh.rit.edu' => 'Jeff Mahoney',
+'jeffm:novell.com' => 'Jeff Mahoney',
 'jeffm:suse.com' => 'Jeff Mahoney',
 'jeffm:suse.de' => 'Jeff Mahoney',
 'jeffml:pobox.com' => 'Jeff Lightfoot',
@@ -1188,6 +1218,7 @@
 'jsimmons:transvirtual.com' => 'James Simmons',
 'jsm:fc.hp.com' => 'John S. Marvin',
 'jsm:udlkern.fc.hp.com' => 'John S. Marvin',
+'jstultz:us.ibm.com' => 'John Stultz',
 'jsun:mvista.com' => 'Jun Sun',
 'jt:bougret.hpl.hp.com' => 'Jean Tourrilhes',
 'jt:bougret.jpl.hp.com' => 'Jean Tourrilhes',	# jpl? Whaa? hpl!
@@ -1235,6 +1266,7 @@
 'kas:informatics.muni.cz' => 'Jan Kasprzak', # lbdb
 'kasperd:daimi.au.dk' => 'Kasper Dupont',
 'katzj:redhat.com' => 'Jeremy Katz',
+'kay.sievers:vrfy.org' => 'Kay Sievers',
 'kaz:earth.email.ne.jp' => 'Kazuto Miyoshi',
 'kazunori:miyazawa.org' => 'Kazunori Miyazawa',
 'kberg:linux1394.org' => 'Steve Kinneberg',
@@ -1352,6 +1384,7 @@
 'lesanti:sinectis.com.ar' => 'Leandro Santi',
 'lethal:linux-sh.org' => 'Paul Mundt',
 'lethal:unusual.internal.linux-sh.org' => 'Paul Mundt',
+'lev_makhlis:bmc.com' => 'Lev Makhlis',
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
 'liam.girdwood:wolfsonmicro.com' => 'Liam Girdwood',
@@ -1386,6 +1419,7 @@
 'lkml:lievin.net' => 'Romain Liévin',
 'lkml:mathfillsmewithgreatjoy.com' => 'Michael Plump',
 'lkml:shemesh.biz' => 'Shachar Shemesh',
+'lkml:steffenspage.de' => 'Steffen Zieger',
 'lm:bitmover.com' => 'Larry McVoy',
 'lm:work.bitmover.com' => 'Larry McVoy',
 'lode_leroy:hotmail.com' => 'Lode Leroy',
@@ -1422,6 +1456,7 @@
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
 'macro:linux-mips.org' => 'Maciej W. Rozycki',
 'maeda.naoaki:jp.fujitsu.com' => 'Maeda Naoaki',
+'mahalcro:us.ibm.com' => 'Michael A. Halcrow',
 'mail:de.rmk.(none)' => 'Peter Teichmann',
 'mail:gude.info' => 'Gude Analog- und Digitalsysteme GmbH',
 'mail:s-holst.de' => 'Stefan Holst',
@@ -1513,6 +1548,7 @@
 'mds:paradyne.com' => 'Mark D. Studebaker',
 'mebrown:michaels-house.net' => 'Michael E. Brown',
 'mec:shout.net' => 'Michael Elizabeth Chastain',
+'medaglia:undl.org.br' => 'Carlos Eduardo Medaglia Dyonisio',
 'meissner:suse.de' => 'Marcus Meissner',
 'menard.fabrice:wanadoo.fr' => 'Fabrice Menard',
 'metolent:snoqualmie.dp.intel.com' => 'Matt Tolentino',
@@ -1579,6 +1615,7 @@
 'mk:linux-ipv6.org' => 'Mitsuru Kanda',
 'mkp:mkp.net' => 'Martin K. Petersen', # lbdb
 'mlang:delysid.org' => 'Mario Lang', # google
+'mlev:despammed.com' => 'Lev Makhlis',
 'mlindner:syskonnect.de' => 'Mirko Lindner',
 'mlocke:mvista.com' => 'Montavista Software, Inc.',
 'mlord:pobox.com' => 'Mark Lord',
@@ -1679,6 +1716,7 @@
 'obelix123:toughguy.net' => 'Raj',		# Hmm..
 'obi:saftware.de' => 'Andreas Oberritter',
 'od:suse.de' => 'Olaf Dabrunz',
+'oe:port.de' => 'Heinz-Juergen Oertel',
 'ogasawara:osdl.org' => 'Leann Ogasawara',
 'okir:suse.de' => 'Olaf Kirch', # lbdb
 'okurth:gmx.net' => 'Oliver Kurth',
@@ -1731,6 +1769,7 @@
 'paul+nospam:wurtel.net' => 'Paul Slootman',
 'paul.clements:steeleye.com' => 'Paul Clements',
 'paul.focke:pandora.be' => 'Paul Focke',
+'paul.mundt:nokia.com' => 'Paul Mundt',
 'paul.mundt:timesys.com' => 'Paul Mundt', # google
 'paul:allied-universal.com' => 'Paul King',
 'paul:kungfoocoder.org' => 'Paul Wagland', # lbdb
@@ -1793,10 +1832,11 @@
 'petkan:rakia.hell.org' => 'Petko Manolov',
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
 'pg:futureware.at' => 'Philipp Gühring',
@@ -1846,6 +1886,7 @@
 'ptiedem:de.ibm.com' => 'Peter Tiedemann',
 'purna:jcom.home.ne.jp' => 'Yusuf Wilajati Purna',
 'pwaechtler:mac.com' => 'Peter Wächtler',
+'pwil3058:bigpond.net.au' => 'Peter Williams',
 'pzad:pobox.sk' => 'Peter Zubaj',
 'q:kampsax.dtu.dk' => 'Dennis Jørgensen',
 'qboosh:pld-linux.org' => 'Jakub Bogusz',
@@ -1914,6 +1955,7 @@
 'rmk-pci:arm.linux.org.uk' => 'Russell King',
 'rmk:arm.linux.org.uk' => 'Russell King',
 'rmk:flint.arm.linux.org.uk' => 'Russell King',
+'rml:novell.com' => 'Robert Love',
 'rml:tech9.net' => 'Robert Love',
 'rml:ximian.com' => 'Robert Love',
 'rnp:paradise.net.nz' => 'Richard Procter',
@@ -1967,6 +2009,7 @@
 'rth:twiddle.net' => 'Richard Henderson',
 'rth:vsop.sfbay.redhat.com' => 'Richard Henderson',
 'rtjohnso:eecs.berkeley.edu' => 'Robert T. Johnson',
+'ruben:ugr.es' => 'Ruben Garcia',
 'ruby.joker:op.pl' => 'Ruby Joker',
 'rui.sousa:laposte.net' => 'Rui Sousa',
 'runet:innovsys.com' => 'Rune Torgersen',
@@ -2089,7 +2132,9 @@
 'sojka:planetarium.cz' => 'Michal Sojka',
 'solar:openwall.com' => 'Solar Designer',
 'solca:guug.org' => 'Otto Solares',
+'solt2:dns.toxicfilms.tv' => 'Maciej Soltysiak',
 'solt:dns.toxicfilms.tv' => 'Maciej Soltysiak',
+'songqf9:yahoo.ca' => 'Alex Song',
 'sonny:burdell.org' => 'Sonny Rao',
 'soruk:eridani.co.uk' => 'Michael McConnell',
 'sparclinux:abeckmann.de' => 'Andreas Beckmann',
@@ -2119,6 +2164,7 @@
 'stekloff:w-stekloff.beaverton.ibm.com' => 'Daniel Stekloff',
 'stelian.pop:fr.alcove.com' => 'Stelian Pop',
 'stelian:popies.net' => 'Stelian Pop',
+'stephan.walter:epfl.ch' => 'Stephan Walter',
 'stephane.galles:free.fr' => 'Stephane Galles', # guessed
 'stephanm:muc.de' => 'Stephan Maciej',
 'stephen:phynp6.phy-astr.gsu.edu' => 'Stephen Leonard',
@@ -2284,6 +2330,7 @@
 'urban.widmark:enlight.net' => 'Urban Widmark',
 'urban:teststation.com' => 'Urban Widmark',
 'uros:kss-loka.si' => 'Uros Bizjak',
+'util:deuroconsult.ro' => 'Catalin Boie',
 'utz.bacher:de.ibm.com' => 'Utz Bacher',
 'uwe.bugla:gmx.de' => 'Uwe Bugla',
 'uwe.koziolek:gmx.net' => 'Uwe Koziolek',
@@ -2313,6 +2360,7 @@
 'viro:parcelfarce.linux.org.uk' => 'Alexander Viro',
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'viro:www.linux.org.uk' => 'Alexander Viro',
+'vladimir.grouzdev:jaluna.com' => 'Vladimir Grouzdev',
 'vmlinuz386:yahoo.com.ar' => 'Gerardo Exequiel Pozzi', # lbdb
 'vnourval:tcs.hut.fi' => 'Ville Nuorvala',		# Can't spell his own login?
 'vnuorval:tcs.hut.fi' => 'Ville Nuorvala',
@@ -2370,6 +2418,7 @@
 'wolfgang:iksw-muees.de' => 'Wolfgang Muees',
 'wolfgang:top.mynetix.de' => 'Wolfgang Mauerer',
 'woody:org.rmk.(none)' => 'Woody Suwalski',
+'wouter-kernel:fort-knox.rave.org' => 'Wouter Van Hemel',
 'wriede:riede.org' => 'Willem Riede',
 'wrlk:riede.org' => 'Willem Riede',
 'wstinson:infonie.fr' => 'William Stinson',
@@ -2401,6 +2450,7 @@
 'yuvalt:gmail.com' => 'Yuval Turgeman',
 'zach:vmware.com' => 'Zachary Amsden',
 'zaitcev:redhat.com' => 'Pete Zaitcev',
+'zaitcev:yahoo.com' => 'Pete Zaitcev',
 'zap:homelink.ru' => 'Andrew Zabolotny',
 'zap:ru.rmk.(none)' => 'Andrew Zabolotny',
 'zdzichu:irc.pl' => 'Tomasz Torcz',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
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
AA==

