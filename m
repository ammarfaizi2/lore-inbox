Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVCNJvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVCNJvu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 04:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVCNJvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 04:51:50 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:50154 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262090AbVCNJuH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 04:50:07 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
CC: matthias.andree@gmx.de, samel@mail.cz, linux-kernel@vger.kernel.org
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon,_14_Mar_2005_09_49_59_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20050314094959.F0C2E87C04@merlin.emma.line.org>
Date: Mon, 14 Mar 2005 10:49:59 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK parent: http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.290, 2005-03-14 08:17:19+01:00, samel@mail.cz
  shortlog: add 22 new addresses; re-sort

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletion(-)

##### GNUPATCH #####
--- 1.255/shortlog	2005-03-11 11:18:49 +01:00
+++ 1.256/shortlog	2005-03-14 08:16:36 +01:00
@@ -235,8 +235,8 @@
 'akpm:osdl.org' => 'Andrew Morton', # guessed
 'akpm:reardensteel.com' => 'Andrew Morton',
 'akpm:zip.com.au' => 'Andrew Morton',
-'akropel:rochester.rr.com' => 'Adam Kropelin', # guessed
 'akropel1:rochester.rr.com' => 'Adam Kropelin', # lbdb
+'akropel:rochester.rr.com' => 'Adam Kropelin', # guessed
 'al.fracchetti:tin.it' => 'Alessandro Fracchetti',
 'alain.knaff:lll.lu' => 'Alain Knaff',
 'alain:linux.lu' => 'Alain Knaff',
@@ -329,6 +329,7 @@
 'aoki:sdl.hitachi.co.jp' => 'Hideo Aoki',
 'aoliva:redhat.com' => 'Alexandre Oliva',
 'ap:cipherica.com' => 'Alex Pankratov',
+'apatard:mandrakesoft.com' => 'Arnaud Patard',
 'apm:brigitte.dna.fi' => 'Antti P. Miettinen',
 'apolkosnik:directvinternet.com' => 'Adam Polkosnik',
 'appro:fy.chalmers.se' => 'Andy Polyakov',
@@ -337,6 +338,7 @@
 'arashi:yomerashi.yi.org' => 'Matt Reppert',
 'arekm:pld-linux.org' => 'Arkadiusz Miskiewicz', # lbdb
 'arief_m_utama:telkomsel.co.id' => 'Arief Mulya Utama',
+'ariel:blueslice.com' => 'Ariel Rosenblatt',
 'aris:cathedrallabs.org' => 'Aristeu Sergio Rozanski Filho',
 'arjan:fenrus.demon.nl' => 'Arjan van de Ven',
 'arjan:infradead.org' => 'Arjan van de Ven',
@@ -475,6 +477,7 @@
 'braam:clusterfs.com' => 'Peter Braam',
 'brad:wasp.net.au' => 'Brad Campbell',
 'brad_mssw:gentoo.org' => 'Brad House',
+'bram.verweij:wanadoo.nl' => 'Bram Verweij',
 'bram:sara.nl' => 'Bram Stolk',
 'braunu:de.ibm.com' => 'Ursula Braun-Krahl',
 'brazilnut:us.ibm.com' => 'Don Fry',
@@ -580,6 +583,7 @@
 'cip307:cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
 'ckoerner:sysgo.com' => 'Christian Koerner',
 'ckulesa:as.arizona.edu' => 'Craig Kulesa',
+'cl81:gmx.net' => 'Christian Ludwig',
 'clameter:sgi.com' => 'Christoph Lameter',
 'clear.zhang:uli.com.tw' => 'Clear Zhang',
 'clemens-dated-1061728015.bf63:endorphin.org' => 'Fruhwirth Clemens',
@@ -801,6 +805,7 @@
 'ducrot:poupinou.org' => 'Bruno Ducrot',
 'duncan.sands:math.u-psud.fr' => 'Duncan Sands',
 'duncan:sun.com' => 'Duncan Laurie',
+'duraid:octopus.com.au' => 'Duraid Madina',
 'duwe:suse.de' => 'Torsten Duwe',
 'dvhltc:us.ibm.com' => 'Darren Hart',
 'dvrabel:arcom.co.uk' => 'David Vrabel',
