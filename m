Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbUKIIo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbUKIIo3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 03:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbUKIIo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 03:44:29 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:61329 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261446AbUKIIm4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 03:42:56 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue,_09_Nov_2004_08_42_47_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20041109084247.C8D97D77E4@merlin.emma.line.org>
Date: Tue,  9 Nov 2004 09:42:47 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.242, 2004-11-09 09:30:59+01:00, samel@mail.cz
  shortlog: 16 new addresses

ChangeSet@1.241, 2004-11-05 14:44:11+01:00, samel@mail.cz
  shortlog: 2 new addresses

ChangeSet@1.240, 2004-11-04 14:08:27+01:00, samel@mail.cz
  shortlog: 14 new addresses

ChangeSet@1.239, 2004-10-29 15:02:34+02:00, samel@mail.cz
  shortlog: add 16 new addresses

ChangeSet@1.238, 2004-10-26 09:20:50+02:00, samel@mail.cz
  shortlog: added 26 new addresses

ChangeSet@1.236, 2004-10-22 00:37:25+02:00, matthias.andree@gmx.de
  Correct Petri T. Koistinen's name as per his own request.

ChangeSet@1.235, 2004-10-21 14:27:47+02:00, samel@mail.cz
  shortlog: 50 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |  130 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 127 insertions(+), 3 deletions(-)

##### GNUPATCH #####
--- 1.206/shortlog	2004-10-19 03:59:57 +02:00
+++ 1.215/shortlog	2004-11-09 09:42:05 +01:00
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.324 2004/10/19 01:59:56 emma Exp $
+# $Id: lk-changelog.pl,v 0.326 2004/11/09 08:42:04 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -198,6 +198,7 @@
 'agx:sigxcpu.org' => 'Guido Guenther',
 'ahaas:airmail.net' => 'Art Haas',
 'ahaas:neosoft.com' => 'Art Haas',
+'ahendry:tusc.com.au' => 'Andrew Hendry',
 'aherrman:de.ibm.com' => 'Andreas Herrmann',
 'ahu:ds9a.nl' => 'Bert Hubert',
 'aia21:cam.ac.uk' => 'Anton Altaparmakov',
@@ -216,10 +217,12 @@
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
@@ -234,10 +237,12 @@
 'alanh:fairlite.demon.co.uk' => 'Alan Hourihane',
 'alanh:tungstengraphics.com' => 'Alan Hourihane',
 'albert.cahalan:ccur.com' => 'Albert Cahalan',
+'albert:users.sf.net' => 'Albert Cahalan',
 'albert:users.sourceforge.net' => 'Albert Cahalan',
 'albertogli:telpin.com.ar' => 'Alberto Bertogli',
 'alborchers:steinerpoint.com' => 'Al Borchers',
 'alessandro.zummo:towertech.it' => 'Alessandro Zummo',
+'alex.kiernan:gmail.com' => 'Alex Kiernan',
 'alex.williamson:com.rmk.(none)' => 'Alex Williamson',
 'alex.williamson:hp.com' => 'Alex Williamson',
 'alex:alexdalton.org' => 'Alexandre d\'Alton',
@@ -278,6 +283,7 @@
 'andre:linux-ide.org' => 'Andre Hedrick',
 'andrea:novell.com' => 'Andrea Arcangeli',
 'andrea:suse.de' => 'Andrea Arcangeli',
+'andreas:fjortis.info' => 'Andreas Henriksson',
 'andreas:xss.co.at' => 'Andreas Haumer',
 'andrej.filipcic:ijs.si' => 'Andrej Filipcic',
 'andrew.grover:intel.com' => 'Andy Grover', # "Andy" to match former entries
@@ -287,6 +293,7 @@
 'andrew:lunn.ch' => 'Andrew Lunn',
 'andries.brouwer:cwi.nl' => 'Andries E. Brouwer',
 'andros:citi.umich.edu' => 'Andy Adamson',
+'andros:thnk.citi.umich.edu' => 'William A. Adamson',
 'andros:umich.edu' => 'Andy Adamson',
 'andyw:uk.ibm.com' => 'Andy Whitcroft',
 'aneesh.kumar:digital.com' => 'Aneesh Kumar KV',
@@ -299,6 +306,7 @@
 'anton:samba.org' => 'Anton Blanchard',
 'anton:superego.(none)' => 'Anton Blanchard',
 'anton:superego.ozlabs.ibm.com' => 'Anton Blanchard',
+'aoki:sdl.hitachi.co.jp' => 'Hideo Aoki',
 'aoliva:redhat.com' => 'Alexandre Oliva',
 'ap:cipherica.com' => 'Alex Pankratov',
 'apm:brigitte.dna.fi' => 'Antti P. Miettinen',
@@ -310,7 +318,11 @@
 'arekm:pld-linux.org' => 'Arkadiusz Miskiewicz', # lbdb
 'arief_m_utama:telkomsel.co.id' => 'Arief Mulya Utama',
 'aris:cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
+'arjan:fenrus.demon.nl' => 'Arjan van de Ven',
+'arjan:infradead.org' => 'Arjan van de Ven',
+'arjan:nl.rmk.(none)' => 'Arjan van de Ven',
 'arjan:redhat.com' => 'Arjan van de Ven',
+'arjanv:infradead.org' => 'Arjan van de Ven',
 'arjanv:redhat.com' => 'Arjan van de Ven',
 'armcc2000:com.rmk.(none)' => 'Andre McCurdy',
 'armcc2000:yahoo.com' => 'Andre McCurdy',
@@ -320,6 +332,7 @@
 'arnd:bergmann-dalldorf.de' => 'Arnd Bergmann',
 'arndb:de.ibm.com' => 'Arnd Bergmann',
 'arndt:lin02384n012.mc.schoenewald.de' => 'Arndt Schoenewald',
+'arnouten:bzzt.net' => 'Arnout Engelen',
 'arubin:atl.lmco.com' => 'Aron Rubin',
 'arun.sharma:intel.com' => 'Arun Sharma',
 'arvidjaar:mail.ru' => 'Andrey Borzenkov',
@@ -336,6 +349,7 @@
 'aspicht:arkeia.com' => 'Arnaud Spicht',
 'ast:domdv.de' => 'Andreas Steinmetz',
 'async:cc.gatech.edu' => 'Rob Melby',
+'atomenergie:t-online.de' => 'Stephan Fuhrmann',
 'atul.mukker:lsil.com' => 'Atul Mukker',
 'atulm:lsil.com' => 'Atul Mukker',
 'augustus:linuxhardware.org' => 'Kris Kersey',
