Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbUKIIpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbUKIIpn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 03:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbUKIIpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 03:45:42 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:62353 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261447AbUKIInR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 03:43:17 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.326
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue,_09_Nov_2004_08_43_10_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20041109084310.8DC47D77E4@merlin.emma.line.org>
Date: Tue,  9 Nov 2004 09:43:10 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.326 has been released.

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
revision 0.326
date: 2004/11/09 08:42:04;  author: emma;  state: Exp;  lines: +75 -1
124 new addresses merged back from BK into CVS
----------------------------
revision 0.325
date: 2004/10/21 22:39:50;  author: emma;  state: Exp;  lines: +53 -3
vita: 50 new addresses
ma: Correct Petri T. Koistinen's name.
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.325
retrieving revision 0.326
diff -u -U2 -r0.325 -r0.326
--- lk-changelog.pl	21 Oct 2004 22:39:50 -0000	0.325
+++ lk-changelog.pl	9 Nov 2004 08:42:04 -0000	0.326
@@ -9,5 +9,5 @@
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.325 2004/10/21 22:39:50 emma Exp $
+# $Id: lk-changelog.pl,v 0.326 2004/11/09 08:42:04 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
@@ -199,4 +199,5 @@
 'ahaas:airmail.net' => 'Art Haas',
 'ahaas:neosoft.com' => 'Art Haas',
+'ahendry:tusc.com.au' => 'Andrew Hendry',
 'aherrman:de.ibm.com' => 'Andreas Herrmann',
 'ahu:ds9a.nl' => 'Bert Hubert',
@@ -242,4 +243,5 @@
 'alborchers:steinerpoint.com' => 'Al Borchers',
 'alessandro.zummo:towertech.it' => 'Alessandro Zummo',
+'alex.kiernan:gmail.com' => 'Alex Kiernan',
 'alex.williamson:com.rmk.(none)' => 'Alex Williamson',
 'alex.williamson:hp.com' => 'Alex Williamson',
@@ -317,5 +319,9 @@
 'arief_m_utama:telkomsel.co.id' => 'Arief Mulya Utama',
 'aris:cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
+'arjan:fenrus.demon.nl' => 'Arjan van de Ven',
+'arjan:infradead.org' => 'Arjan van de Ven',
+'arjan:nl.rmk.(none)' => 'Arjan van de Ven',
 'arjan:redhat.com' => 'Arjan van de Ven',
+'arjanv:infradead.org' => 'Arjan van de Ven',
 'arjanv:redhat.com' => 'Arjan van de Ven',
 'armcc2000:com.rmk.(none)' => 'Andre McCurdy',
@@ -327,4 +333,5 @@
 'arndb:de.ibm.com' => 'Arnd Bergmann',
 'arndt:lin02384n012.mc.schoenewald.de' => 'Arndt Schoenewald',
+'arnouten:bzzt.net' => 'Arnout Engelen',
 'arubin:atl.lmco.com' => 'Aron Rubin',
 'arun.sharma:intel.com' => 'Arun Sharma',
@@ -399,4 +406,5 @@
 'bero:arklinux.org' => 'Bernhard Rosenkraenzer',
 'bfennema:falcon.csc.calpoly.edu' => 'Ben Fennema',
+'bfg-kernel:blenning.no' => 'Tom Fredrik Blenning Klaussen',
 'bfields:citi.umich.edu' => 'J. Bruce Fields',
 'bfields:fieldses.org' => 'J. Bruce Fields',
@@ -438,4 +446,5 @@
 'brett:bad-sports.com' => 'Brett Pemberton',
 'brewt-linux-kernel:brewt.org' => 'Adrian Yee',
+'brian.haley:hp.com' => 'Brian Haley',
 'brian:rentec.com' => 'Brian Childs',
 'brihall:pcisys.net' => 'Brian Hall', # google
@@ -446,4 +455,5 @@
 'bryan:staidm.org' => 'Bryan Rittmeyer',
 'bryder:paradise.net.nz' => 'Bill Ryder',
+'bstroesser:fujitsu-siemens.com' => 'Bodo Stroesser',
 'buffer:antifork.org' => 'Angelo Dell\'Aera',
 'bugfixer:list.ru' => 'Nick Orlov',
@@ -585,4 +595,5 @@
 'dan.zink:hp.com' => 'Dan Zink',
 'dan:debian.org' => 'Daniel Jacobowitz',