@@ -871,6 +876,7 @@
 'eric.lemoine:gmail.com' => 'Eric Lemoine',
 'eric.moore:lsil.com' => 'Eric Moore',
 'eric.piel:bull.net' => 'Eric Piel',
+'eric.piel:lifl.fr' => 'Eric Piel',
 'eric.valette:free.fr' => 'Eric Valette',
 'eric:lammerts.org' => 'Eric Lammerts',
 'eric:yhbt.net' => 'Eric Wong',
@@ -986,6 +992,7 @@
 'ghoz:sympatico.ca' => 'Ghozlane Toumi',
 'gibbs:overdrive.btc.adaptec.com' => 'Justin T. Gibbs',
 'gibbs:scsiguy.com' => 'Justin T. Gibbs',
+'gijoe:poczta.onet.pl' => 'Daniel Johnson',
 'gilbertd:treblig.org' => 'Dr. David Alan Gilbert',
 'giorgio:org.rmk.(none)' => 'Giorgio Padrin',
 'giri:lmc.cs.sunysb.edu' => 'Giridhar Pemmasani',
@@ -1049,6 +1056,7 @@
 'hadi:znyx.com' => 'Jamal Hadi Salim', # typo
 'hadi:zynx.com' => 'Jamal Hadi Salim',
 'hager:cs.umu.se' => 'Peter Hagervall',
+'hal:realmsys.com' => 'Hal Tolley',
 'hall:vdata.com' => 'Jeff Hall',
 'hallyn:cs.wm.edu' => 'Serge Hallyn',
 'halr:voltaire.com' => 'Hal Rosenstock',
@@ -1207,6 +1215,7 @@
 'jbarnes:sgi.com' => 'Jesse Barnes',
 'jbaron:redhat.com' => 'Jason Baron',
 'jbglaw:lug-owl.de' => 'Jan-Benedict Glaw',
+'jbj1:ultraemail.net' => 'Jens B. Jorgensen',
 'jblack:linuxguru.net' => 'James Blackwell',
 'jbm:joshisanerd.com' => 'Josh Myer',
 'jbourne:hardrock.org' => 'James Bourne',
@@ -1296,6 +1305,7 @@
 'jim:jtan.com' => 'Jim Paris',
 'jimix:watson.ibm.com' => 'Jimi Xenidis',
 'jk:ozlabs.org' => 'Jeremy Kerr',
+'jkacur:rogers.com' => 'John Kacur',
 'jkenisto:us.ibm.com' => 'James Keniston',
 'jkluebs:com.rmk.(none)' => 'John K. Luebs',
 'jkmaline:cc.hut.fi' => 'Jouni Malinen',
@@ -1376,6 +1386,7 @@
 'jsimmons:kozmo.(none)' => 'James Simmons',
 'jsimmons:maxwell.earthlink.net' => 'James Simmons',
 'jsimmons:transvirtual.com' => 'James Simmons',
+'jsimmons:www.infradead.org' => 'James Simmons',
 'jsm:fc.hp.com' => 'John S. Marvin',
 'jsm:udlkern.fc.hp.com' => 'John S. Marvin',
 'jstultz:us.ibm.com' => 'John Stultz',
@@ -1592,6 +1603,7 @@
 'linux:de.rmk.(none)' => 'Dominik Brodowski',
 'linux:de.rmk.(none2)' => 'Sebastian Henschel',
 'linux:dominikbrodowski.de' => 'Dominik Brodowski',
+'linux:dominikbrodowski.net' => 'Dominik Brodowski',
 'linux:hazard.jcu.cz' => 'Jan Marek',
 'linux:kodeaffe.de' => 'Sebastian Henschel',
 'linux:michaelgeng.de' => 'Michael Geng',
@@ -1790,6 +1802,7 @@
 'mhtran:us.ibm.com' => 'Mike Tran',
 'mhuth:mvista.com' => 'Mark Huth',
 'mhw:wittsend.com' => 'Michael H. Warfield',