@@ -346,6 +360,7 @@
 'axboe:hera.kernel.org' => 'Jens Axboe',
 'axboe:suse.de' => 'Jens Axboe',
 'azarah:gentoo.org' => 'Martin Schlemmer',
+'azarah:nosferatu.za.org' => 'Martin Schlemmer',
 'aziz:hp.com' => 'Khalid Aziz', # Alan
 'b.zolnierkiewicz:elka.pw.edu.pl' => 'Bartlomiej Zolnierkiewicz',
 'baccala:vger.freesoft.org' => 'Brent Baccala',
@@ -372,7 +387,9 @@
 'bdshuym:pandora.be' => 'Bart De Schuymer', # it's typo IMHO
 'beattie:beattie-home.net' => 'Brian Beattie', # from david.nelson
 'bellucda:tiscali.it' => 'Daniele Bellucci',
+'ben-linux:fluff.org' => 'Ben Dooks',
 'ben-linux:org.rmk.(none)' => 'Ben Dooks',
+'ben:fluff.org' => 'Ben Dooks',
 'ben:simtec.co.uk' => 'Ben Dooks',
 'bengen:hilluzination.de' => 'Hilko Bengen',
 'benh:kenrel.crashing.org' => 'Benjamin Herrenschmidt', # typo
@@ -388,6 +405,7 @@
 'berny.f:aon.at' => 'Bernhard Fischer',
 'bero:arklinux.org' => 'Bernhard Rosenkraenzer',
 'bfennema:falcon.csc.calpoly.edu' => 'Ben Fennema',
+'bfg-kernel:blenning.no' => 'Tom Fredrik Blenning Klaussen',
 'bfields:citi.umich.edu' => 'J. Bruce Fields',
 'bfields:fieldses.org' => 'J. Bruce Fields',
 'bgerst:didntduck.org' => 'Brian Gerst',
@@ -427,6 +445,7 @@
 'brazilnut:us.ibm.com' => 'Don Fry',
 'brett:bad-sports.com' => 'Brett Pemberton',
 'brewt-linux-kernel:brewt.org' => 'Adrian Yee',
+'brian.haley:hp.com' => 'Brian Haley',
 'brian:rentec.com' => 'Brian Childs',
 'brihall:pcisys.net' => 'Brian Hall', # google
 'brill:fs.math.uni-frankfurt.de' => 'Björn Brill',
@@ -435,6 +454,7 @@
 'brownfld:irridia.com' => 'Ken Brownfield',
 'bryan:staidm.org' => 'Bryan Rittmeyer',
 'bryder:paradise.net.nz' => 'Bill Ryder',
+'bstroesser:fujitsu-siemens.com' => 'Bodo Stroesser',
 'buffer:antifork.org' => 'Angelo Dell\'Aera',
 'bugfixer:list.ru' => 'Nick Orlov',
 'bunk:de.rmk.(none)' => 'Adrian Bunk', # guessed
@@ -465,6 +485,8 @@
 'castet.matthieu:free.fr' => 'Matthieu Castet',
 'castor:3pardata.com' => 'Castor Fu',
 'cat:zip.com.au' => 'CaT',
+'catab:deuroconsult.ro' => 'Catalin Boie',
+'catab:umbrella.ro' => 'Catalin Boie',
 'catalin.marinas:com.rmk.(none)' => 'Catalin Marinas',
 'cattelan:lupo.thebarn.com' => 'Russell Cattelan',
 'cattelan:naboo.americas.sgi.com' => 'Russell Cattelan',
@@ -489,6 +511,7 @@
 'char:cmf.nrl.navy.mil' => 'Chas Williams', # typo ???
 'charles.white:hp.com' => 'Charles White',
 'chaus:cs.uni-potsdam.de' => 'Carsten Haustein',
+'chaus:rz.uni-potsdam.de' => 'Carsten Haustein',
 'chessman:tux.org' => 'Samuel S. Chessman',
 'chip:pobox.com' => 'Chip Salzenberg', # lbdb
 'chris:heathens.co.nz' => 'Chris Heath',
@@ -500,6 +523,7 @@
 'christer:weinigel.se' => 'Christer Weinigel', # from shortlog
 'christian:borntraeger.net' => 'Christian Borntraeger',
 'christoph:graphe.net' => 'Christoph Lameter',
+'christoph:lameter.com' => 'Christoph Lameter',
 'christophe:saout.de' => 'Christophe Saout',
 'christopher.leech:intel.com' => 'Christopher Leech',
 'christopher:intel.com' => 'Christopher Goldfarb',
@@ -511,6 +535,7 @@
 'ckulesa:as.arizona.edu' => 'Craig Kulesa',
 'clameter:sgi.com' => 'Christoph Lameter',
 'clemens-dated-1061728015.bf63:endorphin.org' => 'Fruhwirth Clemens',
+'clemens:endorphin.org' => 'Fruhwirth Clemens',
 'clemens:ladisch.de' => 'Clemens Ladisch',
 'clemy:clemy.org' => 'Bernhard C. Schrenk',
 'cloos:jhcloos.com' => 'James H. Cloos Jr.',
@@ -543,6 +568,7 @@
 'cr7:os.inf.tu-dresden.de' => 'Carsten Rietzschel',
 'cr:sap.com' => 'Christoph Rohland',
 'craig.nadler:arc.com' => 'Craig Nadler',
+'craig:gumstix.com' => 'Craig Hughes',
 'craig:homerjay.homelinux.org' => 'Craig Wilkie',
 'cramerj:intel.com' => 'Jeb J. Cramer',
 'cruault:724.com' => 'Charles-Edouard Ruault',
@@ -568,6 +594,7 @@
 'damien.morange:hp.com' => 'Damien Morange',
 'dan.zink:hp.com' => 'Dan Zink',
 'dan:debian.org' => 'Daniel Jacobowitz',
+'dan:embeddededge.com' => 'Dan Malek',
 'dan:geefour.netx4.com' => 'Dan Malek',
 'dan:reactivated.net' => 'Daniel Drake',
 'dana.lacoste:peregrine.com' => 'Dana Lacoste',
@@ -587,6 +614,7 @@
 'dave:qix.net' => 'Dave Maietta',
 'dave:thedillows.org' => 'David Dillow',
 'davej:codmonkey.org.uk' => 'Dave Jones', # not matched by regexp above
+'davej:dhcp83-103.boston.redhat.com' => 'Dave Jones',
 'davej:hardwired.(none)' => 'Dave Jones',
 'davej:redhat.com' => 'Dave Jones', # lbdb
 'davej:suse.de' => 'Dave Jones',
