Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268257AbUHKWC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268257AbUHKWC6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268262AbUHKWC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:02:57 -0400
Received: from gprs214-50.eurotel.cz ([160.218.214.50]:3458 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268257AbUHKWCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:02:46 -0400
Date: Wed, 11 Aug 2004 23:59:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Matt Mackall <mpm@selenic.com>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH][2.6] Completely out of line spinlocks / i386
Message-ID: <20040811215915.GA21812@elf.ucw.cz>
References: <Pine.LNX.4.58.0408072123590.19619@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408072123590.19619@montezuma.fsmlabs.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Pulled from the -tiny tree, the focus of this patch is for reduced kernel
> image size but in the process we benefit from improved cache performance
> since it's possible for the common text to be present in cache. This is
> probably more of a win on shared cache multiprocessor systems like
> P4/Xeon HT. It's been benchmarked with bonnie++ on 2x and 4x PIII (my
> ideal target would be a 4x+ logical cpu Xeon).
> 
> The bonnie++ results are here, the hostnames are of the form stpN-000 with
> N denoting how many processors in the system. In a nutshell there doesn't
> appear to be any performance regressions.

Fine, so perhaps we do not want config option?
									Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
