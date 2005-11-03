Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030511AbVKCVts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030511AbVKCVts (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbVKCVts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:49:48 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49421 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030511AbVKCVtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:49:47 -0500
Date: Thu, 3 Nov 2005 21:49:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: ben-s3c2410@fluff.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] cleanup include/asm-arm/arch-s3c2410/system.h
Message-ID: <20051103214941.GM28038@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>, ben-s3c2410@fluff.org,
	linux-kernel@vger.kernel.org
References: <20051103181916.GE23366@stusta.de> <20051103184126.GK28038@flint.arm.linux.org.uk> <20051103212949.GM23366@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103212949.GM23366@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 10:29:51PM +0100, Adrian Bunk wrote:
> On Thu, Nov 03, 2005 at 06:41:26PM +0000, Russell King wrote:
> > On Thu, Nov 03, 2005 at 07:19:16PM +0100, Adrian Bunk wrote:
> > > Can anyone please explain the contents of 
> > > include/asm-arm/arch-s3c2410/system.h ?
> > > 
> > > This file looks like a C file accidentially named .h ...
> > 
> > It's the machine specific bits for arch/arm/kernel/process.c, part of
> > the structure left over from 1996ish time.
> > 
> > The functions in there are supposed to be inlined.
> 
> IOW, the (untested) patch below changes them to what was intended?

Yes.  Ben's away for a bit - can we wait for his ack please?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