+'micah:navi.cx' => 'Micah Dowty',
 'michael.kerrisk:gmx.net' => 'Michael Kerrisk',
 'michael.krauth:web.de' => 'Michael Krauth',
 'michael.ni:hp.com' => 'Michael Ni',
@@ -1893,6 +1906,7 @@
 'msalter:redhat.com' => 'Mark Salter',
 'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
 'mst:mellanox.co.il' => 'Michael S. Tsirkin',
+'mstjohns:mindspring.com' => 'Michael StJohns',
 'msw:redhat.com' => 'Matt Wilson',
 'mtk-lkml:gmx.net' => 'Michael Kerrisk',
 'mufasa:sis.com.tw' => 'Mufasa Yang', # sent by himself
@@ -1905,6 +1919,7 @@
 'mzyngier:freesurf.fr' => 'Marc Zyngier',
 'mzzhgg:de.rmk.(none)' => 'Lennart Poettering',
 'n0ano:n0ano.com' => 'Don Dugger',
+'n1gp:hotmail.com' => 'Richard Koch',
 'nacc:us.ibm.com' => 'Nishanth Aravamudan',
 'nahshon:actcom.co.il' => 'Itai Nahshon',
 'nakam:linux-ipv6.org' => 'Masahide Nakamura',
@@ -2123,6 +2138,7 @@
 'piggin:cyberone.com.au' => 'Nick Piggin',
 'piggy:timesys.com' => 'La Monte H.P. Yarroll',
 'pilo.c:wanadoo.fr' => 'Pilo Chambert',
+'pingc:wacom.com' => 'Ping Cheng',
 'pisa:cmp.felk.cvut.cz' => 'Pavel Pisa',
 'pixi:burble.org' => 'Maurice S. Barnum',
 'pj:sgi.com' => 'Paul Jackson',
@@ -2314,6 +2330,7 @@
 'ruben:ugr.es' => 'Ruben Garcia',
 'ruber:engr.es' => 'Ruben Garcia',
 'ruby.joker:op.pl' => 'Ruby Joker',
+'rufus-kernel:hackish.org' => 'Peter Nelson',
 'rui.sousa:laposte.net' => 'Rui Sousa',
 'runet:innovsys.com' => 'Rune Torgersen',
 'russb:emc.com' => 'Brett Russ',
@@ -2513,6 +2530,7 @@
 'steved:redhat.com' => 'Steve Dickson',
 'stevef:linux-udp14619769uds.austin.ibm.com' => 'Steve French',
 'stevef:linux.local' => 'Steve French', # guessed
+'stevef:smf-t23.(none)' => 'Steve French',
 'stevef:smfhome.smfdom' => 'Steve French',
 'stevef:smfhome.smfsambadom' => 'Steve French',
 'stevef:smfhome1.austin.rr.com' => 'Steve French',
@@ -2547,6 +2565,7 @@
 'suresh.krishnan:ericsson.ca' => 'Suresh Krishnan',
 'sv:sw.com.sg' => 'Vladimir Simonov',
 'svm:kozmix.org' => 'Sander van Malssen',
+'svrmgrl:gmx.net' => 'Rainer Kümmerle',
 'swanson:uklinux.net' => 'Alan Swanson',
 'swiergot:intersec.pl' => 'Jaroslaw Swierczynski',
 'sxking:qwest.net' => 'Steven King',
@@ -2579,8 +2598,10 @@
 'tduffy:sun.com' => 'Tom Duffy',
 'teanropo:cc.jyu.fi' => 'Tero Roponen',
 'tejohnson:yahoo.com' => 'Todd E. Johnson',
+'telendiz:eircom.net' => 'Telemaque Ndizihiwe',
 'temnota+kernel:kmv.ru' => 'Andrey Melnikov',
 'temnota:kmv.ru' => 'Andrey Melnikov',
+'tero_niemela:yahoo.com' => 'Tero Niemela',
 'tes:sgi.com' => 'Timothy Shimmin',
 'tetapi:utu.fi' => 'Tero Pirkkanen', # by Kristian Peters
 'tglx:de.rmk.(none)' => 'Thomas Gleixner',
