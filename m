Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVCGNv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVCGNv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 08:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVCGNv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 08:51:58 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:41961 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261165AbVCGNuw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 08:50:52 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
CC: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon,_07_Mar_2005_13_50_45_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20050307135045.8FD5077700@merlin.emma.line.org>
Date: Mon,  7 Mar 2005 14:50:45 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.280, 2005-03-07 13:47:46+01:00, samel@mail.cz
  shortlog: add 24 new translations and one correction

ChangeSet@1.279, 2005-03-04 03:36:51+01:00, matthias.andree@gmx.de
  Merge CVS <-> BK, dropping ID line which is sorta useless.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

##### GNUPATCH #####
--- 1.243/shortlog	2005-03-03 13:15:54 +01:00
+++ 1.245/shortlog	2005-03-07 13:47:06 +01:00
@@ -8,7 +8,6 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.327 2004/12/02 11:10:20 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -415,6 +414,7 @@
 'ben:fluff.org' => 'Ben Dooks',
 'ben:simtec.co.uk' => 'Ben Dooks',
 'bengen:hilluzination.de' => 'Hilko Bengen',
+'benh:au1.ibm.com' => 'Benjamin Herrenschmidt',
 'benh:kenrel.crashing.org' => 'Benjamin Herrenschmidt', # typo
 'benh:kernel.crashing.org' => 'Benjamin Herrenschmidt',
 'benh:zion.wanadoo.fr' => 'Benjamin Herrenschmidt',
@@ -437,6 +437,7 @@
 'bhards:bigpond.net.au' => 'Brad Hards',
 'bhavesh:avaya.com' => 'Bhavesh P. Davda',
 'bheilbrun:paypal.com' => 'Brad Heilbrun', # by himself
+'bill.irwin:oracle.com' => 'William Lee Irwin III',
 'bjoern:j3e.de' => 'Bjoern Jacke',
 'bjohnson:sgi.com' => 'Brian J. Johnson',
 'bjorn-helgaas:comcast.net' => 'Bjorn Helgaas',
@@ -502,11 +503,12 @@
 'bzolnier:trik.(none)' => 'Bartlomiej Zolnierkiewicz',
 'bzzz:gerasimov.net' => 'Alex Tomas',
 'bzzz:tmi.comex.ru' => 'Alex Tomas',
+'c-d.hailfinger.devel.2005:gmx.net' => 'Carl-Daniel Hailfinger',
 'c-d.hailfinger.kernel.2002-07:gmx.net' => 'Carl-Daniel Hailfinger',
 'c-d.hailfinger.kernel.2002-q4:gmx.net' => 'Carl-Daniel Hailfinger', # himself
 'c-d.hailfinger.kernel.2003:gmx.net' => 'Carl-Daniel Hailfinger', # himself
 'c-d.hailfinger.kernel.2004:gmx.net' => 'Carl-Daniel Hailfinger',
-'c.lucas@com.rmk.(none)' => 'Christophe Lucas',
+'c.lucas:com.rmk.(none)' => 'Christophe Lucas',
 'c.lucas:ifrance.com' => 'Christophe Lucas',
 'cagle:mindspring.com' => 'John Cagle', # Alan
 'calum.mackay:cdmnet.org' => 'Calum Mackay', # lbdb
@@ -527,8 +529,10 @@
 'cattelan:sgi.com' => 'Russell Cattelan', # google
 'cbajumpa:or8.net' => 'Chris Bajumpaa',
 'cborntra:de.ibm.com' => 'Christian Bornträger',
+'cbrake:com.rmk.(none)' => 'Cliff Brake',
 'ccaputo:alt.net' => 'Chris Caputo',
 'ccheney:cheney.cx' => 'Christopher L. Cheney',
+'ce:idtect.com' => 'Charles-Edouard Ruault',
 'cel:citi.umich.edu' => 'Chuck Lever',
 'cel:netapp.com' => 'Chuck Lever',
 'celso:bulma.net' => 'Celso González', # google
@@ -657,6 +661,7 @@
 'dave:qix.net' => 'Dave Maietta',
 'dave:thedillows.org' => 'David Dillow',
 'davej:codmonkey.org.uk' => 'Dave Jones', # not matched by regexp above
+'davej:delerium.kernelslacker.org' => 'Dave Jones',
 'davej:dhcp83-103.boston.redhat.com' => 'Dave Jones',
 'davej:hardwired.(none)' => 'Dave Jones',
 'davej:redhat.com' => 'Dave Jones', # lbdb