+'dan:embeddededge.com' => 'Dan Malek',
 'dan:geefour.netx4.com' => 'Dan Malek',
 'dan:reactivated.net' => 'Daniel Drake',
@@ -626,4 +637,5 @@
 'david:csse.uwa.edu.au' => 'David Glance',
 'david:gibson.dropbear.id.au' => 'David Gibson',
+'david:panzer.utcluj.ro' => 'David Lazar',
 'david_jeffery:adaptec.com' => 'David Jeffery',
 'davidel:xmailserver.org' => 'Davide Libenzi',
@@ -665,4 +677,5 @@
 'dhylands:com.rmk.(none)' => 'Dave Hylands',
 'diegocg:teleline.es' => 'Diego Calleja García',
+'dignome:gmail.com' => 'Lonnie Mendez',
 'dilinger:mp3revolution.net' => 'Andres Salomon',
 'dilinger:voxel.net' => 'Andres Salomon',
@@ -721,4 +734,5 @@
 'duncan:sun.com' => 'Duncan Laurie',
 'duwe:suse.de' => 'Torsten Duwe',
+'dvhltc:us.ibm.com' => 'Darren Hart',
 'dvrabel:arcom.com' => 'David Vrabel',
 'dvrabel:com.rmk.(none)' => 'David Vrabel',
@@ -726,4 +740,5 @@
 'dwg:au.ibm.com' => 'David Gibson',
 'dwg:au1.ibm.com' => 'David Gibson',
+'dwm:austin.ibm.com' => 'Doug Maxey',
 'dwmw2:dwmw2.baythorne.internal' => 'David Woodhouse',
 'dwmw2:infradead.org' => 'David Woodhouse',
@@ -750,4 +765,5 @@
 'egmont:uhulinux.hu' => 'Egmont Koblinger',
 'ehabkost:conectiva.com.br' => 'Eduardo Pereira Habkost',
+'ehrhardt:mathematik.uni-ulm.de' => 'Christian Ehrhardt',
 'eich:suse.de' => 'Egbert Eich',
 'eike-hotplug:sf-tec.de' => 'Rolf Eike Beer',
@@ -851,4 +867,5 @@
 'galak:blarg.somerset.sps.mot.com' => 'Kumar Gala',
 'galak:somerset.sps.mot.com' => 'Kumar Gala',
+'gamal:alternex.com.br' => 'Haroldo Gamal',
 'ganadist:nakyup.mizi.com' => 'Cha Young-Ho',
 'gandalf:netfilter.org' => 'Martin Josefsson',
@@ -874,4 +891,5 @@
 'gerg:moreton.com.au' => 'Greg Ungerer',
 'gerg:snapgear.com' => 'Greg Ungerer',
+'gerg:uclinux.org' => 'Greg Ungerer',
 'ghoward:sgi.com' => 'Greg Howard',
 'ghoz:sympatico.ca' => 'Ghozlane Toumi',
@@ -918,4 +936,5 @@
 'gtoumi:laposte.net' => 'Ghozlane Toumi',
 'gtw:cs.bu.edu' => 'Gary Wong',
+'guido.barzini:com.rmk.(none)' => 'Guido Barzini',
 'guillaume.thouvenin:bull.net' => 'Guillaume Thouvenin',
 'guillaume:morinfr.org' => 'Guillaume Morin',
@@ -958,4 +977,5 @@
 'helgaas:fc.hp.com' => 'Bjorn Helgaas', # doesn't want ø/å
 'helgaas:hp.com' => 'Bjorn Helgaas', # guessed
+'helmut:helios.de' => 'Helmut Tschemernjak',
 'henk:god.dyndns.org' => 'Henk Vergonet',
 'henning:meier-geinitz.de' => 'Henning Meier-Geinitz',
@@ -976,6 +996,8 @@
 'hjl:lucon.org' => 'H. J. Lu',
 'hjm:redhat.com' => 'Heinz Mauelshagen', # lbdb
+'hno:marasystems.com' => 'Henrik Nordstrom',
 'hoho:binbash.net' => 'Colin Slater',
 'holger.smolinski:de.ibm.com' => 'Holger Smolinski',
+'holland:loser.net' => 'Shannon Holland',
 'hollis:austin.ibm.com' => 'Hollis Blanchard',
 'hollisb:us.ibm.com' => 'Hollis Blanchard',
