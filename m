Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWAUWVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWAUWVN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 17:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWAUWVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 17:21:13 -0500
Received: from waste.org ([64.81.244.121]:41638 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751206AbWAUWVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 17:21:12 -0500
Date: Sat, 21 Jan 2006 16:22:20 -0600
From: Matt Mackall <mpm@selenic.com>
To: Shaun Savage <savages@tvlinux.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: CBD Compressed Block Device, New embedded block device
Message-ID: <20060121222220.GA4032@waste.org>
References: <43D3467C.7010803@tvlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D3467C.7010803@tvlinux.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 12:46:52AM -0800, Shaun Savage wrote:
> HI
> 
> Here is a patch for 2.6.14.5 of CBD
> CBD is a compressed block device that is designed to shrink the file 
> system size to 1/3 the original size.  CBD is a block device on a file 
> system so, it also allows for in-field upgrade of file system.  If 
> necessary is also allows for secure booting, with a GRUB patch.

How does it work? Does it remap one block device and present it as a
new one? Or does it work more like loopback? In either case, we might
prefer a device mapper plug-in.

Please add a brief write-up under Documentation/, including a general
overview and example usage so we can get some idea of what this
actually does. Or URLs to existing docs, of course.

-- 
Mathematics is the supreme nostalgia of our time.