@@ -667,6 +672,7 @@
 'davem:hera.kernel.org' => 'David S. Miller',
 'davem:kernel.bkbits.net' => 'David S. Miller',
 'davem:netfilter.org' => 'David S. Miller',
+'davem:northbeach.davemloft.net.davemloft.net' => 'David S. Miller',
 'davem:nuts.davemloft.net' => 'David S. Miller',
 'davem:redhat.co' => 'David S. Miller',
 'davem:redhat.com' => 'David S. Miller',
@@ -1004,6 +1010,7 @@
 'greg:soap.kroah.net' => 'Greg Kroah-Hartman',
 'greg_aumann:sil.org' => 'Greg Aumann',
 'gregkh:kernel.bkbits.net' => 'Greg Kroah-Hartman',
+'gregkh:suse.de' => 'Greg Kroah-Hartman',
 'gregor_jan:seznam.cz' => 'Jan Gregor',
 'grigouze:noos.fr' => 'Mickaël Grigouze',
 'gronkin:nerdvana.com' => 'George Ronkin',
@@ -1075,6 +1082,7 @@
 'hero:persua.de' => 'Heiko Ronsdorf',
 'herry:sgi.com' => 'Herry Wiputra',
 'hfvogt:arcor.de' => 'Hans-Frieder Vogt',
+'hfvogt:gmx.net' => 'Hans-Frieder Vogt',
 'hifumi.hisashi:lab.ntt.co.jp' => 'Hisashi Hifumi',
 'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
 'hiroshi_doyu:montavista.co.jp' => 'Hiroshi Doyu',
@@ -1583,6 +1591,7 @@
 'liyang:nerv.cx' => 'Liyang Hu',
 'lklm:lengard.net' => 'Pascal Lengard',
 'lkml001:vrfy.org' => 'Kay Sievers',
+'lkml:einar-lueck.de' => 'Einar Lueck',
 'lkml:felipe-alfaro.com' => 'Felipe Alfaro Solana',
 'lkml:lievin.net' => 'Romain Liévin',
 'lkml:mathfillsmewithgreatjoy.com' => 'Michael Plump',
@@ -1627,6 +1636,7 @@
 'm.hunold:gmx.de' => 'Michael Hunold',
 'm:mbsks.franken.de' => 'Matthias Bruestle',
 'maalanen:ra.abo.fi' => 'Marcus Alanen',
+'maartendeprez:scarlet.be' => 'Maarten Deprez',
 'mac:melware.de' => 'Armin Schindler',
 'macro:ds2.pg.dga.pl' => 'Maciej W. Rozycki',
 'macro:ds2.pg.gda.pl' => 'Maciej W. Rozycki',
@@ -1641,6 +1651,7 @@
 'maillist:jg555.com' => 'Jim Gifford',
 'makisara:abies.metla.fi' => 'Kai Mäkisara',
 'makovick:kmlinux.fjfi.cvut.cz' => 'Jindrich Makovicka',
+'mallikarjuna.chilakala:intel.com' => 'Mallikarjuna R. Chilakala',
 'maloi:phota.to' => 'Andy Molloy',
 'malte.d:gmx.net' => 'Malte Doersam', # google
 'manand:us.ibm.com' => 'Mala Anand',
@@ -1657,6 +1668,7 @@
 'marcelo.tosatti:cyclades.com.br' => 'Marcelo Tosatti',
 'marcelo:conectiva.com.br' => 'Marcelo Tosatti',
 'marcelo:dhcp-103.cyclades.de' => 'Marcelo Tosatti',
+'marcelo:dmt.cnet' => 'Marcelo Tosatti',
 'marcelo:dmt.cyclades' => 'Marcelo Tosatti',
 'marcelo:freak.distro.conectiva' => 'Marcelo Tosatti', # guessed
 'marcelo:logos.cnet' => 'Marcelo Tosatti', # guessed
@@ -1701,6 +1713,7 @@
 'mashirle:us.ibm.com' => 'Shirley Ma',
 'mason:suse.com' => 'Chris Mason',
 'master:sectorb.msk.ru' => 'Vladimir B. Savkin',
+'mat.loikkanen:synopsys.com' => 'Mat Loikkanen',
 'mathieu:newview.com' => 'Mathieu Chouquet-Stringer',
 'matt_domsch:dell.com' => 'Matt Domsch', # sent by himself
 'matthew.e.tolentino:intel.com' => 'Matt Tolentino',
@@ -1864,6 +1877,7 @@
 'muizelaar:rogers.com' => 'Jeff Muizelaar',
 'mulix:actcom.co.il' => 'Muli Ben-Yehuda', # sent by himself
 'mulix:mulix.org' => 'Muli Ben-Yehuda',
