Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbULBLMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbULBLMl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 06:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbULBLMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 06:12:41 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:9930 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261580AbULBLLC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 06:11:02 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: lk-changelog.pl 0.327
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu,_02_Dec_2004_11_10_54_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20041202111054.5116D959D6@merlin.emma.line.org>
Date: Thu,  2 Dec 2004 12:10:54 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a semi-automatic announcement.

lk-changelog.pl aka. shortlog version 0.327 has been released.

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
revision 0.327
date: 2004/12/02 11:10:20;  author: emma;  state: Exp;  lines: +68 -6
synch up CVS <-> BK
----------------------------
revision 0.326
date: 2004/11/09 08:42:04;  author: emma;  state: Exp;  lines: +75 -1
124 new addresses merged back from BK into CVS
=============================================================================
Index: lk-changelog.pl
===================================================================
RCS file: /var/CVS/lk-changelog/lk-changelog.pl,v
retrieving revision 0.326
retrieving revision 0.327
diff -u -U2 -r0.326 -r0.327
--- lk-changelog.pl	9 Nov 2004 08:42:04 -0000	0.326
+++ lk-changelog.pl	2 Dec 2004 11:10:20 -0000	0.327
@@ -9,5 +9,5 @@
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.326 2004/11/09 08:42:04 emma Exp $
+# $Id: lk-changelog.pl,v 0.327 2004/12/02 11:10:20 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
@@ -147,4 +147,5 @@
 'a.othieno:bluewin.ch' => 'Arthur Othieno',
 'a.othieno:ch.rmk.(none)' => 'Arthur Othieno',
+'a.pugachev:pcs-net.net' => 'Anatoly Pugachev',
 'a.wegele:tu-bs.de' => 'Artur Wegele',
 'a1tmblwd:netscape.net' => 'Kam Leo',
@@ -243,4 +244,5 @@
 'alborchers:steinerpoint.com' => 'Al Borchers',
 'alessandro.zummo:towertech.it' => 'Alessandro Zummo',
+'alex.kern:gmx.de' => 'Alexander Kern',
 'alex.kiernan:gmail.com' => 'Alex Kiernan',
 'alex.williamson:com.rmk.(none)' => 'Alex Williamson',
@@ -255,4 +257,5 @@
 'alex_williamson:com.rmk.(none)' => 'Alex Williamson',
 'alex_williamson:hp.com' => 'Alex Williamson', # google
+'alexander.kern:siemens.com' => 'Alexander Kern',
 'alexander.riesen:synopsys.com' => 'Alexander Riesen',
 'alexander.schulz:com.rmk.(none)' => 'Alexander Schulz',
@@ -260,5 +263,7 @@
 'alexander.stohr:gmx.de' => 'Alexander Stohr',
 'alexander:all-2.com' => 'Alexander Oltu',
+'alexey.y.starikovskiy:intel.com' => 'Alexey Y. Starikovskiy',
 'alexey:technomagesinc.com' => 'Alex Tomas',
+'alexn:dsv.su.se' => 'Alexander Nyberg',
 'alext:fc.hp.com' => 'Alex Tsariounov',
 'alfre:ibd.es' => 'Alfredo Sanjuán',
@@ -288,8 +293,10 @@
 'andrej.filipcic:ijs.si' => 'Andrej Filipcic',
 'andrew.grover:intel.com' => 'Andy Grover', # "Andy" to match former entries
+'andrew.patterson:hp.com' => 'Andrew Patterson',
 'andrew.vasquez:qlogic.com' => 'Andrew Vasquez',
 'andrew.wood:ivarch.com' => 'Andrew Wood',
 'andrew:com.rmk.(none)' => 'Andrew Victor', # double-check
 'andrew:lunn.ch' => 'Andrew Lunn',
+'andrew:walrond.org' => 'Andrew Walrond',
 'andries.brouwer:cwi.nl' => 'Andries E. Brouwer',
 'andros:citi.umich.edu' => 'Andy Adamson',
@@ -327,4 +334,5 @@
 'armcc2000:com.rmk.(none)' => 'Andre McCurdy',
 'armcc2000:yahoo.com' => 'Andre McCurdy',
+'armijn:uulug.nl' => 'Armijn Hemel',
 'armin:melware.de' => 'Armin Schindler',
 'arnaud.quette:mgeups.com' => 'Arnaud Quette',
