Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbVIBQ4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbVIBQ4d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 12:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVIBQ4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 12:56:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54793 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750721AbVIBQ4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 12:56:32 -0400
Date: Fri, 2 Sep 2005 17:56:23 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Con Kolivas <kernel@kolivas.org>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050902175623.D6546@flint.arm.linux.org.uk>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>, vatsa@in.ibm.com,
	linux-kernel@vger.kernel.org, akpm@osdl.org,
	ck list <ck@vds.kolivas.org>
References: <20050831165843.GA4974@in.ibm.com> <20050831171211.GB4974@in.ibm.com> <200509030143.57782.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200509030143.57782.kernel@kolivas.org>; from kernel@kolivas.org on Sat, Sep 03, 2005 at 01:43:57AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 01:43:57AM +1000, Con Kolivas wrote:
> Ok I've resynced all the patches with 2.6.13-mm1, made some cleanups and minor 
> modifications. As pm timer is the only supported timer for dynticks I've also 
> made it depend on it.
> 
> A rollup patch against 2.6.13-mm1 is here:
> 
> http://ck.kolivas.org/patches/dyn-ticks/2.6.13-mm1-dtck1.patch
> 
> also available in the dyn-ticks directory are the older patches and these 
> split out patches posted here.

Are you guys going to sync your interfaces with what ARM has, or are
we going to have two differing dyntick interfaces in the kernel, one
for ARM and one for x86?

I mentioned this before.  I seem to be ignored.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
