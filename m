Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265500AbUAGLan (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 06:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265132AbUAGLam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 06:30:42 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:50904 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S266198AbUAGL3d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 06:29:33 -0500
MIME-Version: 1.0
To: torvalds@osdl.org, marcelo.tosatti@cyclades.com.br
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed_Jan__7_11_29_28_UTC_2004_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040107112928.05AFFA030E@merlin.emma.line.org>
Date: Wed,  7 Jan 2004 12:29:28 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.111, 2004-01-07 12:28:55+01:00, matthias.andree@gmx.de
  vita: 34 new addresses
  vita: re-sorted with LC_COLLATE=POSIX

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
# shortlog |   53 ++++++++++++++++++++++++++++++++++++++-----
# 1 files changed, 48 insertions(+), 5 deletions(-)

##### GNUPATCH #####
# This is a BitKeeper generated patch for the following project:
# Project Name: BK kernel tools
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.110   -> 1.111  
#	            shortlog	1.83    -> 1.84   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/07	matthias.andree@gmx.de	1.111
# vita: 34 new addresses
# vita: re-sorted with LC_COLLATE=POSIX
# --------------------------------------------
#
diff -Nru a/shortlog b/shortlog
--- a/shortlog	Wed Jan  7 12:29:28 2004
+++ b/shortlog	Wed Jan  7 12:29:28 2004
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.210 2003/12/30 02:11:39 emma Exp $
+# $Id: lk-changelog.pl,v 0.213 2004/01/07 09:45:46 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -122,6 +122,7 @@
 undef @addresses_handled_in_regexp;
 
 my %addresses = (
+'_nessuno_:katamail.com' => 'Davide Andrian',
 'a.wegele:tu-bs.de' => 'Artur Wegele',
 'aaron.baranoff:tsc.tdk.com' => 'Aaron Baranoff',
 'abbotti:mev.co.uk' => 'Ian Abbott',
@@ -191,6 +192,7 @@
 'alexander.riesen:synopsys.com' => 'Alexander Riesen',
 'alexander.schulz:com.rmk.(none)' => 'Alexander Schulz',
 'alexander.schulz:innominate.com' => 'Alexander Schulz',
+'alexander:all-2.com' => 'Alexander Oltu',
 'alexey:technomagesinc.com' => 'Alex Tomas',
 'alext:fc.hp.com' => 'Alex Tsariounov',
 'alfre:ibd.es' => 'Alfredo Sanjuán',
@@ -206,9 +208,9 @@
 'andmike:us.ibm.com' => 'Mike Anderson', # lbdb
 'andre.breiler:null-mx.org' => 'André Breiler',
 'andrea:suse.de' => 'Andrea Arcangeli',
-'andrew:com.rmk.(none)' => 'Andrew Victor', # double-check
 'andrew.grover:intel.com' => 'Andy Grover', # "Andy" to match former entries
 'andrew.wood:ivarch.com' => 'Andrew Wood',
+'andrew:com.rmk.(none)' => 'Andrew Victor', # double-check
 'andries.brouwer:cwi.nl' => 'Andries E. Brouwer',
 'andros:citi.umich.edu' => 'Andy Adamson',
 'angus.sawyer:dsl.pipex.com' => 'Angus Sawyer',
@@ -219,6 +221,7 @@
 'apolkosnik:directvinternet.com' => 'Adam Polkosnik',
 'arashi:yomerashi.yi.org' => 'Matt Reppert',
 'arekm:pld-linux.org' => 'Arkadiusz Miskiewicz', # lbdb
+'arief_m_utama:telkomsel.co.id' => 'Arief Mulya Utama',
 'aris:cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
 'arjan:redhat.com' => 'Arjan van de Ven',
 'arjanv:redhat.com' => 'Arjan van de Ven',
@@ -235,8 +238,8 @@
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
 'asl:launay.org' => 'Arnaud S. Launay',
 'aspicht:arkeia.com' => 'Arnaud Spicht',
-'atulm:lsil.com' => 'Atul Mukker',
 'atul.mukker:lsil.com' => 'Atul Mukker',
+'atulm:lsil.com' => 'Atul Mukker',
 'aviro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'axboe:burns.home.kernel.dk' => 'Jens Axboe', # guessed
 'axboe:hera.kernel.org' => 'Jens Axboe',
@@ -264,6 +267,7 @@
 'bellucda:tiscali.it' => 'Daniele Bellucci',
 'benh:kernel.crashing.org' => 'Benjamin Herrenschmidt',
 'benh:zion.wanadoo.fr' => 'Benjamin Herrenschmidt',
+'berentsen:sent5.uni-duisburg.de' => 'Martin Berentsen',
 'bergner:brule.rchland.ibm.com' => 'Peter Bergner',
 'bergner:cannon.rchland.ibm.com' => 'Peter Bergner',
 'bergner:vnet.ibm.com' => 'Peter Bergner',
@@ -288,6 +292,7 @@
 'bmatheny:purdue.edu' => 'Blake Matheny', # google
 'bombe:informatik.tu-muenchen.de' => 'Andreas Bombe',
 'borisitk:fortunet.com' => 'Boris Itkis', # by Kristian Peters
+'boutcher:us.ibm.com' => 'Dave Boutcher',
 'braam:clusterfs.com' => 'Peter Braam',
 'brett:bad-sports.com' => 'Brett Pemberton',
 'brihall:pcisys.net' => 'Brian Hall', # google
@@ -341,6 +346,7 @@
 'christopher:intel.com' => 'Christopher Goldfarb',
 'chrisw:osdl.org' => 'Chris Wright',
 'chyang:clusterfs.com' => 'Chen Yang',
+'ciaranm:gentoo.org' => 'Ciaran McCreesh',
 'cip307:cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
 'ckulesa:as.arizona.edu' => 'Craig Kulesa',
 'clemens-dated-1061728015.bf63:endorphin.org' => 'Fruhwirth Clemens',
@@ -383,10 +389,12 @@
 'dan:reactivated.net' => 'Daniel Drake',
 'dana.lacoste:peregrine.com' => 'Dana Lacoste',
 'danc:mvista.com' => 'Dan Cox', # some CREDITS patch found by google
+'dancy:dancysoft.com' => 'Ahmon Dancy',
 'daniel.ritz:ch.rmk.(none)' => 'Daniel Ritz',
 'daniel.ritz:gmx.ch' => 'Daniel Ritz',
 'daniel:deadlock.et.tudelft.nl' => 'Daniël Mantione',
 'daniel:osdl.org' => 'Daniel McNeil',
+'daniela:cyclades.com' => 'Daniela Squassoni',
 'dank:kegel.com' => 'Dan Kegel',
 'dario:emc.com' => 'Dario Ballabio', # Alan Cox
 'dave.jiang:com.rmk.(none)' => 'Dave Jiang',
@@ -437,6 +445,7 @@
 'dhollis:davehollis.com' => 'David T. Hollis',
 'dhowells:cambridge.redhat.com' => 'David Howells',
 'dhowells:redhat.com' => 'David Howells',
+'dhylands:com.rmk.(none)' => 'Dave Hylands',
 'dilinger:mp3revolution.net' => 'Andres Salomon',
 'dipankar:in.ibm.com' => 'Dipankar Sarma',
 'dirk.behme:com.rmk.(none)' => 'Dirk Behme',
@@ -482,9 +491,11 @@
 'eike:bilbo.math.uni-mannheim.de' => 'Rolf Eike Beer',
 'elenstev:com.rmk.(none)' => 'Steven Cole',
 'elenstev:mesatop.com' => 'Steven Cole',
+'elf:com.rmk.(none)' => 'Marc Singer',
 'eli.carter:com.rmk.(none)' => 'Eli Carter',
 'eli.kupermann:intel.com' => 'Eli Kupermann',
 'emann:mrv.com' => 'Eran Mann',
+'engebret:au1.ibm.com' => 'David Engebretsen',
 'engebret:brule.rchland.ibm.com' => 'David Engebretsen',
 'engebret:us.ibm.com' => 'David Engebretsen',
 'eranian:frankl.hpl.hp.com' => 'Stéphane Eranian',
@@ -497,6 +508,7 @@
 'erik_habbinga:hp.com' => 'Erik Habbinga',
 'erikj:subway.americas.sgi.com' => 'Erik Jacobson',
 'erlend-a:us.his.no' => 'Erlend Aasland',
+'erlend-a:ux.his.no' => 'Erlend Aasland',
 'ernstp:mac.com' => 'Ernst Persson', # lbdb
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
@@ -506,6 +518,7 @@
 'fcusack:fcusack.com' => 'Frank Cusack',
 'fdavis:si.rr.com' => 'Frank Davis',
 'felipewd:terra.com.br' => 'Felipe Damasio', # by self (did not ask to include the W.)
+'fello:libero.it' => 'Fabrizio Fellini',
 'fenghua.yu:intel.com' => 'Fenghua Yu', # google
 'fero:sztalker.hu' => 'Bakonyi Ferenc',
 'filip.sneppe:cronos.be' => 'Filip Sneppe',
@@ -716,6 +729,7 @@
 'jmcmullan:linuxcare.com' => 'Jason McMullan',
 'jmm:informatik.uni-bremen.de' => 'Moritz Mühlenhoff',
 'jmorris:intercode.com.au' => 'James Morris',
+'jmorris:redhat.com' => 'James Morris',
 'jmorros:intercode.com.au' => 'James Morris',	# it's typo IMHO
 'jo-lkml:suckfuell.net' => 'Jochen Suckfuell',
 'jochen:jochen.org' => 'Jochen Hein',
@@ -847,6 +861,7 @@
 'levon:movementarian.org' => 'John Levon',
 'lfo:polyad.org' => 'Luis F. Ortiz',
 'liam.girdwood:wolfsonmicro.com' => 'Liam Girdwood',
+'linas:us.ibm.com' => 'Linas Vepstas',
 'linux-usb:gemeinhardt.info' => 'Lars Gemeinhardt',
 'linux:brodo.de' => 'Dominik Brodowski',
 'linux:de.rmk.(none)' => 'Dominik Brodowski',
@@ -873,6 +888,8 @@
 'lowekamp:cs.wm.edu' => 'Bruce B. Lowekamp', # lbdb
 'luben:splentec.com' => 'Luben Tuikov',
 'luc.vanoostenryck:easynet.be' => 'Luc Van Oostenryck', # lbdb
+'luca.risolia:studio.unibo.it' => 'Luca Risolia',
+'luca:libero.it' => 'Luca Risolia',
 'lucasvr:terra.com.br' => 'Lucas Correia Villa Real', # google
 'lunz:falooley.org' => 'Jason Lunz',
 'lxiep:us.ibm.com' => 'Linda Xie',
@@ -881,6 +898,7 @@
 'maalanen:ra.abo.fi' => 'Marcus Alanen',
 'mac:melware.de' => 'Armin Schindler',
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
+'mail:de.rmk.(none)' => 'Peter Teichmann',
 'makisara:abies.metla.fi' => 'Kai Mäkisara',
 'maloi:phota.to' => 'Andy Molloy',
 'malte.d:gmx.net' => 'Malte Doersam', # google
@@ -892,6 +910,7 @@
 'mannthey:us.ibm.com' => 'Keith Mannthey',
 'marc:mbsi.ca' => 'Marc Boucher',
 'marcel:holtmann.org' => 'Marcel Holtmann', # sent by himself
+'marcelo.tosatti:cyclades.com' => 'Marcelo Tosatti',
 'marcelo.tosatti:cyclades.com.br' => 'Marcelo Tosatti',
 'marcelo:conectiva.com.br' => 'Marcelo Tosatti',
 'marcelo:dhcp-103.cyclades.de' => 'Marcelo Tosatti',
@@ -909,6 +928,7 @@
 'mark:hal9000.dyndns.org' => 'Mark W. McClelland',
 'markh:osdl.org' => 'Mark Haverkamp',
 'markhe:veritas.com' => 'Mark Hemment',
+'marr:flex.com' => 'Bill Marr',
 'martin.bene:icomedias.com' => 'Martin Bene',
 'martin.bligh:us.ibm.com' => 'Martin J. Bligh',
 'martin.schwidefsky:debitel.net' => 'Martin Schwidefsky',
@@ -929,8 +949,8 @@
 'maxk:viper.(none)' => 'Maksim Krasnyanskiy', # from shortlog
 'maxk:viper.qualcomm.com' => 'Maksim Krasnyanskiy',
 'mb:ozaba.mine.nu' => 'Magnus Boden',
-'mbp:samba.org' => 'Martin Pool', # lbdb
 'mbligh:aracnet.com' => 'Martin J. Bligh',
+'mbp:samba.org' => 'Martin Pool', # lbdb
 'mcp:linux-systeme.de' => 'Marc-Christian Petersen',
 'mdharm-scsi:one-eyed-alien.net' => 'Matthew Dharm',
 'mdharm-usb:one-eyed-alien.net' => 'Matthew Dharm',
@@ -940,13 +960,15 @@
 'mds:paradyne.com' => 'Mark D. Studebaker',
 'mec:shout.net' => 'Michael Elizabeth Chastain',
 'meissner:suse.de' => 'Marcus Meissner',
+'mfedyk:matchmail.com' => 'Mike Fedyk',
+'mgalgoci:redhat.com' => 'Matthew Galgoci',
 'mgreer:mivsta.com' => 'Mark A. Greer', # typo
 'mgreer:mvista.com' => 'Mark A. Greer', # lbdb
 'mhoffman:lightlink.com' => 'Mark M. Hoffman',
 'mhopf:innominate.com' => 'Mark-André Hopf',
 'michael:metaparadigm.com' => 'Michael Clark',
-'michaelw:foldr.org' => 'Michael Weber', # google
 'michael_e_brown:dell.com' => 'Michael E. Brown', # lbdb
+'michaelw:foldr.org' => 'Michael Weber', # google
 'michal:harddata.com' => 'Michal Jaegermann',
 'michal:logix.cz' => 'Michal Ludvig',
 'michel:daenzer.net' => 'Michel Dänzer',
@@ -954,6 +976,7 @@
 'mikal:stillhq.com' => 'Michael Still',
 'mike.miller:hp.com' => 'Mike Miller',
 'mike:aiinc.ca' => 'Michael Hayes',
+'mikem:beardog.cca.cpqcorp.net' => 'Mike Miller',
 'mikenc:us.ibm.com' => 'Mike Christie',
 'mikep:linuxtr.net' => 'Mike Phillips',
 'mikpe:csd.uu.se' => 'Mikael Pettersson',
@@ -987,6 +1010,7 @@
 'mochel:segfault.osdl.org' => 'Patrick Mochel',
 'mochel:segfault.osdlab.org' => 'Patrick Mochel',
 'moilanen:austin.ibm.com' => 'Jake Moilanen',
+'moilanen:us.ibm.com' => 'Jake Moilanen',
 'mort:green.i.bork.org' => 'Martin Hicks',
 'mort:wildopensource.com' => 'Martin Hicks',
 'mostrows:speakeasy.net' => 'Michal Ostrowski',
@@ -1033,6 +1057,7 @@
 'nobita:t-online.de' => 'Andreas Busch',
 'nstraz:sgi.com' => 'Nathan Straz',
 'ntfs:flatcap.org' => 'Richard Russon', # lbdb
+'nuno:itsari.org' => 'Nuno Monteiro',
 'okir:suse.de' => 'Olaf Kirch', # lbdb
 'okurth:gmx.net' => 'Oliver Kurth',
 'olaf.dietsche#list.linux-kernel:t-online.de' => 'Olaf Dietsche',
@@ -1149,6 +1174,7 @@
 'randolph:tausq.org' => 'Randolph Chung',
 'randy.dunlap:verizon.net' => 'Randy Dunlap',
 'ranty:debian.org' => 'Manuel Estrada Sainz',
+'rask:sygehus.dk' => 'Rask Ingemann Lambertsen',
 'raul:pleyades.net' => 'Raul Nunez de Arenas Coronado',
 'ray-lk:madrabbit.org' => 'Ray Lee',
 'rbh00:utsglobal.com' => 'Richard Hitt', # asked him, he prefers Richard
@@ -1298,6 +1324,7 @@
 'stekloff:w-stekloff.beaverton.ibm.com' => 'Daniel Stekloff',
 'stelian.pop:fr.alcove.com' => 'Stelian Pop',
 'stelian:popies.net' => 'Stelian Pop',
+'stephane.galles:free.fr' => 'Stephane Galles', # guessed
 'stern:rowland.harvard.edu' => 'Alan Stern',
 'stern:rowland.org' => 'Alan Stern', # lbdb
 'steve.cameron:hp.com' => 'Stephen Cameron',
@@ -1325,6 +1352,7 @@
 'swiergot:intersec.pl' => 'Jaroslaw Swierczynski',
 'szepe:pinerecords.com' => 'Tomas Szepe',
 'sziwan:hell.org.pl' => 'Karol Kozimor',
+'t-kochi:bq.jp.nec.com' => 'Takayoshi Kochi', # not a typo
 't-kouchi:mvf.biglobe.ne.jp' => 'Takayoshi Kouchi',
 'tai:imasy.or.jp' => 'Taisuke Yamada',
 'taka:valinux.co.jp' => 'Hirokazu Takahashi',
@@ -1334,6 +1362,7 @@
 'taral:taral.net' => 'Jean-Philippe Sugarbroad', # Muli Ben-Yehuda on lk
 'tausq:debian.org' => 'Randolph Chung',
 'tcallawa:redhat.com' => "Tom 'spot' Callaway",
+'tchen:on-go.com' => 'Thomas Chen',
 'tes:sgi.com' => 'Timothy Shimmin',
 'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
 'tgraf:suug.ch' => 'Thomas Graf',
@@ -1372,11 +1401,13 @@
 'trevor.pering:intel.com' => 'Trevor Pering',
 'trini:bill-the-cat.bloom.county' => 'Tom Rini',
 'trini:kernel.crashing.org' => 'Tom Rini',
+'trini:mvista.com' => 'Tom Rini',
 'trini:opus.bloom.county' => 'Tom Rini',
 'trini:org.rmk.(none)' => 'Tom Rini',
 'trivial:rustcorp.com.au' => 'Rusty Russell',
 'trond.myklebust:fys.uio.no' => 'Trond Myklebust',
 'tsk:ibakou.com' => 'Kawazoe Tomonori',
+'tspat:de.ibm.com' => 'Thomas Spatzier',
 'tv:debian.org' => 'Tommi Virtanen',
 'tvignaud:mandrakesoft.com' => 'Thierry Vignaud',
 'tvrtko:net4u.hr' => 'Tvrtko A. Ursulin',
@@ -1414,12 +1445,14 @@
 'vsu:altlinux.ru' => 'Sergey Vlasov',
 'wa:almesberger.net' => 'Werner Almesberger',
 'wahrenbruch:kobil.de' => 'Thomas Wahrenbruch',
+'waltabbyh:comcast.net' => 'Walt Holman',
 'walter.harms:informatik.uni-oldenburg.de' => 'Walter Harms',
 'warlord:mit.edu' => 'Derek Atkins',
 'warp:mercury.d2dc.net' => 'Zephaniah E. Hull',
 'wayne:stallion.oz.au' => 'Wayne Piekarski',
 'wcohen:redhat.com' => 'Will Cohen',
 'wd:denx.de' => 'Wolfgang Denk',
+'webvenza:libero.it' => 'Daniele Venzano',
 'wei_ni:ali.com.tw' => 'Wei Ni',			# Guessed
 'weigand:immd1.informatik.uni-erlangen.de' => 'Ulrich Weigand',
 'wensong:linux-vs.org' => 'Wensong Zhang',
@@ -1443,6 +1476,7 @@
 'wolfgang.fritz:gmx.net' => 'Wolfgang Fritz', # by Kristian Peters
 'wolfgang:iksw-muees.de' => 'Wolfgang Muees',
 'wolfgang:top.mynetix.de' => 'Wolfgang Mauerer',
+'woody:org.rmk.(none)' => 'Woody Suwalski',
 'wriede:riede.org' => 'Willem Riede',
 'wrlk:riede.org' => 'Willem Riede',
 'wstinson:infonie.fr' => 'William Stinson',
@@ -2165,6 +2199,15 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.213  2004/01/07 09:45:46  vita
+# resort address->name hash with LC_ALL=POSIX sort -u
+#
+# Revision 0.212  2004/01/07 08:38:47  vita
+# 34 new addresses
+#
+# Revision 0.211  2004/01/05 01:07:20  emma
+# Pull in two addresses from Linus' tree.
+#
 # Revision 0.210  2003/12/30 02:11:39  emma
 # 4 new addresses.
 #

##### BKPATCH #####
This BitKeeper patch contains the following changesets:
1.111
## Wrapped with gzip_uu ##


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
$?PT     
 