@@ -1039,4 +1061,6 @@
 'james.bottomley:steeleye.com' => 'James Bottomley',
 'james.smart:emulex.com' => 'James Smart',
+'james4765:gmail.com' => 'James Nelson',
+'james4765:verizon.net' => 'James Nelson',
 'james:cobaltmountain.com' => 'James Mayer',
 'james:superbug.demon.co.uk' => 'James Courtier-Dutton',
@@ -1056,6 +1080,8 @@
 'janiceg:us.ibm.com' => 'Janice M. Girouard',
 'janitor:at.none.(rmk)' => 'Maximilian Attems',
+'janitor:at.rmk.(none)' => 'Maximilian Attems',
 'janitor:sternwelten.at' => 'Maximilian Attems',
 'jason.davis:unisys.com' => 'Jason Davis',
+'jasonuhl:sgi.com' => 'Jason Uhlenkott',
 'jasper:vs19.net' => 'Jasper Spaans',
 'javaman:katamail.com' => 'Paulo Ornati',
@@ -1143,4 +1169,5 @@
 'jim.hague:acm.org' => 'Jim Hague',
 'jim.houston:attbi.com' => 'Jim Houston',
+'jim.houston:ccur.com' => 'Jim Houston',
 'jim.houston:comcast.net' => 'Jim Houston',
 'jim:hamachi.net' => 'Jim Collette',
@@ -1177,4 +1204,5 @@
 'johann.deneux:laposte.net' => 'Johann Deneux',
 'johannes:erdfelt.com' => 'Johannes Erdfelt',
+'johansen:immunix.com' => 'John Johansen',
 'john.cagle:hp.com' => 'John Cagle',
 'john.l.byrne:hp.com' => 'John L. Byrne',
@@ -1188,4 +1216,5 @@
 'johnrose:austin.ibm.com' => 'John Rose',
 'johnstul:us.ibm.com' => 'John Stultz',
+'jolt:tuxbox.org' => 'Florian Schirmer',
 'jon:ballardtech.com' => 'Jon Neal',
 'jon:focalhost.com' => 'Jon Oberheide',
@@ -1195,4 +1224,5 @@
 'jonas:thornblad.net' => 'Jonas Thornblad',
 'jones:ingate.com' => 'Jones Desougi',
+'jongk:linux-m68k.org' => 'Kars de Jong',
 'jonsmirl:gmail.com' => 'Jon Smirl',
 'jonsmirl:yahoo.com' => 'Jon Smirl',
@@ -1224,4 +1254,5 @@
 'jt:bougret.jpl.hp.com' => 'Jean Tourrilhes',	# jpl? Whaa? hpl!
 'jt:hpl.hp.com' => 'Jean Tourrilhes',
+'jthiessen:penguincomputing.com' => 'Justin Thiessen',
 'jtyner:cs.ucr.edu' => 'John Tyner',
 'judd:jpilot.org' => 'Judd Montgomery',
@@ -1237,6 +1268,8 @@
 'jwoithe:physics.adelaide.edu.au' => 'Jonathan Woithe',
 'k-suganuma:mvj.biglobe.ne.jp' => 'Kimio Suganuma',
+'k.chmielewski:neostrada.pl' => 'Krzysztof Chmielewski',
 'k.kasprzak:box43.pl' => 'Karol Kasprzak', # by Kristian Peters
 'kaber:coreworks.de' => 'Patrick McHardy',
+'kaber:trash.ne' => 'Patrick McHardy', # typo
 'kaber:trash.net' => 'Patrick McHardy',
 'kadlec:blackhole.kfki.hu' => 'Jozsef Kadlecsik',
@@ -1264,4 +1297,5 @@
 'karlis:mt.lv' => 'Karlis Peisenieks',
 'kartik_me:hotmail.com' => 'Kartikey Mahendra Bhatt',
+'kas:fi.muni.cz' => 'Jan Kasprzak',
 'kas:informatics.muni.cz' => 'Jan Kasprzak', # lbdb
 'kasperd:daimi.au.dk' => 'Kasper Dupont',
@@ -1388,4 +1422,5 @@
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
+'liam.girdwood:com.rmk.(none)' => 'Liam Girdwood',
 'liam.girdwood:wolfsonmicro.com' => 'Liam Girdwood',
 'linas:austin.ibm.com' => 'Linas Vepstas',
