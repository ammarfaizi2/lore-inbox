Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWJCLYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWJCLYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 07:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWJCLYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 07:24:32 -0400
Received: from brick.kernel.dk ([62.242.22.158]:25143 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1750733AbWJCLYc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 07:24:32 -0400
Date: Tue, 3 Oct 2006 13:24:04 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: "Steven J. Hathaway" <shathawa@e-z.net>
Cc: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: Add "SAMSUNG CD-ROM SC-140" to ide-dma blacklist
Message-ID: <20061003112404.GL7778@kernel.dk>
References: <452021F4.79081F8F@e-z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452021F4.79081F8F@e-z.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01 2006, Steven J. Hathaway wrote:
> MS-Windows sees the CD-ROM ok.
> Linux V 2.4.21 and earlier see the CD-ROM ok.
> Linux V 2.4.24 and later fail to find a CD-ROM file system.
> The major ide code changed since 2.4.21.  I have since
> required the following patch in order for the kernel to
> see the CDROM.   Enclosed is a context diff patch file.
> 
> The problem appeared when I was trying to install a Slackware
> distribution.
> The bootstrap would load the kernel and initrd structure, but the
> kernel,
> once gaining control, would register file system errors when accessing
> the disk drive.  Seeing other related SAMSUNG CD-ROM drivers in the
> ide-dma.c blacklist, and adding my SAMSUNG CD-ROM device to the
> same blacklist, and rebuilding a kernel, the problem has been overcome.

Looks reasonable, applied.

-- 
Jens Axboe