@@ -355,5 +363,7 @@
 'augustus:linuxhardware.org' => 'Kris Kersey',
 'aurelien:aurel32.net' => 'Aurelien Jarno', # lbdb
+'avi:argo.co.il' => 'Avi Kivity',
 'aviro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
+'avvisi:spalletti.it' => 'Iacopo Spalletti',
 'awagger:web.de' => 'Axel Waggershauser',
 'axboe:burns.home.kernel.dk' => 'Jens Axboe', # guessed
@@ -445,4 +455,5 @@
 'brazilnut:us.ibm.com' => 'Don Fry',
 'brett:bad-sports.com' => 'Brett Pemberton',
+'breuerr:mc.net' => 'Bob Breuer',
 'brewt-linux-kernel:brewt.org' => 'Adrian Yee',
 'brian.haley:hp.com' => 'Brian Haley',
@@ -483,4 +494,5 @@
 'cannam:all-day-breakfast.com' => 'Chris Cannam',
 'car.busse:gmx.de' => 'Carsten Busse',	# verified by Greg KH
+'carlo:linux.it' => 'Carlo Perassi',
 'castet.matthieu:free.fr' => 'Matthieu Castet',
 'castor:3pardata.com' => 'Castor Fu',
@@ -517,4 +529,5 @@
 'chris:heathens.co.nz' => 'Chris Heath',
 'chris:onestepahead.de' => 'Christian Meder',
+'chris:osdl.org' => 'Chris Wright',
 'chris:qwirx.com' => 'Chris Wilson',
 'chris:wirex.com' => 'Chris Wright',
@@ -550,4 +563,5 @@
 'cobra:compuserve.com' => 'Kevin Brosius',
 'cohuck:de.ibm.com' => 'Cornelia Huck',
+'colin.lkml:colino.net' => 'Colin Leroy',
 'colin:colino.net' => 'Colin Leroy',
 'colin:gibbs.dhs.org' => 'Colin Gibbs',
@@ -657,4 +671,5 @@
 'debian:abeckmann.de' => 'Andreas Beckmann',
 'debian:sternwelten.at' => 'Maximilian Attems',
+'dedekind:infradead.org' => 'Artem Bityuckiy',
 'deepfire:sic-elvis.zel.ru' => 'Samium Gromoff',
 'defouwj:purdue.edu' => 'Jeff DeFouw',
@@ -670,4 +685,5 @@
 'devik:cdi.cz' => 'Martin Devera',
 'dfages:arkoon.net' => 'Daniel Fages',
+'dfries:mail.win.org' => 'David Fries',
 'dgibson:samba.org' => 'David Gibson',
 'dhinds:sonic.net' => 'David Hinds', # google
@@ -686,4 +702,5 @@
 'dirk.behme:de.bosch.com' => 'Dirk Behme',
 'dirk.uffmann:nokia.com' => 'Dirk Uffmann',
+'dkrivoschokov:dev.rtsoft.ru' => 'Dmitry Krivoschokov',
 'dkuhlen:fhm.edu' => 'Dominik Kuhlen',
 'dl8bcu:dl8bcu.de' => 'Thorsten Kranzkowski',
@@ -747,4 +764,5 @@
 'dz:cs.unitn.it' => 'Massimo Dal Zotto',
 'ebiederm:xmission.com' => 'Eric W. Biederman',
+'ebrower:gmail.com' => 'Eric Brower',
 'ebrower:resilience.com' => 'Eric Brower',
 'ebrower:usa.net' => 'Eric Brower',
@@ -757,6 +775,8 @@
 'edrossma:us.ibm.com' => 'Eric Rossman',
 'edv:macrolink.com' => 'Ed Vance',
+'edward_peng:alphanetworks.com' => 'Edward Peng',
 'edward_peng:dlink.com.tw' => 'Edward Peng',
 'edwardsg:sgi.com' => 'Greg Edwards', # google
+'efalk:google.com' => 'Edward Falk',
 'efocht:ess.nec.de' => 'Erich Focht',
 'egallego:telefonica.net' => 'Emilio Gallego Arias',
@@ -899,4 +919,5 @@
 'giri:lmc.cs.sunysb.edu' => 'Giridhar Pemmasani',
 'giuseppe.furlan:systeam.it' => 'Giuseppe Furlan',
