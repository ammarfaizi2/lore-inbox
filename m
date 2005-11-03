Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030514AbVKCVyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030514AbVKCVyg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030515AbVKCVyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:54:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29970 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030514AbVKCVyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:54:36 -0500
Date: Thu, 3 Nov 2005 22:54:25 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ben-s3c2410@fluff.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] cleanup include/asm-arm/arch-s3c2410/system.h
Message-ID: <20051103215425.GA7724@stusta.de>
References: <20051103181916.GE23366@stusta.de> <20051103184126.GK28038@flint.arm.linux.org.uk> <20051103212949.GM23366@stusta.de> <20051103214941.GM28038@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103214941.GM28038@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 09:49:41PM +0000, Russell King wrote:
> On Thu, Nov 03, 2005 at 10:29:51PM +0100, Adrian Bunk wrote:
> > On Thu, Nov 03, 2005 at 06:41:26PM +0000, Russell King wrote:
> > > On Thu, Nov 03, 2005 at 07:19:16PM +0100, Adrian Bunk wrote:
> > > > Can anyone please explain the contents of 
> > > > include/asm-arm/arch-s3c2410/system.h ?
> > > > 
> > > > This file looks like a C file accidentially named .h ...
> > > 
> > > It's the machine specific bits for arch/arm/kernel/process.c, part of
> > > the structure left over from 1996ish time.
> > > 
> > > The functions in there are supposed to be inlined.
> > 
> > IOW, the (untested) patch below changes them to what was intended?
> 
> Yes.  Ben's away for a bit - can we wait for his ack please?

OK, this is not urgent.

> Russell King

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

