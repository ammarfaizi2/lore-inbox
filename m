Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315479AbSGJKne>; Wed, 10 Jul 2002 06:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315485AbSGJKnd>; Wed, 10 Jul 2002 06:43:33 -0400
Received: from [195.223.140.120] ([195.223.140.120]:53549 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S315479AbSGJKnc>; Wed, 10 Jul 2002 06:43:32 -0400
Date: Wed, 10 Jul 2002 12:47:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrey Nekrasov <andy@spylog.ru>
Cc: linux.nics@intel.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19rc1aa2
Message-ID: <20020710104724.GS8878@dualathlon.random>
References: <20020708184149.GL8878@dualathlon.random> <20020710102031.GA3107@an.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020710102031.GA3107@an.local>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 02:20:31PM +0400, Andrey Nekrasov wrote:
> Hello Andrea Arcangeli,
> 
> 1. Hardware: M/B Intel "Tupelo" STL2.
>    Network card :
> 
> (/proc/pci)
> 
>   Bus  0, device   3, function  0:
>     Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 8).
>       IRQ 18.
>       Master Capable.  Latency=66.  Min Gnt=8.Max Lat=56.
>       Non-prefetchable 32 bit memory at 0xfb101000 [0xfb101fff].
>       I/O at 0x5400 [0x543f].
>       Non-prefetchable 32 bit memory at 0xfb000000 [0xfb0fffff].
> 
> 
> 2. from serial console:
> 
> ...
> Intel(R) PRO/100 Fast Ethernet Adapter - Loadable driver, ver 2.0.30-k1
> Copyright (c) 2002 Intel Corporation
> 
> hw init failed
> Failed to initialize e100, instance #0
> ...
> 
> 
> 3. 2.4.19rc1aa1 - work ok.
> 
> 4. My .config
> 
> ...
> # CONFIG_EEPRO100 is not set
> CONFIG_E100=y
> ...

I'm cc'ing linux.nics@intel.com. 2.4.19rc1aa1 had the 1.8.38 version of
the driver.

In short 1.8.38 works, and 2.0.30-k1 fails.

I would suggest to use the eepro100 driver while they fix the e100
driver.

thanks,

Andrea