+'muneda.takahiro:jp.fujitsu.com' => 'Muneda Takahiro',
 'mw:microdata-pos.de' => 'Michael Westermann',
 'my:post.utfors.se' => 'Mikael Ylikoski',
 'mzyngier:freesurf.fr' => 'Marc Zyngier',
@@ -2368,10 +2382,12 @@
 'shaggy:kleikamp.dyn.webahead.ibm.com' => 'Dave Kleikamp',
 'shaggy:shaggy.austin.ibm.com' => 'Dave Kleikamp', # lbdb
 'shahamit:gmx.net' => 'Amit Shah',
+'shaharf:voltaire.com' => 'Shahar Frank',
 'shai:ftcon.com' => 'Shai Fultheim',
 'shai:scalex86.org' => 'Shai Fultheim',
 'shaoh.li:gmail.com' => 'Li Shaohua',
 'shaohua.li:intel.com' => 'Li Shaohua',
+'shawn.starr:rogers.com' => 'Shawn Starr',
 'shbader:de.ibm.com' => 'Stefan Bader',
 'sheilds:msrl.com' => 'Michael Shields', # typo
 'shemminger:osdl.org' => 'Stephen Hemminger',
@@ -2403,6 +2419,7 @@
 'sl:lineo.com' => 'Stuart Lynne',
 'slansky:usa.net' => 'Petr Slansky',
 'sleddog:us.ibm.com' => 'Dave Boutcher',
+'slee:netengine1.com' => 'Soohoon Lee',
 'slpratt:austin.ibm.com' => 'Steven Pratt',
 'sluskyb:paranoiacs.org' => 'Ben Slusky',
 'sm0407:nurfuerspam.de' => 'Stefan Meyknecht',
@@ -2449,6 +2466,7 @@
 'stefan.becker:nokia.com' => 'Stefan Becker',
 'stefan.eletzhofer:eletztrick.de' => 'Stefan Eletzhofer',
 'stefan.macher:web.de' => 'Stefan Macher',
+'stefan:desire.ch' => 'Stefan Ott',
 'steiner:sgi.com' => 'Jack Steiner',
 'stekloff:w-stekloff.beaverton.ibm.com' => 'Daniel Stekloff',
 'stelian.pop:fr.alcove.com' => 'Stelian Pop',
@@ -2520,6 +2538,7 @@
 'takamiya:po.ntts.co.jp' => 'Noriaki Takamiya',
 'takata.hirokazu:renesas.com' => 'Hirokazu Takata',
 'takata:linux-m32r.org' => 'Hirokazu Takata',
+'takis:lumumba.luc.ac.be' => 'Panagiotis Issaris',
 'tali:admingilde.org' => 'Martin Waitz',
 'tao:acc.umu.se' => 'David Weinehall', # by himself
 'tao:kernel.org' => 'David Weinehall', # by himself
@@ -2576,6 +2595,7 @@
 'tinglett:vnet.ibm.com' => 'Todd Inglett',
 'tiwai:suse.de' => 'Takashi Iwai',
 'tj:home-tj.org' => 'Tejun Heo',
+'tklauser:nuerscht.ch' => 'Tobias Klauser',
 'tkooda-patch-kernel:devsec.org' => 'Thor Kooda',
 'tlnguyen:snoqualmie.dp.intel.com' => 'Tom L. Nguyen',
 'tmattox:engr.uky.edu' => 'Tim Mattox',
@@ -2696,6 +2716,7 @@
 'vs:namesys.com' => 'Vladimir Saveliev',
 'vs:tribesman.namesys.com' => 'Vladimir Saveliev',
 'vsu:altlinux.ru' => 'Sergey Vlasov',
+'vvs:sw.ru' => 'Vasily Averin',
 'wa:almesberger.net' => 'Werner Almesberger',
 'wahrenbruch:kobil.de' => 'Thomas Wahrenbruch',
 'waltabbyh:comcast.net' => 'Walt Holman',
@@ -2762,6 +2783,7 @@
 'ya:slamail.org' => 'Yaacov Akiba Slama',
 'yanmin.zhang:intel.com' => 'Yanmin Zhang',
 'yasuyuki.kozakai:toshiba.co.jp' => 'Yasuyuki Kozakai',
+'yekkim:pacbell.net' => 'Mickey Stein',
 'yi.zhu:intel.com' => 'Yi Zhu',
 'yinah:couragetech.com.cn' => 'Yin Aihua',
 'yoav.zach:intel.com' => 'Yoav Zach',
