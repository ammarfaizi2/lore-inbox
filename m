Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130079AbRCHWjK>; Thu, 8 Mar 2001 17:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130089AbRCHWjA>; Thu, 8 Mar 2001 17:39:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35846 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S130079AbRCHWiw>;
	Thu, 8 Mar 2001 17:38:52 -0500
Date: Thu, 8 Mar 2001 22:33:19 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Brian Dushaw <dushaw@munk.apl.washington.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: Linux kernel - and regular sync'ing?
Message-ID: <20010308223319.A25679@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.30.0103071959050.17257-100000@munk.apl.washington.edu> <E14azEv-0002qR-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14azEv-0002qR-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Mar 08, 2001 at 12:09:51PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2001 at 12:09:51PM +0000, Alan Cox wrote:
> To quote the linux on palmax page
> 
>    For startup my /etc/rc.d/rc.local contains the following lines.
> mount -o remount,rw,noatime /
> /sbin/hdparm -S 15 /dev/hda

Or else place "noatime" in /etc/fstab, which is probably the better
place for it.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html
