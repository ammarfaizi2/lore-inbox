Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262555AbVAJWzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbVAJWzY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 17:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbVAJWvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 17:51:49 -0500
Received: from gprs214-230.eurotel.cz ([160.218.214.230]:384 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262595AbVAJWul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:50:41 -0500
Date: Mon, 10 Jan 2005 23:32:14 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rajsekar <raj--cutme--sekar@cse.iDELTHISitm.ernet.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCHED_BATCH not stopped (swsusp fails)
Message-ID: <20050110223213.GC1343@elf.ucw.cz>
References: <m3oeg1uk1y.fsf@rajsekar.pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3oeg1uk1y.fsf@rajsekar.pc>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> SCHED_BATCH processes dont seem to heed the `stop' request (order?) by
> swsusp.  I run httpd and mysqld (for my wiki page) with SCHED_BATCH (so
> that I can work on my computer even if the load is very high) but when I
> try to suspend the system, it tries to stop the tasks and simply returns.
> Here is the dmesg output (paritial)

Aha, so if it mysqld is not running SCHED_BATCH priority, stopping
mysqld will work ok?
								Pavel

> #dmesg
> ....
> ....
> Stopping tasks: =======================================
>  stopping tasks failed (20 tasks remaining)
> Restarting tasks...<6> Strange, mysqld not stopped
>  Strange, mysqld not stopped
>  Strange, mysqld not stopped
>  Strange, mysqld not stopped


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