+'giuseppe:eppesuigoccas.homedns.org' => 'Giuseppe Sacco',
 'gj:pointblue.com.pl' => 'Grzegorz Jaskiewicz',
 'gjaeger:sysgo.com' => 'Gerhard Jaeger',
@@ -912,4 +933,5 @@
 'gnb:melbourne.sgi.com' => 'Greg Banks',
 'gnb:sgi.com' => 'Greg Banks',
+'gniibe:fsij.org' => 'Niibe Yutaka',
 'go:turbolinux.co.jp' => 'Go Taniguchi',
 'gone:us.ibm.com' => 'Patricia Gaughen',
@@ -1021,4 +1043,5 @@
 'i:stingr.net' => 'Paul P. Komkoff Jr.',
 'ian.abbott:mev.co.uk' => 'Ian Abbott',
+'ian.pratt:cl.cam.ac.uk' => 'Ian Pratt',
 'ianw:gelato.unsw.edu.au' => 'Ian Wienand', # lbdb
 'ica2_ts:csv.ica.uni-stuttgart.de' => 'Thiemo Seufer', # google
@@ -1106,4 +1129,5 @@
 'jdike:karaya.com' => 'Jeff Dike',
 'jdike:uml.karaya.com' => 'Jeff Dike',
+'jdittmer:ppp0.net' => 'Jan Dittmer',
 'jdow:earthlink.net' => 'Joanne Dow',
 'jdr:farfalle.com' => 'David Ruggiero',
@@ -1257,4 +1281,5 @@
 'jtyner:cs.ucr.edu' => 'John Tyner',
 'judd:jpilot.org' => 'Judd Montgomery',
+'juerg:paldo.org' => 'Juerg Billeter',
 'juergen:jstuber.net' => 'Jürgen Stuber',
 'juhl-lkml:dif.dk' => 'Jesper Juhl',
@@ -1285,4 +1310,5 @@
 'kaigai:ak.jp.nec.com' => 'KaiGai Kohei',
 'kala:pinerecords.com' => 'Tomas Szepe',
+'kalev:colleduc.ee' => 'Kalev Lember',
 'kalev:smartlink.ee' => 'Kalev Lember',
 'kalin:thinrope.net' => 'Kalin Rumenov Kozhuharov',
@@ -1319,4 +1345,5 @@
 'kernel:kolivas.org' => 'Con Kolivas',
 'kernel:linuxace.com' => 'Phil Oester',
+'kernel:obster.org' => 'Michael Obster',
 'kernel:sayegh.de' => 'Nabil Sayegh',
 'kernel:steeleye.com' => 'Paul Clements',
@@ -1361,4 +1388,5 @@
 'knut_petersen:t-online.de' => 'Knut Petersen',
 'kochi:hpc.bs1.fc.nec.co.jp' => 'Kochi Takayoshi',
+'kolrabi:kolrabi.de' => 'Bjoern Paetzel',
 'kolya:mit.edu' => 'Nickolai Zeldovich',
 'komoriya:paken.org' => 'Takeru Komoriya', # google
@@ -1427,4 +1455,5 @@
 'linas:linas.org' => 'Linas Vepstas',
 'linas:us.ibm.com' => 'Linas Vepstas',
+'linux-dev:morknet.de' => 'Steffen A. Mork',
 'linux-kernel:borntraeger.net' => 'Christian Bornträger',
 'linux-kernel:n-dimensional.de' => 'Hans Ulrich Niedermann',
@@ -1463,4 +1492,5 @@
 'lmb:suse.de' => 'Lars Marowsky-Bree',
 'lmendez19:austin.rr.com' => 'Lonnie Mendez',
+'lnville:tuxdriver.com' => 'John W. Linville', # typo
 'lode_leroy:hotmail.com' => 'Lode Leroy',
 'loftin:ldl.fc.hp.com' => 'Terry Loftin',
@@ -1483,4 +1513,5 @@
 'luca:libero.it' => 'Luca Risolia',
 'lucasvr:terra.com.br' => 'Lucas Correia Villa Real', # google
+'luming.yu:intel.com' => 'Luming Yu',
 'lunz:falooley.org' => 'Jason Lunz',
 'luto:myrealbox.com' => 'Andy Lutomirski',