@@ -608,6 +636,7 @@
 'david.nelson:pobox.com' => 'David Nelson',
 'david:csse.uwa.edu.au' => 'David Glance',
 'david:gibson.dropbear.id.au' => 'David Gibson',
+'david:panzer.utcluj.ro' => 'David Lazar',
 'david_jeffery:adaptec.com' => 'David Jeffery',
 'davidel:xmailserver.org' => 'Davide Libenzi',
 'davidjoerg:web.de' => 'David Jörg',
@@ -631,6 +660,7 @@
 'defouwj:purdue.edu' => 'Jeff DeFouw',
 'delaunay:lix.polytechnique.fr' => 'Eric Delaunay',
 'deller:gmx.de' => 'Helge Deller',
+'dely.l.sy:intel.com' => 'Dely Sy',
 'dent:cosy.sbg.ac.at' => "Thomas 'Dent' Mirlacher",
 'der.eremit:email.de' => 'Pascal Schmidt',
 'derek:ihtfp.com' => 'Derek Atkins',
@@ -646,8 +676,11 @@
 'dhowells:redhat.com' => 'David Howells',
 'dhylands:com.rmk.(none)' => 'Dave Hylands',
 'diegocg:teleline.es' => 'Diego Calleja García',
+'dignome:gmail.com' => 'Lonnie Mendez',
 'dilinger:mp3revolution.net' => 'Andres Salomon',
 'dilinger:voxel.net' => 'Andres Salomon',
+'dimitry.andric:tomtom.com' => 'Dimitry Andric',
+'dino:in.ibm.com' => 'Dinakar Guniguntala',
 'dipankar:in.ibm.com' => 'Dipankar Sarma',
 'dirk.behme:com.rmk.(none)' => 'Dirk Behme',
 'dirk.behme:de.bosch.com' => 'Dirk Behme',
@@ -700,11 +733,13 @@
 'duncan.sands:math.u-psud.fr' => 'Duncan Sands',
 'duncan:sun.com' => 'Duncan Laurie',
 'duwe:suse.de' => 'Torsten Duwe',
+'dvhltc:us.ibm.com' => 'Darren Hart',
 'dvrabel:arcom.com' => 'David Vrabel',
 'dvrabel:com.rmk.(none)' => 'David Vrabel',
 'dwcraig:qualcomm.com' => 'Dave Craig',
 'dwg:au.ibm.com' => 'David Gibson',
 'dwg:au1.ibm.com' => 'David Gibson',
+'dwm:austin.ibm.com' => 'Doug Maxey',
 'dwmw2:dwmw2.baythorne.internal' => 'David Woodhouse',
 'dwmw2:infradead.org' => 'David Woodhouse',
 'dwmw2:redhat.com' => 'David Woodhouse',
@@ -717,7 +752,9 @@
 'ecashin:coraid.com' => 'Ed L. Cashin',
 'ecashin:uga.edu' => 'Ed L. Cashin',
 'ecd:skynet.be' => 'Eddie C. Dost',
+'ed:il.fontys.nl' => 'Ed Schouten',
 'eddie.williams:steeleye.com' => 'Eddie Williams',
+'edrossma:us.ibm.com' => 'Eric Rossman',
 'edv:macrolink.com' => 'Ed Vance',
 'edward_peng:dlink.com.tw' => 'Edward Peng',
 'edwardsg:sgi.com' => 'Greg Edwards', # google
@@ -727,6 +764,8 @@
 'eger:theboonies.us' => 'David Eger',
 'egmont:uhulinux.hu' => 'Egmont Koblinger',
 'ehabkost:conectiva.com.br' => 'Eduardo Pereira Habkost',
+'ehrhardt:mathematik.uni-ulm.de' => 'Christian Ehrhardt',
+'eich:suse.de' => 'Egbert Eich',
 'eike-hotplug:sf-tec.de' => 'Rolf Eike Beer',
 'eike-kernel:sf-tec.de' => 'Rolf Eike Beer', # sent by himself
 'eike:bilbo.math.uni-mannheim.de' => 'Rolf Eike Beer',
@@ -791,6 +830,7 @@
 'fenghua.yu:intel.com' => 'Fenghua Yu', # google
 'fenlason:redhat.com' => 'Jay Fenlason',
 'fero:sztalker.hu' => 'Bakonyi Ferenc',
+'fhirtz:redhat.com' => 'Frank Hirtz',
 'filip.sneppe:cronos.be' => 'Filip Sneppe',
 'fischer:linux-buechse.de' => 'Jürgen E. Fischer',
 'fishor:gmx.net' => 'Alexey Fisher',
@@ -826,6 +866,7 @@
 'gaa:ulticom.com' => 'Gary Algier', # google
 'galak:blarg.somerset.sps.mot.com' => 'Kumar Gala',
 'galak:somerset.sps.mot.com' => 'Kumar Gala',
+'gamal:alternex.com.br' => 'Haroldo Gamal',
 'ganadist:nakyup.mizi.com' => 'Cha Young-Ho',
 'gandalf:netfilter.org' => 'Martin Josefsson',
 'gandalf:winds.org' => 'Byron Stanoszek',
@@ -849,6 +890,7 @@
 'geraldsc:de.ibm.com' => 'Gerald Schaefer',
 'gerg:moreton.com.au' => 'Greg Ungerer',
 'gerg:snapgear.com' => 'Greg Ungerer',
+'gerg:uclinux.org' => 'Greg Ungerer',
 'ghoward:sgi.com' => 'Greg Howard',
 'ghoz:sympatico.ca' => 'Ghozlane Toumi',
 'gibbs:overdrive.btc.adaptec.com' => 'Justin T. Gibbs',
@@ -859,6 +901,7 @@
 'gj:pointblue.com.pl' => 'Grzegorz Jaskiewicz',
 'gjaeger:sysgo.com' => 'Gerhard Jaeger',
 'gkernel.adm:hostme.bitkeeper.com' => 'Jeff Garzik', # himself
+'gkurz:meiosys.com' => 'Gregory Kurz',
 'gl:dsa-ac.de' => 'Guennadi Liakhovetski',
 'glee:gnupilgrims.org' => 'Geoffrey Lee', # lbdb
 'glen:imodulo.com' => 'Glen Nakamura',
@@ -892,6 +935,7 @@
 'gsromero:alumnos.euitt.upm.es' => 'Guillermo S. Romero',
 'gtoumi:laposte.net' => 'Ghozlane Toumi',
 'gtw:cs.bu.edu' => 'Gary Wong',
