Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261993AbUCLHag (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 02:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUCLHag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 02:30:36 -0500
Received: from is.magroup.ru ([213.33.179.242]:45494 "EHLO is.magroup.ru")
	by vger.kernel.org with ESMTP id S261993AbUCLHae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 02:30:34 -0500
Date: Fri, 12 Mar 2004 10:30:09 +0300
From: Antony Dovgal <tony2001@phpclub.net>
To: Michael Schierl <schierlm@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM & device_power_up/down
Message-Id: <20040312103009.5fa38c94.tony2001@phpclub.net>
In-Reply-To: <404E206A.266ABD1C@gmx.de>
References: <1uQOH-4Z1-9@gated-at.bofh.it>
	<S261722AbUCFWoa/20040306224430Z+905@vger.kernel.org>
	<20040309101110.50b55786.tony2001@phpclub.net>
	<404E206A.266ABD1C@gmx.de>
X-Mailer: Sylpheed version 0.9.10cvs3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Mar 2004 07:30:09.0781 (UTC) FILETIME=[D95BC250:01C40803]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Mar 2004 20:52:10 +0100
Michael Schierl <schierlm@gmx.de> wrote:

> Are you using any modules or patches that are not in the main line
> kernel?
> Does your problem also occur when you build a "minimal" kernel (i.e.
> remove all things from it you don't really need for booting up, e.g.
> local apic, pcmcia, network support, framebuffer, mouse)?
> 
> can you boot with init=/bin/bash (or another shell) and then do 
> 
> mount /proc
> apm -s
> 
> does suspending work there? (this all against a "vanilla" kernel).
> 
> The thing above was just a guess, the only difference between the 2
> patches i know is that the patch which is in kernel also informs all
> device drivers. So i guess there must be a "broken" device driver that
> makes your supend come to a halt.

Michael, I didn't try it, because 2.6.4 solved all my problems =)
My laptop suspends & resumes correctly for now.
So, I think you were right, the problem was in some of device drivers, that failed to suspend correctly.

I can continue these experiments and I suppose we can find that driver finally if you're interested.
Do you?

---
WBR,
Antony Dovgal aka tony2001
tony2001@phpclub.net || antony@dovgal.com
