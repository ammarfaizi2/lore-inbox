Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269193AbUJFKsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269193AbUJFKsl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 06:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269198AbUJFKsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 06:48:40 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:61342 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S269193AbUJFKsT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 06:48:19 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed,_06_Oct_2004_10_48_12_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20041006104812.C6519C76AB@merlin.emma.line.org>
Date: Wed,  6 Oct 2004 12:48:12 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.228, 2004-10-06 11:57:03+02:00, samel@mail.cz
  shortlog: correct 2 addresses

ChangeSet@1.227, 2004-10-06 11:54:41+02:00, samel@mail.cz
  shortlog: 5 new addresses

ChangeSet@1.226, 2004-10-04 07:31:28+02:00, samel@mail.cz
  shortlog: 6 new addresses + 1 correction

ChangeSet@1.225, 2004-10-01 07:20:28+02:00, samel@mail.cz
  shortlog: remove one duplicate after Linus' merge

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

##### GNUPATCH #####
--- 1.196/shortlog	2004-09-30 05:34:36 +02:00
+++ 1.200/shortlog	2004-10-06 11:56:40 +02:00
@@ -300,7 +300,7 @@
 'anton:superego.ozlabs.ibm.com' => 'Anton Blanchard',
 'aoliva:redhat.com' => 'Alexandre Oliva',
 'ap:cipherica.com' => 'Alex Pankratov',
-'apm:brigitte.dna.fi' => 'Antti P Miettinen',
+'apm:brigitte.dna.fi' => 'Antti P. Miettinen',
 'apolkosnik:directvinternet.com' => 'Adam Polkosnik',
 'appro:fy.chalmers.se' => 'Andy Polyakov',
 'apw:shadowen.org' => 'Andy Whitcroft',
@@ -372,6 +372,7 @@
 'beattie:beattie-home.net' => 'Brian Beattie', # from david.nelson
 'bellucda:tiscali.it' => 'Daniele Bellucci',
 'ben-linux:org.rmk.(none)' => 'Ben Dooks',
+'ben:simtec.co.uk' => 'Ben Dooks',
 'bengen:hilluzination.de' => 'Hilko Bengen',
 'benh:kenrel.crashing.org' => 'Benjamin Herrenschmidt', # typo
 'benh:kernel.crashing.org' => 'Benjamin Herrenschmidt',
@@ -406,6 +407,7 @@
 'blaisorblade_spam:yahoo.it' => 'Paolo \'Blaisorblade\' Giarrusso',
 'blaschke:blaschke3.austin.ibm.com' => 'Dave Blaschke',
 'blazara:nvidia.com' => 'Brian Lazara',
+'blofeldus:com.rmk.(none)' => 'Roger Blofeld',
 'blueflux:koffein.net' => 'Oskar Andreasson',
 'bmatheny:purdue.edu' => 'Blake Matheny', # google
 'bo.henriksen:com.rmk.(none)' => 'Bo Henriksen',
@@ -444,6 +446,7 @@
 'bwindle:fint.org' => 'Burton N. Windle',
 'bzeeb-lists:lists.zabbadoz.net' => 'Björn A. Zeeb', # lbdb
 'bzolnier:elka.pw.edu.pl' => 'Bartlomiej Zolnierkiewicz',
+'bzolnier:gmail.com' => 'Bartlomiej Zolnierkiewicz',
 'bzolnier:trik.(none)' => 'Bartlomiej Zolnierkiewicz',
 'bzzz:gerasimov.net' => 'Alex Tomas',
 'bzzz:tmi.comex.ru' => 'Alex Tomas',
@@ -483,6 +486,7 @@
 'chan:aleph1.co.uk' => 'Tak-Shing Chan',
 'char:cmf.nrl.navy.mil' => 'Chas Williams', # typo ???
 'charles.white:hp.com' => 'Charles White',
+'chaus:cs.uni-potsdam.de' => 'Carsten Haustein',
 'chessman:tux.org' => 'Samuel S. Chessman',
 'chip:pobox.com' => 'Chip Salzenberg', # lbdb
 'chris:heathens.co.nz' => 'Chris Heath',
@@ -706,7 +710,8 @@
 'ebrower:resilience.com' => 'Eric Brower',
 'ebrower:usa.net' => 'Eric Brower',
 'ebs:ebshome.net' => 'Eugene Surovegin',
