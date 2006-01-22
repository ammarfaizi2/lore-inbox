Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWAVIR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWAVIR2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 03:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWAVIR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 03:17:28 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39377 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932226AbWAVIR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 03:17:26 -0500
Date: Sun, 22 Jan 2006 09:16:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-ID: <20060122081637.GA1543@elf.ucw.cz>
References: <200601212108.41269.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601212108.41269.a1426z@gawab.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 21-01-06 21:08:41, Al Boldi wrote:
> A long time ago, when i was a kid, I had dream. It went like this:
> 
> I am waking up in the twenty-first century and start my computer.
> After completing the boot sequence, I start top to find that my memory is 
> equal to total disk-capacity.  What's more, there is no more swap.
> Apps are executed inplace, as if already loaded.
> Physical RAM is used to cache slower storage RAM, much the same as the CPU 
> cache RAM caches slower physical RAM.

...and then you try to execute mozilla in place, and your dream slowly
turns into nightmare, as letters start to appear, pixel by pixel...

[swap is backing store for anonymous memory. Think about it. You need
swap as long as you support malloc. You could always provide filename
with malloc, but hey, that starts to look like IBM mainframe. Plus
ability to powercycle the machine and *have* it boot (not continue
where it left) is lifesaver.]
								Pavel

-- 
Thanks, Sharp!