@@ -2776,6 +2798,7 @@
 'yuri:acronis.com' => 'Yuri Per', # lbdb
 'yust:anti-leasure.ru' => 'Alex Yustasov',
 'yuvalt:gmail.com' => 'Yuval Turgeman',
+'zach.brown:oracle.com' => 'Zach Brown',
 'zach:vmware.com' => 'Zachary Amsden',
 'zaitcev:redhat.com' => 'Pete Zaitcev',
 'zaitcev:yahoo.com' => 'Pete Zaitcev',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIADVcLEICA81X227bOBB9jr5igD5kF60V6m4Tm6JN0jbeJGiRtF1g32iJthhTpEFSdlP4
43dE2U7cy6LdbYHaBmxx5gxnzpmh5EcwPqMHTpslk5V9tuBq1goVOsOUbbhjYamb9WnN1Izf
cLeOCYnxHcUJybPROh7lWbbmMc+yMo3YpBgWvIyDR/DOckMPGuZcLZgNmaoM57h+rq2jB7Pm
Q1h1l9da4+WRbS0/mnOjuDw6ucDPoL8YOK2lDdDxDXNlDUtuLD2IwmS34u4WnB5cv3j17vL5
dRAcH8MuVzg+Dn5wXZ/U86yvYz9MRhKSRHGUYYA8zaMoOIMojIsRkOyIJEckBZLQJKdZ9JhE
lBD4clR4HMGABCfwg2s4DUq44mbG4fT9DfwxeAonF0+gMnqxEGqG3QBSKA6rWiC9woLVxjFA
gSS3NgwuAIsiafDmnuhg8J2vICCMBE/vK6t1wz8py9a4r9SzvqosGpIiLaLhOomKUbae8hGb
lgUZMcIrNqm+wuFelE6YlMRJnkUYBTUKvlnPLawv3es5JFs9C4gSmhY0zTd6WtZw+axhQobl
x58p47Y6CqyqIE5B8RX4sJI5oZUFrAs0qllqY3jZrXUCJkUa/WoC7pH2mW5FFKcFydc5GeUj
P+Zbj70p/99pBN/YR/2Ap+skw8T6hkjT7x5wAoPoFxzwfjhew8CsPnSfwQdsli0D/6FXzqII
vj5s/z6iPbXZp7NGvjJrcfbTKP2+EfN9+uMoHKdRjhweTriqKWujUEyarpJDOH4Khydc3bJG
KDjnmIOyZd2Iyh0+QVgy9DAhZSjMSiiqDSslv8f+hSbBGrjkHMadB4zH4w6KWnTQclCFNdI7
xd7hBgVbchl2UtFOP8VdH+aUGTk4Y0pwCec7d4xzlpEuhXH/dViGsi2Zpbh/aJp5+JtC7n7f
xKiNsE4vag6XnZPPIu5hE8Pm/MsoKaZTOOnsHpAQD+AUKUA97itF0Q22+OBFpVtmKrhuWSs9
S3nmN6nYkt/SCufAiLYJ+0cQ1LnEX6E2sz7MGXrBn7i/zy/Pd9CGKtS3nnBW1qFfkHrqOor2
r3ZhRAU3IVyhAJ6pcYSsdsFmhs/mNe0eipDv3v0VrsGF0awenDPjGqZ6ROHbop4u9cztK3KO
PTp4aQSvuIH3aPaAbJh2ADlvJOVCMTOQLS/nu31edGtIP655/7znv2G4KVcVXxj+kdqyY9KF
kw3oqrfCmTf3uDTucdhdc2ZuW4WTVwvJ5kwyKpTDLtopc/XAC65DvDFtHPtQ2SYFU3KpadWg
prsqr/pVeKstHi/CAwqy2duFUov5nCmuqL1TemHv7MNdHVxu7R44zD3/TavwZhA6TKEWRtPb
RThtb4Wz7QOw94G3G58OjsfWqIPbmmGnTelSS8eEeTBrN94CL/H4mPeIItkgViq0jhlDjca5
sXuYlYKbzuYhKfECWsk5RRbweMPDPHrgr3WttermuffP/DxYx6dMYXNbn1G9cfar8Nr55oiz
uDuoD7FwYalsm7aZsG5eQ1butH7DFJsJ7fDGMbaW4cT20KLw0Llkbffor1qsoqzdbqu3eoJn
P1z0do/JRx6zXFpqV6Fpe8f3zAp5B8/xWV94WeIi9yzd8flcNHTBygnH4+y+BQQO6B1SxLf+
fS4fuzmcGL36/ND7G014ZKAJAbv/EmWNXW/b5rjM8mIyzMrgH8wfymQdDQAA

