Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267248AbSLKSF5>; Wed, 11 Dec 2002 13:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267252AbSLKSF4>; Wed, 11 Dec 2002 13:05:56 -0500
Received: from havoc.daloft.com ([64.213.145.173]:23272 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267248AbSLKSF4>;
	Wed, 11 Dec 2002 13:05:56 -0500
Date: Wed, 11 Dec 2002 13:13:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 Changes doc update.
Message-ID: <20021211181337.GD2612@gtf.org>
References: <20021211172559.GA8613@suse.de> <20021211175810.GC2612@gtf.org> <20021211180719.GB10008@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211180719.GB10008@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 06:07:19PM +0000, Dave Jones wrote:
> On Wed, Dec 11, 2002 at 12:58:10PM -0500, Jeff Garzik wrote:
>  > I think the coolest things (to me) of the new build system need to be
>  > noted too,
>  > 
>  > - "make" is now the preferred target; it does <arch-zimage> and modules.
>  > - "make -jN" is now the preferred parallel-make execution.  Do not
>  >   bother to provide "MAKE=xxx".
> 
> Yup. Added. Thanks.
> Something else that I've noticed (but not found documented) is that
> make dep seems to be automagickly done somewhen. An explicit make dep
> takes about a second, and doesn't seem to do much at all.

I would check with Kai on that... IIRC there _is_ a purpose to "make
dep", creating some file that's needed before the build process begins.
Maybe that's fixed now...

