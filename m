Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131723AbRCONuz>; Thu, 15 Mar 2001 08:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131722AbRCONup>; Thu, 15 Mar 2001 08:50:45 -0500
Received: from zeus.kernel.org ([209.10.41.242]:32721 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131721AbRCONuf>;
	Thu, 15 Mar 2001 08:50:35 -0500
Date: Thu, 15 Mar 2001 16:23:46 +0100 (CET)
From: Ketil Froyn <ketil@froyn.com>
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Is swap == 2 * RAM a permanent thing?
In-Reply-To: <Pine.LNX.4.33.0103150720100.757-100000@asdf.capslock.lan>
Message-ID: <Pine.LNX.4.30.0103151610230.12994-100000@pccn3.uio.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Mike A. Harris wrote:

> Is the fact that we're supposed to use double the RAM size as
> swap a permanent thing or a temporary annoyance that will get
> tweaked/fixed in the future at some point during 2.4.x perhaps?

You're not supposed to do anything, that's just a general rule of thumb.
If your system hardly ever swaps, use a swapfile, because speed doesn't
matter a lot anyway.

> Would it be better to make part of RAM a ramdisk and swap to
> that?

No, don't do that. Physical memory is better than swap. Swap is a backup
for physical memory, so that you can run programs that use more memory
than you have. You don't really *need* swap, linux works fine without.

Ketil


