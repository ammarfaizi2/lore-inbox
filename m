Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318995AbSHFFbh>; Tue, 6 Aug 2002 01:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318998AbSHFFbh>; Tue, 6 Aug 2002 01:31:37 -0400
Received: from leela.mcs.anl.gov ([140.221.8.226]:10909 "EHLO
	leela.mcs.anl.gov") by vger.kernel.org with ESMTP
	id <S318995AbSHFFbg>; Tue, 6 Aug 2002 01:31:36 -0400
Date: Tue, 6 Aug 2002 00:35:08 -0500
From: Robert Latham <robl@mcs.anl.gov>
To: linux-kernel@vger.kernel.org
Subject: tigon3: 2466 and bad performance at 32bits/33mhz ?
Message-ID: <20020806053508.GJ25554@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a 3com 3C996B-T (copper) and a tyan 2466 motherboard.  The
kernel is 2.4.19-rc1-ac2, and i'm using the tg3 v0.99 (Jun 11, 2002).

When i run the 3C996B-T in the 64-bit/66-MHz slot, i get great
performance.  When i run the card in the 32-bit/66-MHz slot, i get
pretty bad performance.  Here's a netpipe graph to demonstrate:

http://www-unix.mcs.anl.gov/~robl/storage_box/tg3-32_33.2.png

The fast curve is with the 3c996B-T in the 64/66 slot.  It peaks out
around 850 Mbps.  The slow curve is the same card in the 32/33 slot.
It peaks around 180 Mbps.

Is a maximum throughput of ~180 MBits/sec all that can be hoped for?  I
don't have the hardware to verify, but 
http://www.cs.uni.edu/~gray/gig-over-copper/#3Com%203c996BT:|outline
offers the datapoint of 436 MBits/sec in an oldish dell optiplex ( old
being whenever p3 500 mhz machines were still made)

So, am i looking at a hardware limitation?  driver quirk?  I'm open to
any suggestions.  

I'll keep an eye on the web archives, but please CC me on any replies.

thanks
==rob

-- 
Rob Latham
Mathematics and Computer Science Division    A215 0178 EA2D B059 8CDF
Argonne National Labs, IL USA                B29D F333 664A 4280 315B
