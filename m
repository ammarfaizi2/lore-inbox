Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264453AbUDZIrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264453AbUDZIrE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 04:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbUDZIpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 04:45:50 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:17049 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262286AbUDZIkr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 04:40:47 -0400
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon_Apr_26_08_40_43_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040426084043.870F9B5739@merlin.emma.line.org>
Date: Mon, 26 Apr 2004 10:40:43 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:

ChangeSet@1.157, 2004-04-26 10:39:13+02:00, matthias.andree@gmx.de
  34 new addresses, 5 corrections

ChangeSet@1.156, 2004-04-20 14:50:10-07:00, torvalds@ppc970.osdl.org
  Add more names from 2.6.6-rc2
(not in patch below)

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   46 +++++++++++++++++++++++++++++++++++++------
# 1 files changed, 40 insertions(+), 6 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/04/26 10:39:13+02:00 matthias.andree@gmx.de 
#   34 new addresses, 5 corrections
# 
# shortlog
#   2004/04/26 10:39:13+02:00 matthias.andree@gmx.de +40 -6
#   34 new addresses, 5 corrections
# 
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Mon Apr 26 10:40:43 2004
+++ b/shortlog	Mon Apr 26 10:40:43 2004
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.266 2004/04/20 11:20:46 emma Exp $
+# $Id: lk-changelog.pl,v 0.268 2004/04/26 08:22:39 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -136,6 +136,7 @@
 my %addresses = (
 '_nessuno_:katamail.com' => 'Davide Andrian',
 'a.kasparas:gmc.lt' => 'Aidas Kasparas',
+'a.othieno:bluewin.ch' => 'Arthur Othieno',
 'a.othieno:ch.rmk.(none)' => 'Arthur Othieno',
 'a.wegele:tu-bs.de' => 'Artur Wegele',
 'aaron.baranoff:tsc.tdk.com' => 'Aaron Baranoff',
@@ -237,6 +238,7 @@
 'andrew:com.rmk.(none)' => 'Andrew Victor', # double-check
 'andries.brouwer:cwi.nl' => 'Andries E. Brouwer',
 'andros:citi.umich.edu' => 'Andy Adamson',
+'andyw:uk.ibm.com' => 'Andy Whitcroft',
 'angus.sawyer:dsl.pipex.com' => 'Angus Sawyer',
 'ankry:green.mif.pg.gda.pl' => 'Andrzej Krzysztofowicz',
 'anton:samba.org' => 'Anton Blanchard',
@@ -399,6 +401,7 @@
 'cminyard:mvista.com' => 'Corey Minyard',
 'cniehaus:handhelds.org' => 'Carsten Niehaus',
 'cobra:compuserve.com' => 'Kevin Brosius',
+'colin:colino.net' => 'Colin Leroy',
 'colin:gibbs.dhs.org' => 'Colin Gibbs',
 'colin:gibbsonline.net' => 'Colin Gibbs', # whois
 'colpatch:us.ibm.com' => 'Matthew Dobson',
@@ -423,6 +426,7 @@
 'd.mueller:elsoft.ch' => 'David Müller',
 'd3august:dtek.chalmers.se' => 'Björn Augustsson',
 'da-x:gmx.net' => 'Dan Aloni',
+'dainis_jonitis:exigengroup.lv' => 'Dainis Jonitis',
 'daisy:teetime.dynamic.austin.ibm.com' => 'Daisy Chang', # from shortlog
 'dale.farnsworth:mvista.com' => 'Dale Farnsworth',
 'dale:farnsworth.org' => 'Dale Farnsworth',
@@ -526,6 +530,7 @@
 'dsaxena:mvista.com' => 'Deepak Saxena',
 'dsaxena:net.rmk.(none)' => 'Deepak Saxena',
 'dsaxena:plexity.net' => 'Deepak Saxena',
+'dsd:gentoo.org' => 'Daniel Drake',
 'dsteklof:us.ibm.com' => 'Daniel E. F. Stekloff',
 'dth:dth.net' => 'Danny ter Haar', # guessed
 'dtor_core:ameritech.net' => 'Dmitry Torokhov',
@@ -607,6 +612,7 @@
 'francis.wiran:hp.com' => 'Francis Wiran',
 'franz.sirl-kernel:lauterbach.com' => 'Franz Sirl',
 'franz.sirl:lauterbach.com' => 'Franz Sirl',
+'frederik.deweerdt:laposte.net' => 'Frederik Deweerdt',
 'frival:zk3.dec.com' => 'Peter Rival',
 'fscked:netvisao.pt' => 'Paulo André',
 'fubar:us.ibm.com' => 'Jay Vosburgh',
@@ -628,6 +634,7 @@
 'geert:linux-m68k.org' => 'Geert Uytterhoeven',
 'george:mvista.com' => 'George Anzinger',
 'georgn:somanetworks.com' => 'Georg Nikodym',
+'gerald.schaefer:gmx.net' => 'Gerald Schaefer',
 'gerg:moreton.com.au' => 'Greg Ungerer',
 'gerg:snapgear.com' => 'Greg Ungerer',
 'ghoz:sympatico.ca' => 'Ghozlane Toumi',
@@ -723,6 +730,7 @@
 'ink:jurassic.park.msu.ru' => 'Ivan Kokshaysky',
 'ink:ru.rmk.(none)' => 'Ivan Kokshaysky',
 'ink:undisclosed.(none)' => 'Ivan Kokshaysky',
+'ioanamitu:yahoo.com' => 'Carl Spalletta',
 'iod00d:hp.com' => 'Grant Grundler', # lbdb
 'ionut:badula.org' => 'Ion Badulescu',
 'ionut:cs.columbia.edu' => 'Ion Badulescu',
@@ -752,6 +760,7 @@
 'jamey:crl.dec.com' => 'Jamey Hicks',
 'jamie:shareable.org' => 'Jamie Lokier',
 'jan.oravec:6com.sk' => 'Jan Oravec',
+'jan:ccsinfo.com' => 'Jan Capek',
 'jan:zuchhold.com' => 'Jan Zuchhold',
 'janetmor:us.ibm.com' => 'Janet Morgan',
 'jani:astechnix.ro' => 'Jani Monoses',
@@ -783,6 +792,7 @@
 'jef:linuxbe.org' => 'Jean-Francois Dive',
 'jeff.wiedemeier:hp.com' => 'Jeff Wiedemeier',
 'jeffm:suse.com' => 'Jeff Mahoney',
+'jeffm:suse.de' => 'Jeff Mahoney',
 'jeffpc:optonline.net' => 'Josef \'Jeff\' Sipek',
 'jeffs:accelent.com' => 'Jeff Sutherland', # lbdb
 'jejb:fuzzy.(none)' => 'James Bottomley',
@@ -818,6 +828,7 @@
 'jiho:c-zone.net' => 'Jim Howard',
 'jim.houston:attbi.com' => 'Jim Houston',
 'jim.houston:comcast.net' => 'Jim Houston',
+'jk:ozlabs.org' => 'Jeremy Kerr',
 'jkenisto:us.ibm.com' => 'James Keniston',
 'jkt:helius.com' => 'Jack Thomasson',
 'jlcooke:certainkey.com' => 'Jean-Luc Cooke',
@@ -842,6 +853,7 @@
 'johann.deneux:it.uu.se' => 'Johann Deneux',
 'johann.deneux:laposte.net' => 'Johann Deneux',
 'johannes:erdfelt.com' => 'Johannes Erdfelt',
+'john.cagle:hp.com' => 'John Cagle',
 'john.l.byrne:hp.com' => 'John L. Byrne',
 'john:deater.net' => 'John Clemens',
 'john:fremlin.de' => 'John Fremlin',
@@ -859,6 +871,7 @@
 'joris:struyve.be' => 'Joris Struyve',
 'josh:joshisanerd.com' => 'Josh Myer',
 'jparadis:redhat.com' => 'Jim Paradis',
+'jrsantos:austin.ibm.com' => 'Jose R. Santos',
 'jschopp:austin.ibm.com' => 'Joel Schopp',
 'jsiemes:web.de' => 'Josef Siemes',
 'jsimmons:heisenberg.transvirtual.com' => 'James Simmons',
@@ -922,7 +935,9 @@
 'khc:pc.waw.pl' => 'Krzysztof Halasa',
 'khc:pm.waw.pl' => 'Krzysztof Halasa',
 'kieran:mgpenguin.net' => 'Kieran Morrissey',
+'kingsley:aurema.com' => 'Cheung Kingsley',
 'kiran:in.ibm.com' => 'Ravikiran G. Thirumalai',
+'kirillx:7ka.mipt.ru' => 'Kirill Korotaev',
 'kisza:sch.bme.hu' => 'Andras Kis-Szabo', # google (netfilter-ext HOWTO)
 'kkeil:isdn4linux.de' => 'Karsten Keil',
 'kkeil:suse.de' => 'Karsten Keil',
@@ -980,6 +995,7 @@
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
 'liam.girdwood:wolfsonmicro.com' => 'Liam Girdwood',
+'linas:austin.ibm.com' => 'Linas Vepstas',
 'linas:us.ibm.com' => 'Linas Vepstas',
 'linux-kernel:n-dimensional.de' => 'Hans Ulrich Niedermann',
 'linux-usb:gemeinhardt.info' => 'Lars Gemeinhardt',
@@ -995,7 +1011,7 @@
 'livio:ime.usp.br' => 'Livio Baldini Soares',
 'liyang:nerv.cx' => 'Liyang Hu',
 'lkml001:vrfy.org' => 'Kay Sievers',
-'lkml:lievin.net' => 'Romain Lievin',
+'lkml:lievin.net' => 'Romain Liévin',
 'lkml:mathfillsmewithgreatjoy.com' => 'Michael Plump',
 'lkml:shemesh.biz' => 'Shachar Shemesh',
 'lm:bitmover.com' => 'Larry McVoy',
@@ -1017,6 +1033,7 @@
 'luca:libero.it' => 'Luca Risolia',
 'lucasvr:terra.com.br' => 'Lucas Correia Villa Real', # google
 'lunz:falooley.org' => 'Jason Lunz',
+'luto:myrealbox.com' => 'Andy Lutomirski',
 'lxiep:linux.ibm.com' => 'Linda Xie',
 'lxiep:ltcfwd.linux.ibm.com' => 'Linda Xie',
 'lxiep:us.ibm.com' => 'Linda Xie',
@@ -1030,7 +1047,9 @@
 'maeda.naoaki:jp.fujitsu.com' => 'Maeda Naoaki',
 'mail:de.rmk.(none)' => 'Peter Teichmann',
 'mail:gude.info' => 'Gude Analog- und Digitalsysteme GmbH',
+'mail:s-holst.de' => 'Stefan Holst',
 'makisara:abies.metla.fi' => 'Kai Mäkisara',
+'makovick:kmlinux.fjfi.cvut.cz' => 'Jindrich Makovicka',
 'maloi:phota.to' => 'Andy Molloy',
 'malte.d:gmx.net' => 'Malte Doersam', # google
 'manand:us.ibm.com' => 'Mala Anand',
@@ -1073,6 +1092,7 @@
 'martine.silbermann:hp.com' => 'Martine Silbermann',
 'masanari.iida:hp.com' => 'Masanari Iida', # lbdb
 'masbock:us.ibm.com' => 'Max Asbock',
+'maschaffner:gmx.ch' => 'Martin Schaffner',
 'mashirle:us.ibm.com' => 'Shirley Ma',
 'mason:suse.com' => 'Chris Mason',
 'mathieu:newview.com' => 'Mathieu Chouquet-Stringer',
@@ -1088,6 +1108,7 @@
 'mb:ozaba.mine.nu' => 'Magnus Boden',
 'mbligh:aracnet.com' => 'Martin J. Bligh',
 'mbp:samba.org' => 'Martin Pool', # lbdb
+'mbp:vexed.ozlabs.hp.com' => 'Martin Pool',
 'mcgrof:ruslug.rutgers.edu' => 'Luis R. Rodriguez',
 'mcgrof:studorgs.rutgers.edu' => 'Luis R. Rodriguez',
 'mchan:broadcom.com' => 'Michael Chan',
@@ -1098,6 +1119,7 @@
 'mdiehl:mdiehl.de' => 'Martin Diehl',
 'mdomsch:dell.com' => 'Matt Domsch', # lbdb
 'mds:paradyne.com' => 'Mark D. Studebaker',
+'mebrown:michaels-house.net' => 'Michael E. Brown',
 'mec:shout.net' => 'Michael Elizabeth Chastain',
 'meissner:suse.de' => 'Marcus Meissner',
 'mfedyk:matchmail.com' => 'Mike Fedyk',
@@ -1108,6 +1130,7 @@
 'mhoffman:lightlink.com' => 'Mark M. Hoffman',
 'mhopf:innominate.com' => 'Mark-André Hopf',
 'michael.krauth:web.de' => 'Michael Krauth',
+'michael.veeck:gmx.net' => 'Michael Veeck',
 'michael.waychison:sun.com' => 'Mike Waychison',
 'michael:metaparadigm.com' => 'Michael Clark',
 'michael_e_brown:dell.com' => 'Michael E. Brown', # lbdb
@@ -1116,6 +1139,7 @@
 'michal:harddata.com' => 'Michal Jaegermann',
 'michal:logix.cz' => 'Michal Ludvig',
 'michal_dobrzynski:mac.com' => 'Michal Dobrzynski',
+'michel.marti:objectxp.com' => 'Michel Marti',
 'michel:daenzer.net' => 'Michel Dänzer',
 'miguel:cetuc.puc-rio.br' => 'Miguel Freitas', # lbdb
 'mikael.starvik:axis.com' => 'Mikael Starvik',
@@ -1185,7 +1209,7 @@
 'mzyngier:freesurf.fr' => 'Marc Zyngier',
 'n0ano:n0ano.com' => 'Don Dugger',
 'nahshon:actcom.co.il' => 'Itai Nahshon',
-'nakam:linux-ipv6.org' => 'Masahide NAKAMURA',
+'nakam:linux-ipv6.org' => 'Masahide Nakamura',
 'nathanl:austin.ibm.com' => 'Nathan Lynch',
 'nathans:bruce.melbourne.sgi.com' => 'Nathan Scott',
 'nathans:sgi.com' => 'Nathan Scott',
@@ -1204,6 +1228,7 @@
 'nicolas.mailhot:laposte.net' => 'Nicolas Mailhot',
 'nicolas:dupeux.net' => 'Nicolas Dupeux',
 'nikai:nikai.net' => 'Nicolas Kaiser',
+'nikita:namesys.com' => 'Nikita Danilov',
 'nikkne:hotpop.com' => 'Nikola Knezevic',
 'niraj17:iitbombay.org' => 'Niraj Kumar',
 'nitin.a.kamble:intel.com' => 'Nitin A. Kamble',
@@ -1224,6 +1249,7 @@
 'ogasawara:osdl.org' => 'Leann Ogasawara',
 'okir:suse.de' => 'Olaf Kirch', # lbdb
 'okurth:gmx.net' => 'Oliver Kurth',
+'olaf.boehm:lanner.de' => 'Olaf Boehm',
 'olaf.dietsche#list.linux-kernel:t-online.de' => 'Olaf Dietsche',
 'oleg:tv-sign.ru' => 'Oleg Nesterov',
 'olh:suse.de' => 'Olaf Hering',
@@ -1235,6 +1261,7 @@
 'oliver:oenone.homelinux.org' => 'Oliver Neukum',
 'oliver:vermuden.neukum.org' => 'Oliver Neukum',
 'olof:austin.ibm.com' => 'Olof Johansson',
+'omkhar:rogers.com' => 'Omkhar Arasaratnam',
 'orjan.friberg:axis.com' => 'Orjan Friberg',
 'os:emlix.com' => 'Oskar Schirmer', # sent by himself
 'osst:riede.org' => 'Willem Riede',
@@ -1388,8 +1415,9 @@
 'riel:surriel.com' => 'Rik van Riel',
 'rjweryk:uwo.ca' => 'Rob Weryk',
 'rl:hellgate.ch' => 'Roger Luethi',
-'rlievin:free.fr' => 'Romain Lievin',
+'rlievin:free.fr' => 'Romain Liévin',
 'rmk+lkml:arm.linux.org.uk' => 'Russell King',
+'rmk+pcmcia:arm.linux.org.uk' => 'Russell King',
 'rmk-pci:arm.linux.org.uk' => 'Russell King',
 'rmk:arm.linux.org.uk' => 'Russell King',
 'rmk:flint.arm.linux.org.uk' => 'Russell King',
@@ -1409,8 +1437,8 @@
 'roland:frob.com' => 'Roland McGrath',
 'roland:redhat.com' => 'Roland McGrath',
 'roland:topspin.com' => 'Roland Dreier',
-'romain.lievin:esisar.inpg.fr' => 'Romain Lievin',
-'romain.lievin:wanadoo.fr' => 'Romain Lievin',
+'romain.lievin:esisar.inpg.fr' => 'Romain Liévin',
+'romain.lievin:wanadoo.fr' => 'Romain Liévin',
 'romain:lievin.net' => 'Romain Liévin',
 'romain:orebokech.com' => 'Romain Francoise',
 'romieu:cogenit.fr' => 'François Romieu',
@@ -1465,6 +1493,7 @@
 'schwab:suse.de' => 'Andreas Schwab',
 'schwidefsky:de.ibm.com' => 'Martin Schwidefsky',
 'scole:zianet.com' => 'Steven Cole', # lk, Alan Cox 20030904
+'scott.bailey:eds.com' => 'Scott Bailey',
 'scott.feldman:intel.com' => 'Scott Feldman',
 'scott_anderson:mvista.com' => 'Scott Anderson',
 'scottm:minion.yyz.somanetworks.com' => 'Scott Murray',
@@ -1478,6 +1507,7 @@
 'sebastian.droege:gmx.de' => 'Sebastian Dröge',
 'sebek64:post.cz' => 'Marcel Sebek',
 'set:pobox.com' => 'Paul Thompson',
+'sezero:superonline.com' => 'Özkan Sezer',
 'sfbest:us.ibm.com' => 'Steve Best',
 'sfr:au1.ibm.com' => 'Stephen Rothwell',
 'sfr:canb.auug.org.au' => 'Stephen Rothwell',
@@ -1541,7 +1571,9 @@
 'steve:kbuxd.necst.nec.co.jp' => 'Steve Baur',
 'steve:navaho.co.uk' => 'Steve Hill',
 'steved:redhat.com' => 'Steve Dickson',
+'stevef:linux-udp14619769uds.austin.ibm.com' => 'Steve French',
 'stevef:linux.local' => 'Steve French', # guessed
+'stevef:smfhome.smfdom' => 'Steve French',
 'stevef:smfhome1.austin.rr.com' => 'Steve French',
 'stevef:smfhome2.austin.rr.com' => 'Steve French',
 'stevef:stevef95.austin.ibm.com' => 'Steve French',
@@ -1623,6 +1655,7 @@
 'tony:com.rmk.(none)' => 'Tony Lindgren',
 'tonyb:cybernetics.com' => 'Tony Battersby',
 'torben.mathiasen:hp.com' => 'Torben Mathiasen',
+'torque:ukrpost.net' => 'Yury Umanets',
 'torvalds:linux.local' => 'Linus Torvalds',
 'trevor.pering:intel.com' => 'Trevor Pering',
 'trini:bill-the-cat.bloom.county' => 'Tom Rini',
@@ -1657,6 +1690,7 @@
 'varenet:parisc-linux.org' => 'Thibaut Varene',
 'vatsa:in.ibm.com' => 'Srivatsa Vaddagiri',
 'vberon:mecano.gme.usherb.ca' => 'Vincent Béron',
+'vda:port.imtp.ilyichevsk.odessa.ua' => 'Denis Vlasenko',
 'venkatesh.pallipadi:intel.com' => 'Venkatesh Pallipadi',
 'vherva:niksula.hut.fi' => 'Ville Herva',
 'vinay-rc:naturesoft.net' => 'Vinay K. Nallamothu',

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.157
## Wrapped with gzip_uu ##


M'XL(  O+C$   \57VV[;.!!]KKZ"0 OXH36KJR\$4K1)NFV:I"D2M(M]6M#2
MR&9TH9:D'+O(=^X_[%_LD%0<)V@>NKO )H8%<<Z9&8X.9^3GY*L&Q9XUW)B5
MX)KRME  P7/R46K#GBV;#2WL[:64>/M:]QI>5Z!:J%\?GN)G[&_&1LI:!PC\
MPDV^(FM0FCV+:+);,=L.V+/+]Q^^GKV[#(*# W*TXNT2KL"0@X/ 2+7F=:'?
M=M N>]%2HWBK&S"<YK*YW6%OXS",\3^*DW"2S6_C^23+;B&&+,O3B"^FLRGD
M\9Z[+I]/0RIU45.IE@\=I6&*OJ(LC,+;,$JB*#@F$8VR*0G3U_B))R0*63)G
M4?(RC%D8DD=U>NOK0UY&9!P&A^0_WL51D),D)2W<$%Y@/*U!OR(9R:52D!LA
M6QV<DBB.)L&7^W(&XY_\"X*0A\&;^^Q7LH%'J>N55*:62Y]Y%LW":3J-9K=)
M-)UGMR7,>9E/PSD/H>"+XHDZ/?!BBS\)9\D\2F[C9!9E3A1WB >:^-?Y/*V'
MQQG=R2'.IK/4RR$)?UH.:4C&D_]+#[Z8%V2L;C;V,]Z@.N[V^0_$<1Q%) I.
MW/=S\N*D8*2NQKG+'3W2KGZU)B&-)S-BBSA4*IRQ.,9BD;4PG+S?=.0%^DAF
MZ&3$J<2R02O9HN[A!NN2KT;DX T9O5-FU2MRX<VC5\%)C"XLI2VV-ZROJ%@T
MMG8#'%?)KRMA<B5+8^%I:-,<Y;(6+7/?DK9@//S(WI,S4'+KL'%FL047K="_
M7\M6&*$9;,02GY:2?4?KM2<>.PCYY"&6F\5N)X4N&**Q^UDUW8%; 34Y5KP"
M"YV$;@>E@@*4J% @-P"J,*SF'399N,_OEP%"C@>(HZ/^D+X$A4JB&NL.);9L
M*[4=\8,SDJO!:&E3OSDA><L;87JVY2O,<E>Z(ZYJ<M7QN@9CN&-DJ65<<RQ<
MKD5;[J$_\98<\0XJ!YPYU]=0E@VS$P&W-,!PB9QCH!9<A6>QR_VZ8O)[S1?Z
MODB?0$&S):>@7+:SU,>6*]0"7]; 5MU>=%S&\+CLL!/WB*^5YEAXS7BO#4KH
M@3 ^20WDDI(K![&L>>PB5*)=ZAJVR,($^%X]5M"W2W(ZV#TE\Q0EZGK#IA6G
MC>@,5;VGG#H#.95*&@YK1YG%EH(RXS].[,Q:R#?HM.$VK^/YW KIQ%]&==74
MK!:P1M[NZ5[*AEO=BK]PV4:)PLA)JNZ-9,U6 :\7<O/H6)RAL1%*5\)3$I<9
M>JJ9'J]P6IO=8[LR4.(#_F@7!W#BP95<B[QBF)5H^PTMKTM!\W5O:/Y]*+3 
MSB=POI\/6.X=3#/OP.JU+-M!L'?'_)PKK(S3JS-ZSMR)I5ET; T;*.B@F7TE
M#,0O^+;A.%'H.;!0\J9EC; GH+;[L[+<5?#<KY/WE!Q:H.=&GNMM= V .WUP
MK.YHWZQIX,SN.$AI;#9,+JZQ^6[VLW1FXI*USQA9,]]"W774\HHWS)5T++KU
MY/Y8G'/-5P)'R&<+Z96O9AQ.'$U4V$L9GF?06WT?[K-;)[;OU'+M&;%CR)J7
M="%AA=%XBX7>/?(+M)!#:_'X9.KP3;7BBBF)W68OP(5;)N\49J>XP03<KG!T
MNUWYZTAYW3)L=$!+]91VD[D3HFJJEUW>Y((SKAKJ]85UH'TU,'L<;_9XX8ET
MX=(H)C$Z2*,$KR/E/-,A*&B!N5'1=LLG8S^BW&!G++ E/IUJ.G%5T;DTAB[P
MY&#?@&*O,%?60@Z=Q3-F3E,:ON.0P=[8X:7%O<$]Y\_O%9ZU*XMPE"QU9PT'
MP1K*011]T6'P:#Z=S'N,]Z-&<F7Q!"=&BX?*^TGW_.BF=&]->"V>I$Q\@\.W
ME#]ZP.&J[#RZE_]OO=J2KPW'!>WQF6L[ZX*S#E\GJ&A,1T6]M7)?ZXK* E])
I..WY, C!#LUO-=?05G:8[WX,(#ZO=-\<+,ITSJ%(@K\!;E06;8D,    
 

