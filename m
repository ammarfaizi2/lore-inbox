Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281483AbRLLR1Y>; Wed, 12 Dec 2001 12:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281541AbRLLR1O>; Wed, 12 Dec 2001 12:27:14 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:62366 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S281483AbRLLR1F>; Wed, 12 Dec 2001 12:27:05 -0500
Date: Wed, 12 Dec 2001 10:26:32 -0700
Message-Id: <200112121726.fBCHQWu15088@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Matt <matt@bodgit-n-scarper.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] LVM and (I think) devfs
In-Reply-To: <20011212170921.A25596@mould.bodgit-n-scarper.com>
In-Reply-To: <20011212170921.A25596@mould.bodgit-n-scarper.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matt@bodgit-n-scarper.com writes:
> Just started playing with LVM, (with devfs), and I've found I can reproduce
> the attached oops consistently doing the following:
> 
> # vgchange -a y
> # vgchange -a n
> # vgchange -a y
> 
> Once this happens, the lvm becomes unreponsive and requires a reboot to
> activate it again.
> 
> It looks like the oops happens in devfs_open().
> 
> I'm using 2.4.17-pre8 with LVM 1.0.1, and the kernel driver from
> that package.

Please try kernel 2.4.16 and see if the problem persists. There were
devfs and minor LVM changes since then. Make sure you at least Cc: me.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