@@ -1499,4 +1530,5 @@
 'macro:linux-mips.org' => 'Maciej W. Rozycki',
 'maeda.naoaki:jp.fujitsu.com' => 'Maeda Naoaki',
+'magnus.damm:gmail.com' => 'Magnus Damm',
 'mahalcro:us.ibm.com' => 'Michael A. Halcrow',
 'mail:de.rmk.(none)' => 'Peter Teichmann',
@@ -1510,8 +1542,10 @@
 'manand:us.ibm.com' => 'Mala Anand',
 'maneesh:in.ibm.com' => 'Maneesh Soni',
+'manfred99:gmx.ch' => 'Manfred Schwarb',
 'manfred:colorfullife.com' => 'Manfred Spraul',
 'manik:cisco.com' => 'Manik Raina',
 'manish:zambeel.com' => 'Manish Lachwani',
 'mannthey:us.ibm.com' => 'Keith Mannthey',
+'marc.leeman:gmail.com' => 'Marc Leeman',
 'marc:mbsi.ca' => 'Marc Boucher',
 'marcel:holtmann.org' => 'Marcel Holtmann', # sent by himself
@@ -1535,4 +1569,5 @@
 'mark:alpha.dyndns.org' => 'Mark W. McClelland',
 'mark:hal9000.dyndns.org' => 'Mark W. McClelland',
+'mark:mtfhpc.demon.co.uk' => 'Mark Fortescue',
 'mark:net.rmk.(none)' => 'Mark Hindley',
 'markb:wetlettuce.com' => 'Mark Broadbent',
@@ -1552,4 +1587,5 @@
 'martin:meltin.net' => 'Martin Schwenke',
 'martine.silbermann:hp.com' => 'Martine Silbermann',
+'masaki-c:nict.go.jp' => 'Masaki Chikama',
 'masanari.iida:hp.com' => 'Masanari Iida', # lbdb
 'masbock:us.ibm.com' => 'Max Asbock',
@@ -1620,4 +1656,5 @@
 'michaelw:foldr.org' => 'Michael Weber', # google
 'michal:harddata.com' => 'Michal Jaegermann',
+'michal:info.rmk.(none)' => 'Michal Rokos',
 'michal:logix.cz' => 'Michal Ludvig',
 'michal:rokos.info' => 'Michal Rokos',
@@ -1652,4 +1689,5 @@
 'mirage:kaotik.org' => 'Tiago Sousa',
 'mita:yacht.ocn.ne.jp' => 'Akinobu Mita',
+'mitch.a.williams:intel.com' => 'Mitch Williams',
 'mitch:sfgoth.com' => 'Mitchell Blank Jr.',
 'miura:da-cha.org' => 'Hiroshi Miura',
@@ -1658,4 +1696,5 @@
 'miyoshi:hpc.bs1.fc.nec.co.jp' => 'Kazuto Miyoshi',
 'mj:ucw.cz' => 'Martin Mares',
+'mjagdis:eris-associates.co.uk' => 'Mike Jagdis',
 'mjc:redhat.com' => 'Mark J. Cox',
 'mk:linux-ipv6.org' => 'Mitsuru Kanda',
@@ -1696,8 +1735,9 @@
 'mroos:linux.ee' => 'Meelis Roos',
 'mrr:nexthop.com' => 'Mathew Richardson',
-'mru:inprovide.com' => 'Maans Rullgaard',
-'mru:kth.se' => 'Mans Rullgard',
+'mru:inprovide.com' => 'Måns Rullgård',
+'mru:kth.se' => 'Måns Rullgård',
 'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
 'msw:redhat.com' => 'Matt Wilson',
+'mtk-lkml:gmx.net' => 'Michael Kerrisk',
 'mufasa:sis.com.tw' => 'Mufasa Yang', # sent by himself
 'muizelaar:rogers.com' => 'Jeff Muizelaar',
@@ -1788,4 +1828,5 @@
 'orjan.friberg:axis.com' => 'Orjan Friberg',
 'ornati:fastwebnet.it' => 'Paolo Ornati',
+'ortylp:3miasto.net' => 'Paul Ortyl',
 'os:emlix.com' => 'Oskar Schirmer', # sent by himself
 'ossi:kde.org' => 'Oswald Buddenhagen',
@@ -1931,4 +1972,5 @@
 'pp:netppl.fi' => 'Pekka Pietikäinen',
 'ppc64:brule.rchland.ibm.com' => 'Peter Bergner',
