Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbVAMTyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbVAMTyc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 14:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbVAMTvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 14:51:43 -0500
Received: from mail.suse.de ([195.135.220.2]:1772 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261466AbVAMTrf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 14:47:35 -0500
Date: Thu, 13 Jan 2005 20:47:34 +0100
From: Andi Kleen <ak@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ncunningham@linuxmail.org, Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] Fix a bug in timer_suspend() on x86_64
Message-ID: <20050113194734.GC20738@wotan.suse.de>
References: <20050106002240.00ac4611.akpm@osdl.org> <200501130002.37311.rjw@sisk.pl> <1105572485.2941.1.camel@desktop.cunninghams> <200501130159.16818.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501130159.16818.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 01:59:16AM +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> This patch is intended to fix a bug in timer_suspend() on x86_64 that causes 
> hard lockups on suspend with swsusp and provide some optimizations.  It is 
> based on the Nigel Cunningham's patches to to reduce delay in 
> arch/kernel/time.c.  The patch is against 2.6.10-mm3 and 2.6.11-rc1.  Please 
> consider for applying.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Thanks, Added to my tree.

-Andi

