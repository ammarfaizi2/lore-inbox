Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267003AbSLPSb1>; Mon, 16 Dec 2002 13:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbSLPSb0>; Mon, 16 Dec 2002 13:31:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:42990 "EHLO
	VL-MS-MR002.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S267049AbSLPSaw>; Mon, 16 Dec 2002 13:30:52 -0500
Date: Mon, 16 Dec 2002 13:30:16 -0500
From: Xavier LaRue <paxl@videotron.ca>
Subject: L2 Cache problem
To: linux-kernel@vger.kernel.org
Message-id: <20021216133016.64c75cac.paxl@videotron.ca>
MIME-version: 1.0
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

My linux kernel did'nt detect my L2 cache on any of my two cpu ( this is an smp box ) here is the /proc/cpuinfo:
Therse processor are perfect Steping match SL3FJ( therse old katmai processor have 512k l2 cache ).

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 549.070
cache size      : 32 KB
[...]
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 549.070
cache size      : 32 KB

And I get nothing in my dmesg about l2 cache ( 'dmesg | grep L2' give nothing )
I'm on an plain vanilla kernel ( 2.4.18 taken at kernel.org ) with xfs-1.1 patch.
At boot my bios say that my L2 of my two cpu are ok.

my dmesg will be online at http://paxl.no-ip.org/~paxl/dmesg.txt if somone mind.


Another fuzzy thing .. compiling my kernel normaly ( -j 1 ) take 30min and when I make it with -j 2/8/16 it take 25min, I think this is due to my L2 cache problem but that not normal, if somone have an idea.. I should be realy interested.

Another little detail that could help you, my mother board is an AMI MegaRUM II(that a dual p2/p3 mobo).

I hope somone will have an solution.
Thank you for your time
Xavier LaRue

