Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWCFWA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWCFWA7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 17:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWCFWA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 17:00:59 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34281 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932369AbWCFWA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 17:00:58 -0500
Date: Mon, 6 Mar 2006 23:00:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Mateusz Berezecki <mateuszb@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: memory range R/W triggered breakpoints in kernel ?
Message-ID: <20060306220030.GC4836@elf.ucw.cz>
References: <aec8d6fc0603050900w7aa1f93due29e9c1cf87e9316@mail.gmail.com> <20060305231654.GB20768@kvack.org> <aec8d6fc0603051531o622d04bdjf2993729b0b946ca@mail.gmail.com> <20060305233202.GD20768@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060305233202.GD20768@kvack.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ne 05-03-06 18:32:02, Benjamin LaHaise wrote:
> On Mon, Mar 06, 2006 at 12:31:29AM +0100, Mateusz Berezecki wrote:
> > Yes but again this is userspace. I was thinking about solution used
> > back in the old days in SoftICE kernel level debugger.
> > It had a BPR command (breakpoint on range) which could monitor
> > up to 400000 bytes of memory range. Unfortunately for me this command
> > works in very old versions of _that_ other OS.
> 
> If it is in userspace, then you don't need anything from the kernel.  
> mprotect() and catch the resulting SIGSEGV.

SoftICE worked on kernel, too. Not sure how it was hacked up.

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
