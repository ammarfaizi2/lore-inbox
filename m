Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267243AbSLKRub>; Wed, 11 Dec 2002 12:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267245AbSLKRua>; Wed, 11 Dec 2002 12:50:30 -0500
Received: from havoc.daloft.com ([64.213.145.173]:15336 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267243AbSLKRu2>;
	Wed, 11 Dec 2002 12:50:28 -0500
Date: Wed, 11 Dec 2002 12:58:10 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 Changes doc update.
Message-ID: <20021211175810.GC2612@gtf.org>
References: <20021211172559.GA8613@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211172559.GA8613@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 05:25:59PM +0000, Dave Jones wrote:
> Kernel build system.
> ~~~~~~~~~~~~~~~~~~~~
> - Versus 2.4, the build system has been much improved.
>   You should notice quicker builds, and less spontaneous rebuilds
>   of files on subsequent builds from already built trees.
> - make xconfig now requires the qt libraries.
> - Make menuconfig/oldconfig has no user-visible changes other than speed,
>   whilst numerous improvements have been made.
> - Several new debug targets exist: 'allyesconfig' 'allnoconfig' 'allmodconfig'.
> - For infomation: The above improvements are not CML2 / kbuild-2.5 related.

I think the coolest things (to me) of the new build system need to be
noted too,

- "make" is now the preferred target; it does <arch-zimage> and modules.
- "make -jN" is now the preferred parallel-make execution.  Do not
  bother to provide "MAKE=xxx".