@@ -1405,4 +1440,5 @@
 'linux:kodeaffe.de' => 'Sebastian Henschel',
 'linux:michaelgeng.de' => 'Michael Geng',
+'linux:rainbow-software.org' => 'Ondrej Zary',
 'linux:sandersweb.net' => 'David Sanders',
 'linux:thorsten-knabe.de' => 'Thorsten Knabe',
@@ -1413,4 +1449,5 @@
 'lionel.bouton:inet6.fr' => 'Lionel Bouton',
 'lists:mdiehl.de' => 'Martin Diehl',
+'lists:wildgooses.com' => 'Ed Wildgoose',
 'livio:ime.usp.br' => 'Livio Baldini Soares',
 'liyang:nerv.cx' => 'Liyang Hu',
@@ -1419,10 +1456,14 @@
 'lkml:lievin.net' => 'Romain Liévin',
 'lkml:mathfillsmewithgreatjoy.com' => 'Michael Plump',
+'lkml:rtr.ca' => 'Mark Lord',
 'lkml:shemesh.biz' => 'Shachar Shemesh',
 'lkml:steffenspage.de' => 'Steffen Zieger',
 'lm:bitmover.com' => 'Larry McVoy',
 'lm:work.bitmover.com' => 'Larry McVoy',
+'lmb:suse.de' => 'Lars Marowsky-Bree',
+'lmendez19:austin.rr.com' => 'Lonnie Mendez',
 'lode_leroy:hotmail.com' => 'Lode Leroy',
 'loftin:ldl.fc.hp.com' => 'Terry Loftin',
+'long.pu:intel.com' => 'Pu Long',
 'lopezp:grupocp.es' => 'Jose A. Lopez',
 'lord:jen.americas.sgi.com' => 'Stephen Lord',
@@ -1435,4 +1476,5 @@
 'louisk:cse.unsw.edu.au' => 'Louis Yu-Kiu Kwan',
 'lowekamp:cs.wm.edu' => 'Bruce B. Lowekamp', # lbdb
+'lsml:rtr.ca' => 'Mark Lord', # typo ?
 'luben:splentec.com' => 'Luben Tuikov',
 'luben_tuikov:adaptec.com' => 'Luben Tuikov',
@@ -1500,4 +1542,5 @@
 'markus.lidel:shadowconnect.com' => 'Markus Lidel',
 'marr:flex.com' => 'Bill Marr',
+'martin-langer:gmx.de' => 'Martin Langer',
 'martin.bene:icomedias.com' => 'Martin Bene',
 'martin.bligh:us.ibm.com' => 'Martin J. Bligh',
@@ -1521,4 +1564,5 @@
 'matthewn:snapgear.com' => 'Matthew Natalier',
 'matthias.andree:gmx.de' => 'Matthias Andree', # added by himself
+'matthias:net.rmk.(none)' => 'Matthias Burghardt',
 'mauelshagen:redhat.com' => 'Heinz J. Mauelshagen',
 'mauelshagen:sistina.com' => 'Heinz J. Mauelshagen',
@@ -1543,4 +1587,5 @@
 'mdharm-scsi:one-eyed-alien.net' => 'Matthew Dharm',
 'mdharm-usb:one-eyed-alien.net' => 'Matthew Dharm',
+'mdharm:momenco.com' => 'Matthew Dharm',
 'mdharm:one-eyed-alien.net' => 'Matthew Dharm',
 'mdiehl:mdiehl.de' => 'Martin Diehl',
@@ -1576,4 +1621,5 @@
 'michal:harddata.com' => 'Michal Jaegermann',
 'michal:logix.cz' => 'Michal Ludvig',
+'michal:rokos.info' => 'Michal Rokos',
 'michal_dobrzynski:mac.com' => 'Michal Dobrzynski',
 'michel.marti:objectxp.com' => 'Michel Marti',
@@ -1624,4 +1670,5 @@
 'mmagallo:debian.org' => 'Marcelo E. Magallon',
 'mmcclell:bigfoot.com' => 'Mark McClelland',
+'mmelchior:xs4all.nl' => 'Matthijs Melchior',
 'mochel:bambi.(none)' => 'Patrick Mochel',
 'mochel:digitalimplant.org' => 'Patrick Mochel',
