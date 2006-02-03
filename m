Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWBCLWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWBCLWI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 06:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWBCLWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 06:22:08 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30169 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932382AbWBCLWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 06:22:07 -0500
Date: Fri, 3 Feb 2006 12:21:30 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: nigel@suspend2.net, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [ 00/10] [Suspend2] Modules support.
Message-ID: <20060203112130.GG2830@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602022131.59928.nigel@suspend2.net> <20060202115907.GH1884@elf.ucw.cz> <200602022214.52752.nigel@suspend2.net> <20060202152316.GC8944@ucw.cz> <20060202132708.62881af6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060202132708.62881af6.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Čt 02-02-06 13:27:08, Andrew Morton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
>
> Random thoughts:
> 
> - swsusp has been a multi-year ongoing source of churn and bug reports. 
>   It hasn't been a big success and we have a way to go yet.

You don't get the success reports, only bug reports. It tends to work
these days. I don't get success reports, too, but I'm not flooded with
bugreports for distribution, either. (And actually see people using
suspend2/swsusp).

> - People seem to be doing too much development on the swsusp core and not
>   enough development out where the actual problems are: drivers which don't
>   suspend and resume correctly.

We only started developing swsusp core again at 11/2005. Problem with
drivers is that I mostly do not have affected hardware. [Okay, there
are some problems with Core Duo I can reproduce here, smp-only, but
the machine is flakey, anyway, so it will take some time.]

> - If you want my cheerfully uninformed opinion, we should toss both of
>   them out and implement suspend3, which is based on the kexec/kdump
>   infrastructure.  There's so much duplication of intent here that it's not
>   funny.  And having them separate like this weakens both in the area where
>   the real problems are: drivers.

I thought about it (at around 11/2005), but loosing 8+ MB of ram,
permanently, is perhaps too big price to pay?
								Pavel
-- 
Thanks, Sharp!