-'ecashin:uga.edu' => 'Ed L Cashin',
+'ecashin:coraid.com' => 'Ed L. Cashin',
+'ecashin:uga.edu' => 'Ed L. Cashin',
 'ecd:skynet.be' => 'Eddie C. Dost',
 'eddie.williams:steeleye.com' => 'Eddie Williams',
 'edv:macrolink.com' => 'Ed Vance',
@@ -847,7 +852,6 @@
 'giri:lmc.cs.sunysb.edu' => 'Giridhar Pemmasani',
 'giuseppe.furlan:systeam.it' => 'Giuseppe Furlan',
 'gj:pointblue.com.pl' => 'Grzegorz Jaskiewicz',
-'gj:pointblue.com.pl' => 'Grzegorz Jaskiewicz',
 'gkernel.adm:hostme.bitkeeper.com' => 'Jeff Garzik', # himself
 'gl:dsa-ac.de' => 'Guennadi Liakhovetski',
 'glee:gnupilgrims.org' => 'Geoffrey Lee', # lbdb
@@ -953,6 +957,7 @@
 'hunold:convergence.de' => 'Michael Hunold',
 'hunold:linuxtv.org' => 'Michael Hunold',
 'hverhagen:dse.nl' => 'Harm Verhagen',
+'hvr:gnu.org' => 'Herbert V. Riedel',
 'hwahl:hwahl.de' => 'Hartmut Wahl',
 'hzhong:cisco.com' => 'Hua Zhong',
 'i.palsenberg:jdirmedia.nl' => 'Igmar Palsenberg', # lbdb
@@ -1033,7 +1038,7 @@
 'jd:rightthere.net' => 'Jason Davis',
 'jdavid:farfalle.com' => 'David Ruggiero',
 'jdewand:redhat.com' => 'Julie DeWandel',
-'jdgaston:snoqualmie.dp.intel.com' => 'Jason D Gaston',
+'jdgaston:snoqualmie.dp.intel.com' => 'Jason D. Gaston',
 'jdike:addtoit.com' => 'Jeff Dike',
 'jdike:jdike.wstearns.org' => 'Jeff Dike',
 'jdike:karaya.com' => 'Jeff Dike',
@@ -1149,6 +1154,7 @@
 'jonas.larsson:net.rmk.(none)' => 'Jonas Larsson',
 'jonas:thornblad.net' => 'Jonas Thornblad',
 'jones:ingate.com' => 'Jones Desougi',
+'jonsmirl:gmail.com' => 'Jon Smirl',
 'jonsmirl:yahoo.com' => 'Jon Smirl',
 'joris:eljakim.nl' => 'Joris van Rantwijk',
 'joris:struyve.be' => 'Joris Struyve',
@@ -1622,6 +1628,7 @@
 'nemosoft:smcc.demon.nl' => 'Nemosoft Unv.',
 'netfilter:interlinx.bc.ca' => 'Brian J. Murrell',
 'nfont:austin.ibm.com' => 'Nathan Fontenot',
+'nhorman:redhat.com' => 'Neil Horman',
 'nick.holloway:pyrites.org.uk' => 'Nick Holloway',
 'nickpiggin:cyberone.com.au' => 'Nick Piggin',
 'nickpiggin:yahoo.com.au' => 'Nick Piggin',
@@ -1705,6 +1712,7 @@
 'patmans:us.ibm.com' => 'Patrick Mansfield',
 'patrick.boettcher:desy.de' => 'Patrick Boettcher',
 'patrick:dreker.de' => 'Patrick Dreker', # lbdb
+'patrick:tykepenguin.com' => 'Patrick Caulfield',
 'patrick:wildi.com' => 'Patrick Wildi',
 'paubert:iram.es' => 'Gabriel Paubert',
 'paul+nospam:wurtel.net' => 'Paul Slootman',
@@ -2010,6 +2018,7 @@
 'seanlkml:rogers.com' => 'Sean Estabrooks',
 'sebastian.droege:gmx.de' => 'Sebastian Dröge',
 'sebek64:post.cz' => 'Marcel Sebek',