+'guido.barzini:com.rmk.(none)' => 'Guido Barzini',
 'guillaume.thouvenin:bull.net' => 'Guillaume Thouvenin',
 'guillaume:morinfr.org' => 'Guillaume Morin',
 'gwehrman:sgi.com' => 'Geoffrey Wehrman',
@@ -910,8 +954,10 @@
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
@@ -930,6 +976,7 @@
 'heiko.carstens:de.ibm.com' => 'Heiko Carstens',
 'helgaas:fc.hp.com' => 'Bjorn Helgaas', # doesn't want ø/å
 'helgaas:hp.com' => 'Bjorn Helgaas', # guessed
+'helmut:helios.de' => 'Helmut Tschemernjak',
 'henk:god.dyndns.org' => 'Henk Vergonet',
 'henning:meier-geinitz.de' => 'Henning Meier-Geinitz',
 'henning:wh9.tu-dresden.de' => 'Henning Schild',
@@ -945,10 +992,13 @@
 'herry:sgi.com' => 'Herry Wiputra',
 'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
 'hiroshi_doyu:montavista.co.jp' => 'Hiroshi Doyu',
+'hj.oertel:surfeu.de' => 'Heinz-Juergen Oertel',
 'hjl:lucon.org' => 'H. J. Lu',
 'hjm:redhat.com' => 'Heinz Mauelshagen', # lbdb
+'hno:marasystems.com' => 'Henrik Nordstrom',
 'hoho:binbash.net' => 'Colin Slater',
 'holger.smolinski:de.ibm.com' => 'Holger Smolinski',
+'holland:loser.net' => 'Shannon Holland',
 'hollis:austin.ibm.com' => 'Hollis Blanchard',
 'hollisb:us.ibm.com' => 'Hollis Blanchard',
 'holt:sgi.com' => 'Robin Holt',
@@ -1010,6 +1060,8 @@
 'jamagallon:able.es' => 'J. A. Magallon',
 'james.bottomley:steeleye.com' => 'James Bottomley',
 'james.smart:emulex.com' => 'James Smart',
+'james4765:gmail.com' => 'James Nelson',
+'james4765:verizon.net' => 'James Nelson',
 'james:cobaltmountain.com' => 'James Mayer',
 'james:superbug.demon.co.uk' => 'James Courtier-Dutton',
 'james_mcmechan:hotmail.com' => 'James McMechan',
@@ -1027,8 +1079,10 @@
 'jani:iv.ro' => 'Jani Monoses',
 'janiceg:us.ibm.com' => 'Janice M. Girouard',
 'janitor:at.none.(rmk)' => 'Maximilian Attems',
+'janitor:at.rmk.(none)' => 'Maximilian Attems',
 'janitor:sternwelten.at' => 'Maximilian Attems',
 'jason.davis:unisys.com' => 'Jason Davis',
+'jasonuhl:sgi.com' => 'Jason Uhlenkott',
 'jasper:vs19.net' => 'Jasper Spaans',
 'javaman:katamail.com' => 'Paulo Ornati',
 'javier:tudela.mad.ttd.net' => 'Javier Achirica',
@@ -1058,6 +1112,8 @@
 'jeb.j.cramer:intel.com' => 'Jeb J. Cramer',
 'jef:linuxbe.org' => 'Jean-Francois Dive',
 'jeff.wiedemeier:hp.com' => 'Jeff Wiedemeier',
+'jeffm:csh.rit.edu' => 'Jeff Mahoney',
+'jeffm:novell.com' => 'Jeff Mahoney',
 'jeffm:suse.com' => 'Jeff Mahoney',
 'jeffm:suse.de' => 'Jeff Mahoney',
 'jeffml:pobox.com' => 'Jeff Lightfoot',
@@ -1112,6 +1168,7 @@
 'jiho:c-zone.net' => 'Jim Howard',
 'jim.hague:acm.org' => 'Jim Hague',
 'jim.houston:attbi.com' => 'Jim Houston',
+'jim.houston:ccur.com' => 'Jim Houston',
 'jim.houston:comcast.net' => 'Jim Houston',
 'jim:hamachi.net' => 'Jim Collette',
 'jk:ozlabs.org' => 'Jeremy Kerr',
@@ -1146,6 +1203,7 @@
 'johann.deneux:it.uu.se' => 'Johann Deneux',
 'johann.deneux:laposte.net' => 'Johann Deneux',
 'johannes:erdfelt.com' => 'Johannes Erdfelt',
+'johansen:immunix.com' => 'John Johansen',
 'john.cagle:hp.com' => 'John Cagle',
 'john.l.byrne:hp.com' => 'John L. Byrne',
 'john:deater.net' => 'John Clemens',
@@ -1157,6 +1215,7 @@
 'johnpol:2ka.mipt.ru' => 'Evgeniy Polyakov',
 'johnrose:austin.ibm.com' => 'John Rose',
 'johnstul:us.ibm.com' => 'John Stultz',
+'jolt:tuxbox.org' => 'Florian Schirmer',
 'jon:ballardtech.com' => 'Jon Neal',
 'jon:focalhost.com' => 'Jon Oberheide',
 'jon:jon-foster.co.uk' => 'Jon Foster',
@@ -1164,6 +1223,7 @@
 'jonas.larsson:net.rmk.(none)' => 'Jonas Larsson',
 'jonas:thornblad.net' => 'Jonas Thornblad',
 'jones:ingate.com' => 'Jones Desougi',
+'jongk:linux-m68k.org' => 'Kars de Jong',
 'jonsmirl:gmail.com' => 'Jon Smirl',
 'jonsmirl:yahoo.com' => 'Jon Smirl',
 'joris:eljakim.nl' => 'Joris van Rantwijk',
@@ -1188,10 +1248,12 @@
 'jsimmons:transvirtual.com' => 'James Simmons',
 'jsm:fc.hp.com' => 'John S. Marvin',
 'jsm:udlkern.fc.hp.com' => 'John S. Marvin',
+'jstultz:us.ibm.com' => 'John Stultz',
 'jsun:mvista.com' => 'Jun Sun',
 'jt:bougret.hpl.hp.com' => 'Jean Tourrilhes',
 'jt:bougret.jpl.hp.com' => 'Jean Tourrilhes',	# jpl? Whaa? hpl!
 'jt:hpl.hp.com' => 'Jean Tourrilhes',
+'jthiessen:penguincomputing.com' => 'Justin Thiessen',
 'jtyner:cs.ucr.edu' => 'John Tyner',
 'judd:jpilot.org' => 'Judd Montgomery',
 'juergen:jstuber.net' => 'Jürgen Stuber',
