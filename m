Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287500AbSAPUqt>; Wed, 16 Jan 2002 15:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287508AbSAPUqk>; Wed, 16 Jan 2002 15:46:40 -0500
Received: from laibach.mweb.co.za ([196.2.53.177]:61317 "EHLO
	laibach.mweb.co.za") by vger.kernel.org with ESMTP
	id <S287500AbSAPUq1>; Wed, 16 Jan 2002 15:46:27 -0500
Subject: Re: Rik spreading bullshit about VM
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Andrea Arcangeli <andrea@suse.de>
Cc: LKM <linux-kernel@vger.kernel.org>
In-Reply-To: <20020116200459.E835@athlon.random>
In-Reply-To: <20020116200459.E835@athlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.11mdk 
Date: 16 Jan 2002 22:58:31 +0200
Message-Id: <1011214716.12126.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-16 at 21:04, Andrea Arcangeli wrote:
> 				
[---SNIP---]
> 3) Details of typical runs:
> 
> 2.4.7:

[---SNIP---]

> ------

> 
> c)
> meminfo during run:
>                total:    used:    free:  shared: buffers:  cached:
> Mem:  1051394048 1047044096  4349952 443473920  1052672 294608896
> Swap: 4294934528 1314680832 2980253696
> MemTotal:      1026752 kB
> MemFree:          4248 kB
> MemShared:      433080 kB <============== [1]
> Buffers:          1028 kB
> Cached:          20900 kB
> SwapCached:     266804 kB
> Active:         694700 kB
> Inact_dirty:     19296 kB
> Inact_clean:      7816 kB
> Inact_target:    12836 kB
> HighTotal:      131072 kB
> HighFree:         1460 kB
> LowTotal:       895680 kB
> LowFree:          2788 kB
> SwapTotal:     4194272 kB
> SwapFree:      2910404 kB
> NrSwapPages:    727602 pages
> 
> 
> ###################################################################
> 
> 2.4.14:
> --------
> 
[--SNIP--]
> c)
> meminfo during run:
>                total:    used:    free:  shared: buffers:  cached:
> Mem:  1052712960 1046528000  6184960        0   319488 856850432
> Swap: 4294934528 1313320960 2981613568
> MemTotal:      1028040 kB
> MemFree:          6040 kB
> MemShared:           0 kB <================ [2]
> Buffers:           312 kB
> Cached:         714576 kB
> SwapCached:     122192 kB
> Active:         851084 kB
> Inactive:       113592 kB
> HighTotal:      131072 kB
> HighFree:         2044 kB
> LowTotal:       896968 kB
> LowFree:          3996 kB
> SwapTotal:     4194272 kB
> SwapFree:      2911732 kB

Andrea your VM also works perfectly for me, and I think you are doing
a brilliant job on it. The only thing that I have noticed that worries
me is the lack of MemShared. I wass about to study the code and try to 
find out why it is always 0 kB on my PC, but these stats also show the
same results. Do you have any idea why this is so. I will still study
the code (just for the fun of it), maybe I might learn something about
te VM system.

	-Bongani

