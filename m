Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbTDNR30 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 13:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263579AbTDNR30 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 13:29:26 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:14609 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263577AbTDNR3Z (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 13:29:25 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Joe Korty <joe.korty@ccur.com>, Robert Love <rml@tech9.net>
Subject: Re: [PATCH] 2.4 preemption bug in bh_kmap_irq
Date: Mon, 14 Apr 2003 19:40:14 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <20030414172730.GA17451@rudolph.ccur.com>
In-Reply-To: <20030414172730.GA17451@rudolph.ccur.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200304141938.26328.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 April 2003 19:27, Joe Korty wrote:

Hi Joe,

> The below patch compiles and boots ide=nodma on my preempt 2.4 kernel
> on the one motherboard that had the problem.  Before this patch, the
> kernel would not even boot for that motherboard.  I also applied and
> test booted a pure 2.4.21-pre5 kernel with this patch.
> The patch implements my preference for simplicity, so you may want to
> take some other approach if maximal performance is what you want.
yep, and here is the problem ^^^^^^^^. Your patch seems ok but is horribly 
slow. I've tried it first the day you submitted the patch. It's even alot 
slower than w/o Preempt or CONFIG_PREEMPT to no.

My Celeron 1,3GHz with 512 MB RAM felt like good old 486SX/25 while doing,
for example, a kernel compilation :(

ciao, Marc


