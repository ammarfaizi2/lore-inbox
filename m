Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130531AbRDCQOe>; Tue, 3 Apr 2001 12:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130317AbRDCQOX>; Tue, 3 Apr 2001 12:14:23 -0400
Received: from p18-max2.adl.ihug.com.au ([203.173.184.210]:3857 "EHLO
	ocdi.sb101.org") by vger.kernel.org with ESMTP id <S130470AbRDCQOI>;
	Tue, 3 Apr 2001 12:14:08 -0400
Date: Wed, 4 Apr 2001 01:43:15 +0930 (CST)
From: Trevor Nichols <ocdi@ocdi.org>
X-X-Sender: <data@ocdi.sb101.org>
To: <linux-kernel@vger.kernel.org>
Subject: Re: uninteruptable sleep
In-Reply-To: <E14kRuT-0008Bc-00@the-village.bc.nu>
Message-ID: <Pine.BSF.4.33.0104040122330.63187-100000@ocdi.sb101.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Its a kernel bug if it gets stuck like this. You need to provide more info
> though - what file system, what devices, how much memory. Also ps can give you
> the wait address of a process stuck in 'D' state which is valuable for debug

System specs:
Pentium 200 MMX
80MB RAM

2 IDE Drives:
SAMSUNG SV0844D 8.4GB
WDC AC21200H 1.2GB

All partitions are ext2 filesytems.

ps xl:
  F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME  COMMAND
040  1000  1230     1   9   0 24320    4 down_w D    ?          0:00  /home/data/mozilla/obj/dist/bin/mozi

[I'm not exactly sure how to get the wait address if it isn't shown above]

Other stuff:

Creative SB AWE64 PnP
16MB Voodoo 3 2000 and a 2MB S3 Virge display
RealTek RTL-8029 NIC
Sony CRX100E Burner

I'm running X in a dual-head configuration using the above 2 cards.
That's all I can think of at this time.

Thanks,
Trevor Nichols.