+'ppopov:embeddedalley.com' => 'Pete Popov',
 'pragnesh.sampat:timesys.com' => 'Pragnesh Sampat',
 'praka:pobox.com' => 'Andrew Vasquez',
@@ -1969,4 +2011,5 @@
 'ranty:ranty.pantax.net' => 'Manuel Estrada Sainz',
 'rask:sygehus.dk' => 'Rask Ingemann Lambertsen',
+'rathamahata:ehouse.ru' => 'Sergey S. Kostyliov',
 'rathamahata:php4.ru' => 'Sergey S. Kostyliov',
 'raul:pleyades.net' => 'Raul Nunez de Arenas Coronado',
@@ -1978,4 +2021,5 @@
 'rbultje:ronald.bitfreak.net' => 'Ronald Bultje',
 'rco3:2005dauphin.org' => 'Robert C. Olsen, III',
+'rct:frus.com' => 'Bob Tracy',
 'rct:gherkin.frus.com' => 'Bob Tracy',
 'rddunlap:org.rmk.(none)' => 'Randy Dunlap',
@@ -2097,4 +2141,5 @@
 'sam:ravnborg.org' => 'Sam Ravnborg',
 'samel:mail.cz' => 'Vitezslav Samel',
+'sameske:de.ibm.com' => 'Volker Sameske',
 'samuel.thibault:ens-lyon.fr' => 'Samuel Thibault',
 'samuel.thibault:ens-lyon.org' => 'Samuel Thibault',
@@ -2113,4 +2158,5 @@
 'scd:broked.org' => 'Steven Dake',
 'schaffner:gmx.li' => 'Martin Schaffner',
+'scheel:vnet.ibm.com' => 'Jeff Scheel',
 'schierlm:gmx.de' => 'Michael Schierl',
 'schlicht:uni-mannheim.de' => 'Thomas Schlichter',
@@ -2134,4 +2180,5 @@
 'sds:epoch.ncsc.mil' => 'Stephen D. Smalley',
 'sds:tislabs.com' => 'Stephen D. Smalley',
+'se.witt:gmx.net' => 'Sebastian Witt',
 'sean.mcgoogan:superh.com' => 'Sean McGoogan',
 'sean:mess.org' => 'Sean Young',
@@ -2220,4 +2267,6 @@
 'sridhar:dyn9-47-18-86.beaverton.ibm.com' => 'Sridhar Samudrala',
 'sridhar:x1-6-00-10-a4-8b-06-f6.attbi.com' => 'Sridhar Samudrala',
+'sriharivijayaraghavan:yahoo.com.au' => 'Srihari Vijayaraghavan',
+'sripathik:in.ibm.com' => 'Sripathi Kodi',
 'srk:thekelleys.org.uk' => 'Simon Kelley',
 'srompf:isg.de' => 'Stefan Rompf',
@@ -2225,4 +2274,5 @@
 'sryoungs:bigpond.net.au' => 'Steve Youngs', # GnuPG key servers
 'stanley.wang:linux.co.intel.com' => 'Stanley Wang',
+'starvik:axis.com' => 'Mikael Starvik',
 'stefan.becker:nokia.com' => 'Stefan Becker',
 'stefan.eletzhofer:eletztrick.de' => 'Stefan Eletzhofer',
@@ -2268,4 +2318,5 @@
 'sullivan:austin.ibm.com' => 'Mike Sullivan',
 'suncobalt.adm:hostme.bitkeeper.com' => 'Tim Hockin', # by Duncan Laurie
+'sundarapandian.duraijai:intel.com' => 'Sundarapandian Durairaj',
 'sunil.saxena:intel.com' => 'Sunil Saxena',
 'suparna:in.ibm.com' => 'Suparna Bhattacharya',
@@ -2312,4 +2363,5 @@
 'thiel:ksan.de' => 'Florian Thiel', # lbdb
 'thockin:freakshow.cobalt.com' => 'Tim Hockin',
+'thockin:google.com' => 'Tim Hockin',
 'thockin:sun.com' => 'Tim Hockin',
 'thoffman:arnor.net' => 'Torrey Hoffman',
@@ -2321,4 +2373,5 @@
 'thomas:horsten.com' => 'Thomas Horsten',
 'thomas:osterried.de' => 'Thomas Osterried',
