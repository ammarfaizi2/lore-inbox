Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278227AbRJSAP5>; Thu, 18 Oct 2001 20:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278229AbRJSAPs>; Thu, 18 Oct 2001 20:15:48 -0400
Received: from [208.129.208.52] ([208.129.208.52]:13580 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S278227AbRJSAPf>;
	Thu, 18 Oct 2001 20:15:35 -0400
Date: Thu, 18 Oct 2001 17:22:12 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "David E. Weekly" <dweekly@legato.com>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Compile in tmpfs crumples in 2.4.12 w/epoll patch
In-Reply-To: <016a01c15831$ef51c5c0$5c044589@legato.com>
Message-ID: <Pine.LNX.4.40.0110181720370.970-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2001, David E. Weekly wrote:

> Hey all,
>
> I was trying to speed up kernel compiles experimentally by moving the source
> tree into tmpfs and compiling there. It seemed to work okay and crunched
> through the dep phase and most of the main build phase just fine, but then
> it hit a file, got an internal segfault, and stopped. I tried again -- this
> time make itself segfaulted. Three more times of make segfaulting -- a
> strace on make didn't reveal what was failing. Then strace started
> segfaulting. Eventually "ls" segfaulted and the machine needed to be
> manually rebooted. Ouch!
>
> I ran the full memtest86 suite on the machine, and it passed with flying
> colors. So the memory proper is okay.
>
> I come to one of two conclusions: this is a wierd problem with my north
> bridge, or there's something funky going on with tmpfs.
>
> Is tmpfs stable?

Or, is /dev/epoll stable ? :)
I'm running it both on UP and 2 way SMP w/o problems from July.
Just try w/o /dev/epoll



- Davide


