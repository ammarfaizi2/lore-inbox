Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVAMKNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVAMKNd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 05:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVAMKNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 05:13:32 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:23493 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261514AbVAMKNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:13:21 -0500
Subject: Re: [PATCH] Fix a bug in timer_suspend() on x86_64
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050113100838.GA3525@elf.ucw.cz>
References: <20050106002240.00ac4611.akpm@osdl.org>
	 <200501130002.37311.rjw@sisk.pl>
	 <1105572485.2941.1.camel@desktop.cunninghams>
	 <200501130159.16818.rjw@sisk.pl>  <20050113100838.GA3525@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1105611296.7661.3.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 13 Jan 2005 21:14:56 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-01-13 at 21:08, Pavel Machek wrote:
> Hi!
> 
> > This patch is intended to fix a bug in timer_suspend() on x86_64 that causes 
> > hard lockups on suspend with swsusp and provide some optimizations.  It is 
> > based on the Nigel Cunningham's patches to to reduce delay in 
> > arch/kernel/time.c.  The patch is against 2.6.10-mm3 and 2.6.11-rc1.  Please 
> > consider for applying.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Acked-by: Pavel Machek.

Acked-by: Nigel Cunningham

(If that's worth anything :>)

-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