@@ -1205,8 +1267,10 @@
 'jwboyer:infradead.org' => 'Josh Boyer',
 'jwoithe:physics.adelaide.edu.au' => 'Jonathan Woithe',
 'k-suganuma:mvj.biglobe.ne.jp' => 'Kimio Suganuma',
+'k.chmielewski:neostrada.pl' => 'Krzysztof Chmielewski',
 'k.kasprzak:box43.pl' => 'Karol Kasprzak', # by Kristian Peters
 'kaber:coreworks.de' => 'Patrick McHardy',
+'kaber:trash.ne' => 'Patrick McHardy', # typo
 'kaber:trash.net' => 'Patrick McHardy',
 'kadlec:blackhole.kfki.hu' => 'Jozsef Kadlecsik',
 'kai-germaschewski:uiowa.edu' => 'Kai Germaschewski',
@@ -1232,9 +1296,11 @@
 'kare.sars:lmf.ericsson.se' => 'Kåre Särs',
 'karlis:mt.lv' => 'Karlis Peisenieks',
 'kartik_me:hotmail.com' => 'Kartikey Mahendra Bhatt',
+'kas:fi.muni.cz' => 'Jan Kasprzak',
 'kas:informatics.muni.cz' => 'Jan Kasprzak', # lbdb
 'kasperd:daimi.au.dk' => 'Kasper Dupont',
 'katzj:redhat.com' => 'Jeremy Katz',
+'kay.sievers:vrfy.org' => 'Kay Sievers',
 'kaz:earth.email.ne.jp' => 'Kazuto Miyoshi',
 'kazunori:miyazawa.org' => 'Kazunori Miyazawa',
 'kberg:linux1394.org' => 'Steve Kinneberg',
@@ -1352,8 +1418,10 @@
 'lesanti:sinectis.com.ar' => 'Leandro Santi',
 'lethal:linux-sh.org' => 'Paul Mundt',
 'lethal:unusual.internal.linux-sh.org' => 'Paul Mundt',
+'lev_makhlis:bmc.com' => 'Lev Makhlis',
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
+'liam.girdwood:com.rmk.(none)' => 'Liam Girdwood',
 'liam.girdwood:wolfsonmicro.com' => 'Liam Girdwood',
 'linas:austin.ibm.com' => 'Linas Vepstas',
 'linas:linas.org' => 'Linas Vepstas',
@@ -1371,6 +1439,7 @@
 'linux:hazard.jcu.cz' => 'Jan Marek',
 'linux:kodeaffe.de' => 'Sebastian Henschel',
 'linux:michaelgeng.de' => 'Michael Geng',
+'linux:rainbow-software.org' => 'Ondrej Zary',
 'linux:sandersweb.net' => 'David Sanders',
 'linux:thorsten-knabe.de' => 'Thorsten Knabe',
 'linux:youmustbejoking.demon.co.uk' => 'Darren Salt',
@@ -1379,17 +1448,23 @@
 'linville:tuxdriver.com' => 'John W. Linville',
 'lionel.bouton:inet6.fr' => 'Lionel Bouton',
 'lists:mdiehl.de' => 'Martin Diehl',
+'lists:wildgooses.com' => 'Ed Wildgoose',
 'livio:ime.usp.br' => 'Livio Baldini Soares',
 'liyang:nerv.cx' => 'Liyang Hu',
 'lkml001:vrfy.org' => 'Kay Sievers',
 'lkml:felipe-alfaro.com' => 'Felipe Alfaro Solana',
 'lkml:lievin.net' => 'Romain Liévin',
 'lkml:mathfillsmewithgreatjoy.com' => 'Michael Plump',
+'lkml:rtr.ca' => 'Mark Lord',
 'lkml:shemesh.biz' => 'Shachar Shemesh',
+'lkml:steffenspage.de' => 'Steffen Zieger',
 'lm:bitmover.com' => 'Larry McVoy',
 'lm:work.bitmover.com' => 'Larry McVoy',
+'lmb:suse.de' => 'Lars Marowsky-Bree',
+'lmendez19:austin.rr.com' => 'Lonnie Mendez',
 'lode_leroy:hotmail.com' => 'Lode Leroy',
 'loftin:ldl.fc.hp.com' => 'Terry Loftin',
+'long.pu:intel.com' => 'Pu Long',
 'lopezp:grupocp.es' => 'Jose A. Lopez',
 'lord:jen.americas.sgi.com' => 'Stephen Lord',
 'lord:laptop.americas' => 'Stephen Lord',
@@ -1400,6 +1475,7 @@
 'louis_zhuang:linux.co.intel.com' => 'Louis Zhuang',
 'louisk:cse.unsw.edu.au' => 'Louis Yu-Kiu Kwan',
 'lowekamp:cs.wm.edu' => 'Bruce B. Lowekamp', # lbdb
+'lsml:rtr.ca' => 'Mark Lord', # typo ?
 'luben:splentec.com' => 'Luben Tuikov',
 'luben_tuikov:adaptec.com' => 'Luben Tuikov',
 'luc.vanoostenryck:easynet.be' => 'Luc Van Oostenryck', # lbdb
@@ -1422,6 +1498,7 @@
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
 'macro:linux-mips.org' => 'Maciej W. Rozycki',
 'maeda.naoaki:jp.fujitsu.com' => 'Maeda Naoaki',
+'mahalcro:us.ibm.com' => 'Michael A. Halcrow',
 'mail:de.rmk.(none)' => 'Peter Teichmann',
 'mail:gude.info' => 'Gude Analog- und Digitalsysteme GmbH',
 'mail:s-holst.de' => 'Stefan Holst',
@@ -1464,6 +1541,7 @@
 'markhe:veritas.com' => 'Mark Hemment',
 'markus.lidel:shadowconnect.com' => 'Markus Lidel',
 'marr:flex.com' => 'Bill Marr',
+'martin-langer:gmx.de' => 'Martin Langer',
 'martin.bene:icomedias.com' => 'Martin Bene',
 'martin.bligh:us.ibm.com' => 'Martin J. Bligh',
 'martin.lubich:gmx.at' => 'Martin Lubich',
@@ -1485,6 +1563,7 @@
 'matthewc:cse.unsw.edu.au' => 'Matthew Chapman',
 'matthewn:snapgear.com' => 'Matthew Natalier',
 'matthias.andree:gmx.de' => 'Matthias Andree', # added by himself
+'matthias:net.rmk.(none)' => 'Matthias Burghardt',
 'mauelshagen:redhat.com' => 'Heinz J. Mauelshagen',
 'mauelshagen:sistina.com' => 'Heinz J. Mauelshagen',
 'maverick:eskuel.net' => 'Mathieu Lesniak',
