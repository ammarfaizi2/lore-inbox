Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbVAMKIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVAMKIy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 05:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261513AbVAMKIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 05:08:54 -0500
Received: from gprs215-81.eurotel.cz ([160.218.215.81]:21160 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261304AbVAMKIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:08:52 -0500
Date: Thu, 13 Jan 2005 11:08:39 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ncunningham@linuxmail.org
Subject: Re: [PATCH] Fix a bug in timer_suspend() on x86_64
Message-ID: <20050113100838.GA3525@elf.ucw.cz>
References: <20050106002240.00ac4611.akpm@osdl.org> <200501130002.37311.rjw@sisk.pl> <1105572485.2941.1.camel@desktop.cunninghams> <200501130159.16818.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501130159.16818.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch is intended to fix a bug in timer_suspend() on x86_64 that causes 
> hard lockups on suspend with swsusp and provide some optimizations.  It is 
> based on the Nigel Cunningham's patches to to reduce delay in 
> arch/kernel/time.c.  The patch is against 2.6.10-mm3 and 2.6.11-rc1.  Please 
> consider for applying.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Pavel Machek.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
