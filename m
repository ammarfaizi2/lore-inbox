Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287895AbSA3Bly>; Tue, 29 Jan 2002 20:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287924AbSA3Blk>; Tue, 29 Jan 2002 20:41:40 -0500
Received: from 12-249-40-19.client.attbi.com ([12.249.40.19]:1028 "EHLO
	rekl.dyn.dhs.org") by vger.kernel.org with ESMTP id <S287895AbSA3BlM>;
	Tue, 29 Jan 2002 20:41:12 -0500
Date: Tue, 29 Jan 2002 19:41:09 -0600 (CST)
From: rob2@rekl.dyn.dhs.org
To: linux-kernel@vger.kernel.org
Subject: Execssive network errors 2.4.18pre (tx error or tx frame is busy)
Message-ID: <Pine.LNX.4.40.0201291935200.527-100000@rekl.dyn.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I've seen the following on both 2.4.18pre4 and 2.4.18pre7+preempt:
Lots & lots of these get warnings/errors get printed to the console and
syslog, and I don't know why.  i586, eth0 is a natsemi at 10Mbs half
duplex, eth1 is a natsemi at 100Mbs full duplex, eth2 is an Orinoco silver
in adhoc mode.  I didn't have this issue before I had 2.4.18pre4.  I
haven't noticed anything not "working", except my syslog is getting filled
up.

More output, including .config and dmesg output is available at
http://rekl.yi.org/lk_help/

Please cc: me on replies, since I'm not subscribed.  Thanks.


eth0: tx frame #1359 is busy.
eth0: tx frame #1359 is busy.
eth0: tx frame #1360 is busy.
eth2: Tx error, status 4 (FID=0192)
eth0: tx frame #1368 is busy.
eth0: tx frame #1370 is busy.
eth0: tx frame #1372 is busy.
eth2: Tx error, status 4 (FID=0156)
eth1: tx frame #3832 is busy.
eth2: Tx error, status 4 (FID=0156)
eth2: Tx error, status 4 (FID=01E2)
eth2: Tx error, status 4 (FID=0192)
eth1: tx frame #4105 is busy.
eth1: tx frame #4108 is busy.
eth1: tx frame #4115 is busy.
eth1: tx frame #4119 is busy.