@@ -1507,12 +1586,14 @@
 'mcp:linux-systeme.de' => 'Marc-Christian Petersen',
 'mdharm-scsi:one-eyed-alien.net' => 'Matthew Dharm',
 'mdharm-usb:one-eyed-alien.net' => 'Matthew Dharm',
+'mdharm:momenco.com' => 'Matthew Dharm',
 'mdharm:one-eyed-alien.net' => 'Matthew Dharm',
 'mdiehl:mdiehl.de' => 'Martin Diehl',
 'mdomsch:dell.com' => 'Matt Domsch', # lbdb
 'mds:paradyne.com' => 'Mark D. Studebaker',
 'mebrown:michaels-house.net' => 'Michael E. Brown',
 'mec:shout.net' => 'Michael Elizabeth Chastain',
+'medaglia:undl.org.br' => 'Carlos Eduardo Medaglia Dyonisio',
 'meissner:suse.de' => 'Marcus Meissner',
 'menard.fabrice:wanadoo.fr' => 'Fabrice Menard',
 'metolent:snoqualmie.dp.intel.com' => 'Matt Tolentino',
@@ -1539,6 +1620,7 @@
 'michaelw:foldr.org' => 'Michael Weber', # google
 'michal:harddata.com' => 'Michal Jaegermann',
 'michal:logix.cz' => 'Michal Ludvig',
+'michal:rokos.info' => 'Michal Rokos',
 'michal_dobrzynski:mac.com' => 'Michal Dobrzynski',
 'michel.marti:objectxp.com' => 'Michel Marti',
 'michel:daenzer.net' => 'Michel Dänzer',
@@ -1579,6 +1661,7 @@
 'mk:linux-ipv6.org' => 'Mitsuru Kanda',
 'mkp:mkp.net' => 'Martin K. Petersen', # lbdb
 'mlang:delysid.org' => 'Mario Lang', # google
+'mlev:despammed.com' => 'Lev Makhlis',
 'mlindner:syskonnect.de' => 'Mirko Lindner',
 'mlocke:mvista.com' => 'Montavista Software, Inc.',
 'mlord:pobox.com' => 'Mark Lord',
@@ -1586,6 +1669,7 @@
 'mludvig:suse.cz' => 'Michal Ludvig',
 'mmagallo:debian.org' => 'Marcelo E. Magallon',
 'mmcclell:bigfoot.com' => 'Mark McClelland',
+'mmelchior:xs4all.nl' => 'Matthijs Melchior',
 'mochel:bambi.(none)' => 'Patrick Mochel',
 'mochel:digitalimplant.org' => 'Patrick Mochel',
 'mochel:geena.pdx.osdl.net' => 'Patrick Mochel',
@@ -1611,6 +1695,7 @@
 'mporter:kernel.crashing.org' => 'Matt Porter',
 'mroos:linux.ee' => 'Meelis Roos',
 'mrr:nexthop.com' => 'Mathew Richardson',
+'mru:inprovide.com' => 'Maans Rullgaard',
 'mru:kth.se' => 'Mans Rullgard',
 'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
 'msw:redhat.com' => 'Matt Wilson',
@@ -1633,6 +1718,7 @@
 'nathans:sgi.com' => 'Nathan Scott',
 'naveenb:cisco.com' => 'Naveen Burmi', # lbdb
 'nbryant:optonline.net' => 'Nathan Bryant',
+'ncunningham:linuxmail.org' => 'Nigel Cunningham',
 'ncunningham:users.sourceforge.net' => 'Nigel Cunningham',
 'neal:bakerst.org' => 'Neal Stephenson',
 'neil:bortnak.com' => 'Neil Bortnak',
@@ -1652,6 +1738,7 @@
 'nicolas.mailhot:laposte.net' => 'Nicolas Mailhot',
 'nicolas:boichat.ch' => 'Nicolas Boichat',
 'nicolas:dupeux.net' => 'Nicolas Dupeux',
+'nigel.croxon:hp.com' => 'Nigel Croxon',
 'nikai:nikai.net' => 'Nicolas Kaiser',
 'nikita:namesys.com' => 'Nikita Danilov',
 'nikkne:hotpop.com' => 'Nikola Knezevic',
@@ -1679,6 +1766,7 @@
 'obelix123:toughguy.net' => 'Raj',		# Hmm..
 'obi:saftware.de' => 'Andreas Oberritter',
 'od:suse.de' => 'Olaf Dabrunz',
+'oe:port.de' => 'Heinz-Juergen Oertel',
 'ogasawara:osdl.org' => 'Leann Ogasawara',
 'okir:suse.de' => 'Olaf Kirch', # lbdb
 'okurth:gmx.net' => 'Oliver Kurth',
@@ -1703,6 +1791,7 @@
 'ossi:kde.org' => 'Oswald Buddenhagen',
 'osst:riede.org' => 'Willem Riede',
 'otaylor:redhat.com' => 'Owen Taylor',
+'otte:gnome.org' => 'Benjamin Otte',
 'ouellettes:videotron.ca' => 'Stephane Ouellette',
 'overby:sgi.com' => 'Glen Overby',
 'oxymoron:waste.org' => 'Oliver Xymoron',
@@ -1731,6 +1820,7 @@
 'paul+nospam:wurtel.net' => 'Paul Slootman',
 'paul.clements:steeleye.com' => 'Paul Clements',
 'paul.focke:pandora.be' => 'Paul Focke',
+'paul.mundt:nokia.com' => 'Paul Mundt',
 'paul.mundt:timesys.com' => 'Paul Mundt', # google
 'paul:allied-universal.com' => 'Paul King',
 'paul:kungfoocoder.org' => 'Paul Wagland', # lbdb
@@ -1762,6 +1852,7 @@
 'pe1rxq:amsat.org' => 'Jeroen Vreeken',
 'pebl:math.ku.dk' => 'Peter Berg Larsen',
 'pee:erkkila.org' => 'Paul E. Erkkila',
+'pekon:fi.muni.cz' => 'Petr Konecny',
 'pekon:informatics.muni.cz' => 'Petr Konecny',
 'pelle:dsv.su.se' => 'Per Olofsson',
 'penberg:cs.helsinki.fi' => 'Pekka Enberg',
@@ -1777,8 +1868,12 @@
 'peter.oberparleiter:de.ibm.com' => 'Peter Oberparleiter',
 'peter:bergner.org' => 'Peter Bergner',
 'peter:cadcamlab.org' => 'Peter Samuelson',
+'peter:christensen' => 'Peter Christensen',
 'peter:chubb.wattle.id.au' => 'Peter Chubb',