@@ -1649,4 +1696,5 @@
 'mroos:linux.ee' => 'Meelis Roos',
 'mrr:nexthop.com' => 'Mathew Richardson',
+'mru:inprovide.com' => 'Maans Rullgaard',
 'mru:kth.se' => 'Mans Rullgard',
 'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
@@ -1671,4 +1719,5 @@
 'naveenb:cisco.com' => 'Naveen Burmi', # lbdb
 'nbryant:optonline.net' => 'Nathan Bryant',
+'ncunningham:linuxmail.org' => 'Nigel Cunningham',
 'ncunningham:users.sourceforge.net' => 'Nigel Cunningham',
 'neal:bakerst.org' => 'Neal Stephenson',
@@ -1690,4 +1739,5 @@
 'nicolas:boichat.ch' => 'Nicolas Boichat',
 'nicolas:dupeux.net' => 'Nicolas Dupeux',
+'nigel.croxon:hp.com' => 'Nigel Croxon',
 'nikai:nikai.net' => 'Nicolas Kaiser',
 'nikita:namesys.com' => 'Nikita Danilov',
@@ -1742,4 +1792,5 @@
 'osst:riede.org' => 'Willem Riede',
 'otaylor:redhat.com' => 'Owen Taylor',
+'otte:gnome.org' => 'Benjamin Otte',
 'ouellettes:videotron.ca' => 'Stephane Ouellette',
 'overby:sgi.com' => 'Glen Overby',
@@ -1802,4 +1853,5 @@
 'pebl:math.ku.dk' => 'Peter Berg Larsen',
 'pee:erkkila.org' => 'Paul E. Erkkila',
+'pekon:fi.muni.cz' => 'Petr Konecny',
 'pekon:informatics.muni.cz' => 'Petr Konecny',
 'pelle:dsv.su.se' => 'Per Olofsson',
@@ -1817,6 +1869,10 @@
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
@@ -1846,4 +1902,5 @@
 'philipc:snapgear.com' => 'Philip Craig',
 'philipp:void.at' => 'Philipp Friedrich',
+'philippe.bertin:pandora.be' => 'Philippe Bertin',
 'phillim2:comcast.net' => 'Mike Phillips',
 'phillips:arcor.de' => 'Daniel Phillips',
@@ -1859,4 +1916,5 @@
 'plars:linuxtestproject.org' => 'Paul Larson',
 'plcl:telefonica.net' => 'Pedro Lopez-Cabanillas',
+'pluto:ds14.agh.edu.pl' => 'Pawel Sikora',
 'pluto:pld-linux.org' => 'Pawel Sikora',
 'pmanolov:lnxw.com' => 'Petko Manolov',
@@ -1919,4 +1977,5 @@
 'rbt:mtlb.co.uk' => 'Robert Cardell',
 'rbultje:ronald.bitfreak.net' => 'Ronald Bultje',
+'rco3:2005dauphin.org' => 'Robert C. Olsen, III',
 'rct:gherkin.frus.com' => 'Bob Tracy',
 'rddunlap:org.rmk.(none)' => 'Randy Dunlap',
@@ -1991,4 +2050,5 @@
 'rostedt:goodmis.org' => 'Steven Rostedt',
 'rover:tob.ru' => 'Sergei Golod',
+'rpjday:mindspring.com' => 'Robert P. J. Day',
 'rread:clusterfs.com' => 'Robert Read',
 'rsa:us.ibm.com' => 'Ryan S. Arnold',
@@ -2011,4 +2071,5 @@
 'rtjohnso:eecs.berkeley.edu' => 'Robert T. Johnson',
 'ruben:ugr.es' => 'Ruben Garcia',
+'ruber:engr.es' => 'Ruben Garcia',
 'ruby.joker:op.pl' => 'Ruby Joker',
 'rui.sousa:laposte.net' => 'Rui Sousa',
@@ -2029,4 +2090,5 @@
 'rz:linux-m68k.org' => 'Richard Zidlicky',
 's.doyon:videotron.ca' => 'Stéphane Doyon',
+'s.esser:e-matters.de' => 'Stefan Esser',
 'sabala:students.uiuc.edu' => 'Michal Sabala', # google
 'saidi:umich.edu' => 'Ali Saidi',