@@ -2689,6 +2710,7 @@
 'tytso:snap.thunk.org' => "Theodore Y. Ts'o",
 'tytso:think.thunk.org' => "Theodore Y. Ts'o", # guessed
 'tytso:thunk.org' => "Theodore Ts'o",
+'tzachar:cs.bgu.ac.il' => 'Nir Tzachar',
 'u233:shaw.ca' => 'Trent Whaley',
 'uaca:alumni.uv.es' => 'Ulisses Alonso Camaró',
 'umka:namesys.com' => 'Yury Umanets',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAEdeNUICA7VWXW/bNhR9jn4FgTx4Q2tF1Lc4uEhTd2vqNguSdK8DLV1LjCXSI6U4CfzT
97BLyR91sGHY1tkGbPGew3vv4eFNTsnllJ20Sj/wujDnK5BlJ6Tbai5NAy13c9Vs3lVclnAL
7cb3PB/f1A+8OMo2fhZH0QZ8iKI8pHyepAnkvnNKvhjQ7KThbVsJblwuCw2A6x+UadlJ2Ty6
hX28UQofz0xn4GwJWkJ9djHDz3h4GLdK1cZB4DVv84o8gDbshLrBfqV9WgE7uXn/05dPb28c
ZzIh+1rJZOJ8475e9HM+9HG8TeQFlFKPpmG2icOYZs6UUNfPPOJFZ15wRkPipYwmjGavPMo8
jxjeQH3ecFG7+TN5RcnYcy7INy79nZMTUynd1qpkhBcF8X0iYW1/ajAGzA9Ew9ggwpmROEiC
0Lk+iOmM/+HLcTzuOW8ObVSqgRc97OoZWoho6iVhQtNNQJMs2iwg44s88TLuQcHnxbFOR2Sr
eeglNA7iTZQmvtc7YYc4MsJ/LuOvTPCynp0HwoiG0eCBKD72QMyC+M894AdkTP8fE/zd0Q/6
/UzGev1oP+NH9MGuuX9hg6kfpIQ6l36Q4deIL7VaQc20yiswLWhXa9vLiEzekNHbgjdk1iOE
HL0mp6TsbIWFcxkEtOeveMt1wRqrPl+CUYv2K76WvCvsbEDM6LVlDVm1wJzzGjerRQ5fEzCA
Y8iAnNd4sJYTJonlzDVvXJw4axD3bM0lL5RyZT3wLjBIfhmClhOlvuXkdUqZNYSEdgC+q7Qw
reCSfOqKtSgtOPUCCy46zUXBVN6qVWdsTS7vBta0D5HPvBCS95Skp4AWubuyvdRiUbsLPcDf
4zK5xmULzVKr96gU9wrYSuXPaBaF9birbe1TLm3TH1UljZKWQtH1llNxPBjgdWOezEGjD7wm
d6qu4anH+l4v6f38nrKuRkNCb9t9xx9BGnLh4v66xJ8wZPCzvqr7Jc87jadf4ig/pLC1kJkN
9eAgGcBGNI2Shq3Xa1fIheYF8MLFfbcsvDSG3A6gnhhloSWiebpHVqhGSLGca1WotVmKQ4nT
IUIudqGenGT9GTYi5xWT/EG4+eOA/2yXyFSt20GCNIt6pGnvrYgMdyvMSgtZHlpCTsVR5tu2
F7rnZV7vLEnLFatUO1z3HeHGEnRBZngzLNqnfp9lhdvmaEDrjz34GhdxOuNU6KEBjS1Ud4vO
bP92sornS2Gqg1zXgNeNXEG9PXU/on0CvIUPsGCmWYxbP3C/k+iW7wfKrQ2RHzXIbU1R2B++
edBNqetjq99wITHB7PemAV3DgE97Y7VQgyzEMwOhbR97zh0GGv5bB+QKw6IS6x0vGHha/Ypu
xeHI2ROv8AbuJbjDGLkaYj0nzoZcz9wKyXLjzsvO5bkrtsa/EprcDVEk7P+HwEGUL03XTOYB
xbyB7/wB1Xi+5hUJAAA=