+'peter:developers.dk' => 'Peter Christensen',
 'peter:pantasys.com' => 'Peter Buckingham',
+'peter_pregler:email.com' => 'Peter Pregler',
+'peterc:au.rmk.(none)' => 'Peter Chubb',
 'peterc:chubb.wattle.id.au' => 'Peter Chubb',
 'peterc:gelato.unsw.edu.au' => 'Peter Chubb',
 'peterm:redhat.com' => 'Peter Martuccelli',
@@ -1793,10 +1888,11 @@
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
@@ -1805,6 +1901,7 @@
 'phil:ipom.com' => 'Phil Dibowitz',
 'philipc:snapgear.com' => 'Philip Craig',
 'philipp:void.at' => 'Philipp Friedrich',
+'philippe.bertin:pandora.be' => 'Philippe Bertin',
 'phillim2:comcast.net' => 'Mike Phillips',
 'phillips:arcor.de' => 'Daniel Phillips',
 'piggin:cyberone.com.au' => 'Nick Piggin',
@@ -1818,6 +1915,7 @@
 'plars:austin.ibm.com' => 'Paul Larson',
 'plars:linuxtestproject.org' => 'Paul Larson',
 'plcl:telefonica.net' => 'Pedro Lopez-Cabanillas',
+'pluto:ds14.agh.edu.pl' => 'Pawel Sikora',
 'pluto:pld-linux.org' => 'Pawel Sikora',
 'pmanolov:lnxw.com' => 'Petko Manolov',
 'pmarques:grupopie.com' => 'Paulo Marques',
@@ -1846,6 +1944,7 @@
 'ptiedem:de.ibm.com' => 'Peter Tiedemann',
 'purna:jcom.home.ne.jp' => 'Yusuf Wilajati Purna',
 'pwaechtler:mac.com' => 'Peter Wächtler',
+'pwil3058:bigpond.net.au' => 'Peter Williams',
 'pzad:pobox.sk' => 'Peter Zubaj',
 'q:kampsax.dtu.dk' => 'Dennis Jørgensen',
 'qboosh:pld-linux.org' => 'Jakub Bogusz',
@@ -1877,6 +1976,7 @@
 'rbradetich:uswest.net' => 'Ryan Bradetich',
 'rbt:mtlb.co.uk' => 'Robert Cardell',
 'rbultje:ronald.bitfreak.net' => 'Ronald Bultje',
+'rco3:2005dauphin.org' => 'Robert C. Olsen, III',
 'rct:gherkin.frus.com' => 'Bob Tracy',
 'rddunlap:org.rmk.(none)' => 'Randy Dunlap',
 'rddunlap:osdl.org' => 'Randy Dunlap',
@@ -1914,6 +2014,7 @@
 'rmk-pci:arm.linux.org.uk' => 'Russell King',
 'rmk:arm.linux.org.uk' => 'Russell King',
 'rmk:flint.arm.linux.org.uk' => 'Russell King',
+'rml:novell.com' => 'Robert Love',
 'rml:tech9.net' => 'Robert Love',
 'rml:ximian.com' => 'Robert Love',
 'rnp:paradise.net.nz' => 'Richard Procter',
@@ -1948,6 +2049,7 @@
 'ross:datscreative.com.au' => 'Ross Dickson',
 'rostedt:goodmis.org' => 'Steven Rostedt',
 'rover:tob.ru' => 'Sergei Golod',
+'rpjday:mindspring.com' => 'Robert P. J. Day',
 'rread:clusterfs.com' => 'Robert Read',
 'rsa:us.ibm.com' => 'Ryan S. Arnold',
 'rscott:attbi.com' => 'Rob Scott',
@@ -1967,6 +2069,8 @@
 'rth:twiddle.net' => 'Richard Henderson',
 'rth:vsop.sfbay.redhat.com' => 'Richard Henderson',
 'rtjohnso:eecs.berkeley.edu' => 'Robert T. Johnson',
+'ruben:ugr.es' => 'Ruben Garcia',
+'ruber:engr.es' => 'Ruben Garcia',
 'ruby.joker:op.pl' => 'Ruby Joker',
 'rui.sousa:laposte.net' => 'Rui Sousa',
 'runet:innovsys.com' => 'Rune Torgersen',
@@ -1985,6 +2089,7 @@
 'ryan:spitfire.gotdns.org' => 'Ryan Cumming',
 'rz:linux-m68k.org' => 'Richard Zidlicky',
 's.doyon:videotron.ca' => 'Stéphane Doyon',
+'s.esser:e-matters.de' => 'Stefan Esser',
 'sabala:students.uiuc.edu' => 'Michal Sabala', # google
 'saidi:umich.edu' => 'Ali Saidi',
 'sailer:scs.ch' => 'Thomas Sailer',
@@ -1996,6 +2101,7 @@
 'samuel.thibault:fnac.net' => 'Samuel Thibault', # lbdb
 'samuel:ibrium.se' => 'Samuel Rydh',
 'sandeen:sgi.com' => 'Eric Sandeen',
+'sanders:mvista.com' => 'Scott Anderson',
 'santiago:newphoenix.net' => 'Santiago A. Nullo', # sent by self
 'santil:us.ibm.com' => 'Santiago Leon',
 'sarolaht:cs.helsinki.fi' => 'Pasi Sarolahti',
@@ -2039,6 +2145,7 @@
 'sezero:superonline.com' => 'Özkan Sezer',
 'sezeroz:ttnet.net.tr' => 'Özkan Sezer',
 'sfbest:us.ibm.com' => 'Steve Best',
+'sfeldma:pobox.com' => 'Scott Feldman',
 'sfr:au1.ibm.com' => 'Stephen Rothwell',
 'sfr:canb.auug.org.au' => 'Stephen Rothwell',
 'sfrench:us.ibm.com' => 'Steve French',
@@ -2066,6 +2173,7 @@
 'siegfried.hildebrand:fernuni-hagen.de' => 'Siegfried Hildebrand',
 'silicon:falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
 'simcha:chatka.org' => 'Jan Topinski',
+'simon.derr:bull.net' => 'Simon Derr',
 'simon:instant802.com' => 'Simon Barber',
 'simon:thekelleys.org.uk' => 'Simon Kelley',
 'simonb:lipsyncpost.co.uk' => 'Simon Burley',
@@ -2089,7 +2197,10 @@
 'sojka:planetarium.cz' => 'Michal Sojka',
 'solar:openwall.com' => 'Solar Designer',
 'solca:guug.org' => 'Otto Solares',
