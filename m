Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267559AbUBRV0E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 16:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268146AbUBRV0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 16:26:03 -0500
Received: from ns.suse.de ([195.135.220.2]:31181 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267559AbUBRVYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 16:24:35 -0500
Date: Thu, 19 Feb 2004 03:55:36 +0100
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Enable Intel AGP on x86-64
Message-Id: <20040219035536.2b5cc4fa.ak@suse.de>
In-Reply-To: <20040218204406.GB6242@redhat.com>
References: <200402182006.i1IK6bL7022634@hera.kernel.org>
	<20040218202325.GZ6242@redhat.com>
	<20040219021149.519d0754.ak@suse.de>
	<20040218204406.GB6242@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Feb 2004 20:44:06 +0000
Dave Jones <davej@redhat.com> wrote:

> On Thu, Feb 19, 2004 at 02:11:49AM +0100, Andi Kleen wrote:
> 
>  > > Please don't do this. At least copy intel-agp.c to
>  > > something new and throw out all the dozens of chipsets
>  > > that will never appear on ia32e.
>  > > 
>  > > Splitting agpgart up to seperate drivers allowed us
>  > > to stop adding cruft upon cruft with each generation
>  > > of chipsets.  I don't want to have to spend half of
>  > > 2.7 decrufting agpgart again.
>  > 
>  > Huh? Did you actually read the patch?
> 
> Yes, did you actually read my mail?

I guess I had expected it to make more sense, but it didn't.

> 
>  > It doesn't change the AGP driver at all, just enables it in Kconfig because
>  > Intel chipsets can be now used on the x86-64 kernel too.
> 
> You *really* think you're going to see a 440BX GART on ia32e ?
> i810 ? i820 ? i830 ? etc. etc. I'd be *very* surprised if anything
> but the current generation of ia32 chipsets gets used on ia32e.
> It just doesn't make sense.
> 
> Without even looking at the code I'll bet you can shrink it
> by at least 75%.

Feel free to do that. I don't have any plans to hack the Intel AGP driver
right now. 

-Andi