+'thomas:plx.com' => 'Thomas Leibold',
 'thomas:stewarts.org.uk' => 'Thomas Stewart',
 'thomas:winischhofer.net' => 'Thomas Winischhofer', # whois
@@ -2336,4 +2389,5 @@
 'tim:cambrant.com' => 'Tim Cambrant', # lbdb
 'tim:physik3.uni-rostock.de' => 'Tim Schmielau',
+'tim_t_murphy:dell.com' => 'Tim T. Murphy',
 'timw:splhi.com' => 'Tim Wright',
 'tinglett:vnet.ibm.com' => 'Todd Inglett',
@@ -2349,4 +2403,5 @@
 'tnt:246tnt.com' => 'Sylvain Munaut',
 'tobias.lorenz:gmx.net' => 'Tobias Lorenz',
+'tokunaga.keiich:jp.fujitsu.com' => 'Keiichiro Tokunaga',
 'tol:stacken.kth.se' => 'Tomas Olsson',
 'tom.l.nguyen:intel.com' => 'Tom L. Nguyen',
@@ -2389,12 +2444,15 @@
 'tuncer.ayaz:gmx.de' => 'Tuncer M. Zayamut Ayaz', # lbdb
 'tv:debian.org' => 'Tommi Virtanen',
+'tv:lio96.de' => 'Thomas Voegtle',
 'tv:tv.debian.net' => 'Tommi Virtanen',
 'tvignaud:mandrakesoft.com' => 'Thierry Vignaud',
 'tvrtko:net4u.hr' => 'Tvrtko A. Ursulin',
 'twaugh:redhat.com' => 'Tim Waugh',
+'twogood:users.sourceforge.net' => 'David Eriksson',
 'typhoon.adm:hostme.bitkeeper.com' => 'Dave Dillow', # himself on lk
-'tytso:mit.edu' => "Theodore Y. T'so", # web.mit.edu/tytso/www/home.html
-'tytso:snap.thunk.org' => "Theodore Y. T'so",
-'tytso:think.thunk.org' => "Theodore Y. T'so", # guessed
+'tytso:mit.edu' => "Theodore Y. Ts'o", # web.mit.edu/tytso/www/home.html
+'tytso:snap.thunk.org' => "Theodore Y. Ts'o",
+'tytso:think.thunk.org' => "Theodore Y. Ts'o", # guessed
+'tytso:thunk.org' => "Theodore Ts'o",
 'u233:shaw.ca' => 'Trent Whaley',
 'uaca:alumni.uv.es' => 'Ulisses Alonso Camaró',
@@ -2428,4 +2486,5 @@
 'vinay-rc:naturesoft.net' => 'Vinay K. Nallamothu',
 'vinay.nallamothu:gsecone.com' => 'Vinay K. Nallamothu',
+'vince:arm.linux.org.uk' => 'Vincent Sanders',
 'vince:kyllikki.org' => 'Vincent Sanders',
 'vinsci:floss.(none)' => 'Leonard Norrgard',
@@ -2435,4 +2494,5 @@
 'viro:www.linux.org.uk' => 'Alexander Viro',
 'vladimir.grouzdev:jaluna.com' => 'Vladimir Grouzdev',
+'vlobanov:speakeasy.net' => 'Vadim Lobanov',
 'vmlinuz386:yahoo.com.ar' => 'Gerardo Exequiel Pozzi', # lbdb
 'vnourval:tcs.hut.fi' => 'Ville Nuorvala',		# Can't spell his own login?
@@ -2466,4 +2526,5 @@
 'wellnhofer:aevum.de' => 'Nick Wellnhofer',
 'wensong:linux-vs.org' => 'Wensong Zhang',
+'wenxiong:us.ibm.com' => 'Wen Xiong',
 'werner:almesberger.net' => 'Werner Almesberger',
 'wes:infosink.com' => 'Wes Schreiner',
@@ -2502,4 +2563,5 @@
 'xkaspa06:stud.fee.vutbr.cz' => 'Tomas Kasparek',
 'xma:us.ibm.com' => 'Shirley Ma',
+'xose.vazquez:gmail.com' => 'Xose Vazquez Perez', # per request
 'xose:wanadoo.es' => 'Xose Vazquez Perez', # lbdb
 'xschmi00:stud.feec.vutbr.cz' => 'Michal Schmidt',

