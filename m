Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVFYWP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVFYWP2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 18:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVFYWP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 18:15:28 -0400
Received: from waste.org ([216.27.176.166]:4029 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261357AbVFYWPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 18:15:21 -0400
Date: Sat, 25 Jun 2005 15:15:16 -0700
From: Matt Mackall <mpm@selenic.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ndevfs - a "nano" devfs
Message-ID: <20050625221516.GD14426@waste.org>
References: <20050624081808.GA26174@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050624081808.GA26174@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 01:18:08AM -0700, Greg KH wrote:
> Now I just know I'm going to regret this somehow...
> 
> Anyway, here's yet-another-ramfs-based filesystem, ndevfs.  It's a very
> tiny:
> $ size fs/ndevfs/inode.o 
>    text    data     bss     dec     hex filename
>    1571     200       8    1779     6f3 fs/ndevfs/inode.o
> replacement for devfs for those embedded users who just can't live
> without the damm thing.  It doesn't allow subdirectories, and only uses
> LSB compliant names.  But it works, and should be enough for people to
> use, if they just can't wean themselves off of the idea of an in-kernel
> fs to provide device nodes.
> 
> Now, with this, is there still anyone out there who just can't live
> without devfs in their kernel?
> 
> Damm, the depths I've sunk to these days, I'm such a people pleaser...

Hmm. I'm not pleased. Perhaps you're pleasing the wrong people?

What we really need is a short HOWTO that covers:

- Do you really need a dynamic /dev?
- How to embed a static /dev in your embedded kernel with initramfs
- How to add a dynamic /dev to your kernel with udev

-- 
Mathematics is the supreme nostalgia of our time.