@@ -2040,4 +2102,5 @@
 'samuel:ibrium.se' => 'Samuel Rydh',
 'sandeen:sgi.com' => 'Eric Sandeen',
+'sanders:mvista.com' => 'Scott Anderson',
 'santiago:newphoenix.net' => 'Santiago A. Nullo', # sent by self
 'santil:us.ibm.com' => 'Santiago Leon',
@@ -2083,4 +2146,5 @@
 'sezeroz:ttnet.net.tr' => 'Özkan Sezer',
 'sfbest:us.ibm.com' => 'Steve Best',
+'sfeldma:pobox.com' => 'Scott Feldman',
 'sfr:au1.ibm.com' => 'Stephen Rothwell',
 'sfr:canb.auug.org.au' => 'Stephen Rothwell',
@@ -2110,4 +2174,5 @@
 'silicon:falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
 'simcha:chatka.org' => 'Jan Topinski',
+'simon.derr:bull.net' => 'Simon Derr',
 'simon:instant802.com' => 'Simon Barber',
 'simon:thekelleys.org.uk' => 'Simon Kelley',
@@ -2136,4 +2201,5 @@
 'solt:dns.toxicfilms.tv' => 'Maciej Soltysiak',
 'songqf9:yahoo.ca' => 'Alex Song',
+'sonic_amiga:rambler.ru' => 'Pavel Fedin',
 'sonny:burdell.org' => 'Sonny Rao',
 'soruk:eridani.co.uk' => 'Michael McConnell',
@@ -2205,4 +2271,5 @@
 'suparna:in.ibm.com' => 'Suparna Bhattacharya',
 'suresh.b.siddha:intel.com' => 'Suresh B. Siddha',
+'suresh.krishnan:ericsson.ca' => 'Suresh Krishnan',
 'sv:sw.com.sg' => 'Vladimir Simonov',
 'svm:kozmix.org' => 'Sander van Malssen',
@@ -2210,4 +2277,6 @@
 'swiergot:intersec.pl' => 'Jaroslaw Swierczynski',
 'sxking:qwest.net' => 'Steven King',
+'sylvain.meyer:worldonline.fr' => 'Sylvain Meyer',
+'syrjala:sci.fi' => 'Ville Syrjala',
 'szepe:pinerecords.com' => 'Tomas Szepe',
 'sziwan:hell.org.pl' => 'Karol Kozimor',
@@ -2223,4 +2292,5 @@
 'takata.hirokazu:renesas.com' => 'Hirokazu Takata',
 'takata:linux-m32r.org' => 'Hirokazu Takata',
+'tali:admingilde.org' => 'Martin Waitz',
 'tao:acc.umu.se' => 'David Weinehall', # by himself
 'tao:kernel.org' => 'David Weinehall', # by himself
@@ -2230,4 +2300,5 @@
 'tcallawa:redhat.com' => "Tom 'spot' Callaway",
 'tchen:on-go.com' => 'Thomas Chen',
+'teanropo:cc.jyu.fi' => 'Tero Roponen',
 'tejohnson:yahoo.com' => 'Todd E. Johnson',
 'tes:sgi.com' => 'Timothy Shimmin',
@@ -2277,4 +2348,5 @@
 'tnt:246tnt-laptop.lan.ayanami.246tnt.com' => 'Sylvain Munaut',
 'tnt:246tnt.com' => 'Sylvain Munaut',
+'tobias.lorenz:gmx.net' => 'Tobias Lorenz',
 'tol:stacken.kth.se' => 'Tomas Olsson',
 'tom.l.nguyen:intel.com' => 'Tom L. Nguyen',
@@ -2328,4 +2400,5 @@
 'uaca:alumni.uv.es' => 'Ulisses Alonso Camaró',
 'umka:namesys.com' => 'Yury Umanets',
+'ungod:developers.dk' => 'Peter Christensen',
 'urban.widmark:enlight.net' => 'Urban Widmark',
 'urban:teststation.com' => 'Urban Widmark',
@@ -2462,4 +2535,5 @@
 'zli4:cs.uiuc.edu' => 'Zhenmin Li',
 'zubarev:us.ibm.com' => 'Irene Zubarev', # google
+'zupae234:yahoo.co.jp' => 'Naoki Shibata',
 'zw:superlucidity.net' => 'Zach Welch',
 'zwane:arm.linux.org.uk' => 'Zwane Mwaikambo',

