Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287208AbSAHLRK>; Tue, 8 Jan 2002 06:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287283AbSAHLRB>; Tue, 8 Jan 2002 06:17:01 -0500
Received: from oflmta02bw.bigpond.com ([139.134.6.23]:31424 "EHLO
	oflmta02bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S287208AbSAHLQw>; Tue, 8 Jan 2002 06:16:52 -0500
Date: Tue, 8 Jan 2002 20:14:51 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Matt Dainty <matt@bodgit-n-scarper.com>
Cc: rgooch@ras.ucalgary.ca, hpa@zytor.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] DevFS support for /dev/cpu/X/(cpuid|msr)
Message-Id: <20020108201451.088f7f99.rusty@rustcorp.com.au>
In-Reply-To: <20020108111302.A14860@mould.bodgit-n-scarper.com>
In-Reply-To: <20020106181749.A714@butterlicious.bodgit-n-scarper.com>
	<200201061934.g06JYnZ15633@vindaloo.ras.ucalgary.ca>
	<3C38BC6B.7090301@zytor.com>
	<200201062108.g06L8lM17189@vindaloo.ras.ucalgary.ca>
	<3C38BD32.6000900@zytor.com>
	<200201070131.g071VrM20956@vindaloo.ras.ucalgary.ca>
	<3C38FAB0.4000503@zytor.com>
	<200201070140.g071ewk21192@vindaloo.ras.ucalgary.ca>
	<20020108111302.A14860@mould.bodgit-n-scarper.com>
X-Mailer: Sylpheed version 0.6.6 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jan 2002 11:13:02 +0000
Matt Dainty <matt@bodgit-n-scarper.com> wrote:

> On Sun, Jan 06, 2002 at 06:40:58PM -0700, Richard Gooch wrote:
> > 
> > So I'd like to propose a new file (say kernel/smp.c) which has generic
> > startup code for each CPU. To start with, it can have a
> > generic_cpu_init() function, which is called by each arch. Note that
> > this function would be called for the boot CPU too.
> 
> Would this also be hacked into whatever Hotswap CPU support exists? Such

We use /proc/sys/cpu/#/.  I don't understand what /dev/cpu/xxx is supposed to
do.

It's unfortunate that /proc/sys and /proc suck so hard that good coders go
to great lengths to do anything else [see previous /proc/sys patches].

Rusty.
-- 
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
