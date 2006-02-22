Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWBVP1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWBVP1r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 10:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWBVP1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 10:27:47 -0500
Received: from soundwarez.org ([217.160.171.123]:19891 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751337AbWBVP1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 10:27:46 -0500
Date: Wed, 22 Feb 2006 16:27:43 +0100
From: Kay Sievers <kay.sievers@suse.de>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Greg KH <gregkh@suse.de>, Adrian Bunk <bunk@stusta.de>,
       Robert Love <rml@novell.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: 2.6.16-rc4: known regressions
Message-ID: <20060222152743.GA22281@vrfy.org>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org> <20060217231444.GM4422@stusta.de> <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com> <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost> <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0602220905330.12374@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2006 at 09:06:10AM +0200, Pekka J Enberg wrote:
> On Tue, 21 Feb 2006, Kay Sievers wrote:
> > > 033b96fd30db52a710d97b06f87d16fc59fee0f1 is first bad commit
> > > diff-tree 033b96fd30db52a710d97b06f87d16fc59fee0f1 (from 0f76e5acf9dc788e664056dda1e461f0bec93948)
> > > Author: Kay Sievers <kay.sievers@suse.de>
> > > Date:   Fri Nov 11 06:09:55 2005 +0100
> > > 
> > >     [PATCH] remove mount/umount uevents from superblock handling
> 
> On Wed, Feb 22, 2006 at 12:51:01AM +0200, Pekka Enberg wrote:
> > Upgrade HAL, it's too old for that kernel.
> 
> It's what Gentoo stable is carrying. Thou shalt not break userspace!

Well, that's part of the contract by using an experimental version of HAL,
it has nothing to do with the kernel, as long as it's under
construction, you need to follow the latest releases. There is no
other way to do it, cause nobody can get complex software right in the
first place. So if that's a problem, don't depend on HAL until we
release a 1.0 version which will give you the needed stability. Just bug
the gentoo packager to catch up, cause there are more dependencies
anyway, not only a specific kernel version. And we don't fix any
bugs in any experimental version before 1.0, so please just help moving that
project faster forward by using the latest version, if you want to use
HAL.

Kay
