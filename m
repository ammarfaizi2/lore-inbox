Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264499AbUGYVSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbUGYVSz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 17:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUGYVSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 17:18:55 -0400
Received: from posti5.jyu.fi ([130.234.4.34]:56757 "EHLO posti5.jyu.fi")
	by vger.kernel.org with ESMTP id S264499AbUGYVSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 17:18:53 -0400
Date: Mon, 26 Jul 2004 00:18:48 +0300 (EEST)
From: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
X-X-Sender: ptsjohol@silmu.st.jyu.fi
To: "Will S." <willgs00@cox.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <41041DED.2010609@cox.net>
Message-ID: <Pine.LNX.4.44.0407260011230.4510-100000@silmu.st.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Checked: by miltrassassin
	at posti5.jyu.fi; Mon, 26 Jul 2004 00:18:50 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2004, Will S. wrote:

> >I would say more like this is a pain in the ass. =) and I'm having a 
> >feeling that we will have to switch off from the rtl-8139 cards if nobody 
> >is willing to help us.
> I have an RTL-8139 on 100MBit/full-duplex and was by concidence copying 
> 110GB of data in roughly 300,000 files, some as big as 1GB, last night. 
> Three systems at once were pumping data into a single P4 1.4GHz with the 
> RTL-8139. The line was floored at 10MB/sec, and it ran for about 3.5 
> hours. I had no problems at all, and was using the P4 box (which triple 
> heads at high resolution) at the same time. Nothing broke, although it 
> felt quite a bit slower than usual :-)

=) I'm also using rtl-8139 cards at work and I haven't seen this kind of 
problems but I'm not using 2.6-series kernel in those machines. Good for 
you that you didn't have any problems.
 
> Kernel 2.6.8-rc1, ACPI and APIC fully enabled, NVidia accelerated 
> drivers loaded and in use by one of the three displays. Now that's what 
> I call a stress test :-) If there's anything outstanding with the 
> RTL-8139 driver, you'd think it would pop out under that kind of load. 
> One interesting thing is you both have AMD processors, and I have an 
> Intel CPU, but that might be unrelated.
> If it matters, this is on an ECS P4VXMS board - the RTL8139 is built-in.

Yeah, it might be some sort of a bug which is related to 
VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]-chipset and 
RTL-8139? Hard to say at this point. I'll get some other network cards 
tomorrow from the office and we will see if there is a difference. 

I hope that it's not the mobo (chipset). =)

--
Pasi Sjöholm 


