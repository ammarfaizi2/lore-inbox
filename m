Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319008AbSHFHti>; Tue, 6 Aug 2002 03:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319010AbSHFHth>; Tue, 6 Aug 2002 03:49:37 -0400
Received: from mail.hometree.net ([212.34.181.120]:17083 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP
	id <S319008AbSHFHth>; Tue, 6 Aug 2002 03:49:37 -0400
To: linux-kernel@vger.kernel.org
Path: forge.intermeta.de!not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: Fragment flooding in 2.4.x/2.5.x
Date: Tue, 6 Aug 2002 07:53:13 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <ainv99$nj1$1@forge.intermeta.de>
References: <15694.33047.965504.346909@charged.uio.no> <15695.3634.832970.240016@charged.uio.no>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1028620393 20538 212.34.181.4 (6 Aug 2002 07:53:13 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Tue, 6 Aug 2002 07:53:13 +0000 (UTC)
X-Copyright: (C) 1996-2002 Henning Schmiedehausen
X-No-Archive: yes
X-Newsreader: NN version 6.5.1 (NOV)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

>>>>>> " " == kuznet  <kuznet@ms2.inr.ac.ru> writes:

>     > Hello!
>    >> the bug has already been known to crash a few servers...

>     > Sorry? What crash do you speak about?

>You'll find it documented on RedHat's Bugzilla (can't remember the
>exact reference - sorry). Basically the first RH-7.3 kernels were
>causing a DOS on a couple of Netapps w/ Gigabit connections.

You didn't exactly need a NetApp for this. A RH 7.3 NFS client with a
Solaris 2.6 NFSv3 server box and a switched, trunked 100 MBit network
was very very sufficient. I have the mrtg printouts still on the wall
in my office. 46 hours of solid 93 Mbits/sec of fragmented NFS packets
chewing off traffic on its VLAN and dropping everything else out of
the backbone trunks. Every service and their grandmothers died around
here. :-)

Ah, the joys of NFS.

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen       -- Geschaeftsfuehrer
INTERMETA - Gesellschaft fuer Mehrwertdienste mbH     hps@intermeta.de

Am Schwabachgrund 22  Fon.: 09131 / 50654-0   info@intermeta.de
D-91054 Buckenhof     Fax.: 09131 / 50654-20   
