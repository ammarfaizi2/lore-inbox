Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRCOWge>; Thu, 15 Mar 2001 17:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129112AbRCOWgZ>; Thu, 15 Mar 2001 17:36:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3597 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129066AbRCOWgP>;
	Thu, 15 Mar 2001 17:36:15 -0500
Date: Thu, 15 Mar 2001 22:34:53 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Peter DeVries <peter@devries.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Drvie Corruption CONSTANTLY with Linux and KT7-RAID
Message-ID: <20010315223453.B7500@flint.arm.linux.org.uk>
In-Reply-To: <200103151420.JAA03185@gloworm.cnchost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103151420.JAA03185@gloworm.cnchost.com>; from peter@devries.tv on Thu, Mar 15, 2001 at 06:20:24AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2001 at 06:20:24AM -0800, Peter DeVries wrote:
> Please help.. I'm at the end of my rope with this now.
>  I have rebuilt this system and corupted my drive at
> least 30 times now.  I have a ABIT KT7-RAID and no
> matter what I do with any kernel 2.2.16 - 2.4.2-ac19
> as soon as I turn on DMA mode the drive starts to
> corrupt and becomes useless.  The corruption happens
> alot faster in 2.4xxx than the 2.2.xxx kernels.  

Do you notice any programs getting SEGVs?  If they do, it could be bad
RAM.

Personally, when I come across a machine which behaves oddly, the first
thing I'd try is checking the memory.  You can get a copy of memtest86
for doing this.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

