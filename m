Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283064AbRK1OKN>; Wed, 28 Nov 2001 09:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283058AbRK1OJg>; Wed, 28 Nov 2001 09:09:36 -0500
Received: from [139.85.108.65] ([139.85.108.65]:58310 "EHLO rpppc1.hns.com")
	by vger.kernel.org with ESMTP id <S283057AbRK1OIw>;
	Wed, 28 Nov 2001 09:08:52 -0500
To: linux-kernel@vger.kernel.org
Subject: 3c905 problem
From: nbecker@fred.net
Date: 28 Nov 2001 09:08:47 -0500
Message-ID: <x88ofln7ztc.fsf@rpppc1.hns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to bother you with a stupid question, but I don't know enough to
understand this.

I moved a machine which has a 3c905 connected to a linksys autosense
10/100 hub.  I set no options on the 3c905 module.

I get millions of dreaded:

 Nov 28 08:58:15 adglinux1 kernel:   9: @cf2b3440  length 800005ea status 000105ea
Nov 28 08:58:15 adglinux1 kernel:   10: @cf2b3480  length 800005ea status 000105ea
Nov 28 08:58:15 adglinux1 kernel:   11: @cf2b34c0  length 800005ea status 000105ea
Nov 28 08:58:15 adglinux1 kernel:   12: @cf2b3500  length 800005ea status 000105ea
Nov 28 08:58:15 adglinux1 kernel:   13: @cf2b3540  length 800005ea status 000105ea
Nov 28 08:58:15 adglinux1 kernel:   14: @cf2b3580  length 80000043 status 00010043
Nov 28 08:58:15 adglinux1 kernel:   15: @cf2b35c0  length 80000043 status 00010043
Nov 28 08:58:15 adglinux1 kernel: eth0: Transmit error, Tx status register 82.
Nov 28 08:58:15 adglinux1 kernel: Probably a duplex mismatch.  See Documentation/networking/vortex.txt
Nov 28 08:58:15 adglinux1 kernel:   Flags; bus-master 1, dirty 77261(13) current 77263(15)

What exactly does this mean?  How do I fix it?  I have looked at
Documentation/networking/vortex.txt, but I don't know what this
HDX/FDX means exactly, and how works with a hub or switch.  Would my
problem be fixed by replacing the hub with a "switch"?