+'seife:suse.de' => 'Stefan Seyfried',
 'sergio.gelato:astro.su.se' => 'Sergio Gelato',
 'set:pobox.com' => 'Paul Thompson',
 'seto.hidetoshi:jp.fujitsu.com' => 'Hidetoshi Seto',
@@ -2196,6 +2205,7 @@
 'timw:splhi.com' => 'Tim Wright',
 'tinglett:vnet.ibm.com' => 'Todd Inglett',
 'tiwai:suse.de' => 'Takashi Iwai',
+'tj:home-tj.org' => 'Tejun Heo',
 'tkooda-patch-kernel:devsec.org' => 'Thor Kooda',
 'tlnguyen:snoqualmie.dp.intel.com' => 'Tom L. Nguyen',
 'tmattox:engr.uky.edu' => 'Tim Mattox',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAGzNY0ECA9VXXW/bNhR9jn4FgT54Q2aFpL4FuGiTFI3XbAuSdQ97o6Vrm7ZEuiSVL+jH
jxLjuPbSZd0SBLENyLbOle8959575DdofJzvGakuWVXqdysQs4YL3ygmdA2G+YWs26M5EzO4
ANNSjKl9EhrgOMpamsVR1AKFKCpCwiZJmkBBvTfoswaV79XMmDln2meiVAD2+xOpTb43q6/9
svt4LqX9eHDJ1MGEmyXACtTB4afhEpSAamikrLRncWfMFHN0CUrne8QP7r8xNyvI984/fPx8
+v7c80YjdJ8qGo28Jy5rc7lVkSXYl7qsfKlm2xcKcRZgHARhELcYJzH1jhHxKY0QDg8IPsAE
4SSnOKfpPqY5xkizGqp3NeOVX9yifYKG2DtET5z8kVcgPZfKVHKWIwW1vAQkBaCyWVW8YAYQ
mxpQ6JSLRg9QDWoG3icURzQl3tmGWG/4nQ/Pwwx7bzcFzWUNO9WsM3PFRCTFSZiQtA1IkkXt
FDI2LRKcMQwlm5TbjG0FhwRjYi+QYdLiIEkzz9sGb2vl0Ja+tHWFOq3itVZhp1VAXlSrGAm4
Qqy0I6Q1aLSPCCqkUlAYLoWTKIlfl0QhjgKCaUvDjKSPStSjnUS2UCdRspYoRoTkUZiH5OUk
irYlcppkr2xsYpxFIY3bkOLk8bHp0SFpXaFOk3RbkyTHwctpcjciiO7qktLXp0scYqsLSUhv
cmvElsf97zS+7W9bGX1tb0mWuXkkWbJlbyTL8TfmEaMheR7t/72p9cbwGxqqq+vuNby2HbEu
8j80xHEaYUR2R+afbcmxlu4aDaYPs5Y8G2uP2ovb0U/H1jhIQsvWYAIi17w2UNjc/WY5QKO3
aHAIAh1LudSDn7xxGMY98lZWgts7ypnjQ9Z3WNblUHNYoD8dYsnhihe3fWwadbHFnDU6L7Tf
CD5cSaNLVtubT3eBI6a0sT94YjEGuLBxx3YgbNy4O1BvAAXTcy5yywjj5eanP5To1EdH/Ukb
dY9rZsyHsnkQNCak75PBQlrNuKp26/lZCnTRnejAVjzSgTXwKeS60XCf9oWBKbNQuJkqDqVF
e99jt671sl0DpfHDrRc927L+u20673nCXgt7NQeTSk6hKrtOkLWv6qX/g7B74kfH57mc2R1x
6DAd91mUdlHzS9tyoul2oAOegJqAMugPH51b4qEXisS0RwubZs1ErqCcM7NR9Vfglf3j053r
4YnTdcWM4sUyNzdLWFN6H3PmTtreaaopv8uKUhx0kWaRd8t+aBabzH6HRWP7GOTjzbDt871z
W9G3miHOQ/xwM1A0pM/TDA/7tTO9J1zVQc/h2B0GbFXnE8Vn3Bg7XoL5U+74fC+M4ejMR79w
sO8E9LuBWAK76LvjYFHOmDbS7jEhvzSssqvIL1c+Fwa+Hmum7WAf++hjD+4UWv+BLeZQLHVT
j4ICorCkhfcXTWwYCpEPAAA=