+'solt2:dns.toxicfilms.tv' => 'Maciej Soltysiak',
 'solt:dns.toxicfilms.tv' => 'Maciej Soltysiak',
+'songqf9:yahoo.ca' => 'Alex Song',
+'sonic_amiga:rambler.ru' => 'Pavel Fedin',
 'sonny:burdell.org' => 'Sonny Rao',
 'soruk:eridani.co.uk' => 'Michael McConnell',
 'sparclinux:abeckmann.de' => 'Andreas Beckmann',
@@ -2119,6 +2230,7 @@
 'stekloff:w-stekloff.beaverton.ibm.com' => 'Daniel Stekloff',
 'stelian.pop:fr.alcove.com' => 'Stelian Pop',
 'stelian:popies.net' => 'Stelian Pop',
+'stephan.walter:epfl.ch' => 'Stephan Walter',
 'stephane.galles:free.fr' => 'Stephane Galles', # guessed
 'stephanm:muc.de' => 'Stephan Maciej',
 'stephen:phynp6.phy-astr.gsu.edu' => 'Stephen Leonard',
@@ -2158,11 +2270,14 @@
 'sunil.saxena:intel.com' => 'Sunil Saxena',
 'suparna:in.ibm.com' => 'Suparna Bhattacharya',
 'suresh.b.siddha:intel.com' => 'Suresh B. Siddha',
+'suresh.krishnan:ericsson.ca' => 'Suresh Krishnan',
 'sv:sw.com.sg' => 'Vladimir Simonov',
 'svm:kozmix.org' => 'Sander van Malssen',
 'swanson:uklinux.net' => 'Alan Swanson',
 'swiergot:intersec.pl' => 'Jaroslaw Swierczynski',
 'sxking:qwest.net' => 'Steven King',
+'sylvain.meyer:worldonline.fr' => 'Sylvain Meyer',
+'syrjala:sci.fi' => 'Ville Syrjala',
 'szepe:pinerecords.com' => 'Tomas Szepe',
 'sziwan:hell.org.pl' => 'Karol Kozimor',
 'szuk:telusplanet.net' => 'Scott Zuk',
@@ -2176,6 +2291,7 @@
 'takamiya:po.ntts.co.jp' => 'Noriaki Takamiya',
 'takata.hirokazu:renesas.com' => 'Hirokazu Takata',
 'takata:linux-m32r.org' => 'Hirokazu Takata',
+'tali:admingilde.org' => 'Martin Waitz',
 'tao:acc.umu.se' => 'David Weinehall', # by himself
 'tao:kernel.org' => 'David Weinehall', # by himself
 'tapio:iptime.fi' => 'Tapio Laxström',
@@ -2183,6 +2299,7 @@
 'tausq:debian.org' => 'Randolph Chung',
 'tcallawa:redhat.com' => "Tom 'spot' Callaway",
 'tchen:on-go.com' => 'Thomas Chen',
+'teanropo:cc.jyu.fi' => 'Tero Roponen',
 'tejohnson:yahoo.com' => 'Todd E. Johnson',
 'tes:sgi.com' => 'Timothy Shimmin',
 'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
@@ -2230,6 +2347,7 @@
 'tmolina:cox.net' => 'Thomas Molina',
 'tnt:246tnt-laptop.lan.ayanami.246tnt.com' => 'Sylvain Munaut',
 'tnt:246tnt.com' => 'Sylvain Munaut',
+'tobias.lorenz:gmx.net' => 'Tobias Lorenz',
 'tol:stacken.kth.se' => 'Tomas Olsson',
 'tom.l.nguyen:intel.com' => 'Tom L. Nguyen',
 'tomd:csds.uidaho.edu' => 'Thomas DuBuisson',
@@ -2281,9 +2399,11 @@
 'u233:shaw.ca' => 'Trent Whaley',
 'uaca:alumni.uv.es' => 'Ulisses Alonso Camaró',
 'umka:namesys.com' => 'Yury Umanets',
+'ungod:developers.dk' => 'Peter Christensen',
 'urban.widmark:enlight.net' => 'Urban Widmark',
 'urban:teststation.com' => 'Urban Widmark',
 'uros:kss-loka.si' => 'Uros Bizjak',
+'util:deuroconsult.ro' => 'Catalin Boie',
 'utz.bacher:de.ibm.com' => 'Utz Bacher',
 'uwe.bugla:gmx.de' => 'Uwe Bugla',
 'uwe.koziolek:gmx.net' => 'Uwe Koziolek',
@@ -2313,6 +2433,7 @@
 'viro:parcelfarce.linux.org.uk' => 'Alexander Viro',
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'viro:www.linux.org.uk' => 'Alexander Viro',
+'vladimir.grouzdev:jaluna.com' => 'Vladimir Grouzdev',
 'vmlinuz386:yahoo.com.ar' => 'Gerardo Exequiel Pozzi', # lbdb
 'vnourval:tcs.hut.fi' => 'Ville Nuorvala',		# Can't spell his own login?
 'vnuorval:tcs.hut.fi' => 'Ville Nuorvala',
@@ -2370,6 +2491,7 @@
 'wolfgang:iksw-muees.de' => 'Wolfgang Muees',
 'wolfgang:top.mynetix.de' => 'Wolfgang Mauerer',
 'woody:org.rmk.(none)' => 'Woody Suwalski',
+'wouter-kernel:fort-knox.rave.org' => 'Wouter Van Hemel',
 'wriede:riede.org' => 'Willem Riede',
 'wrlk:riede.org' => 'Willem Riede',
 'wstinson:infonie.fr' => 'William Stinson',
@@ -2401,6 +2523,7 @@
 'yuvalt:gmail.com' => 'Yuval Turgeman',
 'zach:vmware.com' => 'Zachary Amsden',
 'zaitcev:redhat.com' => 'Pete Zaitcev',
+'zaitcev:yahoo.com' => 'Pete Zaitcev',
 'zap:homelink.ru' => 'Andrew Zabolotny',
 'zap:ru.rmk.(none)' => 'Andrew Zabolotny',
 'zdzichu:irc.pl' => 'Tomasz Torcz',
@@ -2411,6 +2534,7 @@
 'zippel:linux-m68k.org' => 'Roman Zippel',
 'zli4:cs.uiuc.edu' => 'Zhenmin Li',
 'zubarev:us.ibm.com' => 'Irene Zubarev', # google
+'zupae234:yahoo.co.jp' => 'Naoki Shibata',
 'zw:superlucidity.net' => 'Zach Welch',
 'zwane:arm.linux.org.uk' => 'Zwane Mwaikambo',
 'zwane:commfireservices.com' => 'Zwane Mwaikambo',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
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

