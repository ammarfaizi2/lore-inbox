Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264679AbSKDOOp>; Mon, 4 Nov 2002 09:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264682AbSKDOOp>; Mon, 4 Nov 2002 09:14:45 -0500
Received: from thunk.org ([140.239.227.29]:61854 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S264680AbSKDOOo>;
	Mon, 4 Nov 2002 09:14:44 -0500
Date: Mon, 4 Nov 2002 09:21:06 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: an updated post-halloween doc.
Message-ID: <20021104142105.GA9197@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021101204832.GA3718@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021101204832.GA3718@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 08:48:32PM +0000, Dave Jones wrote:
> EXT3 Htree support.
> ~~~~~~~~~~~~~~~~~~~
> - The ext3 filesystem has gained indexed directory support, which offers
>   considerable performance gains when used on filesystems with large directories.
> - In order to use the htree feature, you need at least version 1.29 of e2fsprogs.

Hi Dave,

Could you please change this to read version 1.30 of e2fsprogs?  There
were some rare conditions where e2fsck could get confused with htree
directories in e2fsprogs 1.29 that were fixed in 1.30.  None of the
htree-related e2fsck bugs in 1.29 were catastrophic in the sense of
causing data loss, but they might cause confusion and spurious kernel
bug reports.

Thanks!!

						- Ted
