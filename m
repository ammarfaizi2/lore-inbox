Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264959AbTGBM0W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 08:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264968AbTGBM0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 08:26:22 -0400
Received: from [66.212.224.118] ([66.212.224.118]:18186 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S264959AbTGBM0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 08:26:21 -0400
Date: Wed, 2 Jul 2003 08:29:36 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
Subject: Re: To make a function get executed on cpu2
In-Reply-To: <20030702122137.GA7562@suse.de>
Message-ID: <Pine.LNX.4.53.0307020824550.13565@montezuma.mastecende.com>
References: <E19XeSS-0008Rg-00@gondolin.me.apana.org.au>
 <Pine.LNX.4.53.0307020758001.13565@montezuma.mastecende.com>
 <20030702122137.GA7562@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jul 2003, Dave Jones wrote:

> See do_cpuid in arch/i386/kernel/cpuid.c for an example of how to do this
> properly. It's a bit icky, but works. I've considered writing a generic
> run_on_cpu() when I did the on_each_cpu() stuff, but asides from
> cpuid.c, msr.c was the only other case I could find from a quick
> grep around that really cared, so it didn't seem worth the effort.

I wrote come code which required such and ended up doing something 
similar. I also reckoned the actual function was generic enough i can't 
possibly be the only person needing such.

	Zwane
-- 
function.linuxpower.ca
