Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbTLYBVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 20:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbTLYBVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 20:21:42 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:56580 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264252AbTLYBVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 20:21:40 -0500
Subject: Re: 2.6.0-test11 data loss
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Keith Lea <keith@cs.oswego.edu>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <3FEA0C3C.9090601@cs.oswego.edu>
References: <3FEA0C3C.9090601@cs.oswego.edu>
Content-Type: text/plain
Message-Id: <1072315297.2423.22.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Thu, 25 Dec 2003 02:21:37 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-12-24 at 22:59, Keith Lea wrote:
> Hello, I'm not subscribed to this list. This is not a help request, and 
> not really a bug report, I just thought someone should know about this.
> 
> I installed the 2.6.0-beta11-mm kernel last week, and the other day my 
> computer locked up (this is normal on my laptop with every kernel 
> version I've tried, this isn't the problem I'm posting about). When I 
> restarted, many, many files that had been open when it locked up were 
> filled with garbage, or the contents of totally unrelated files. For 
> example, my syslog contained some KDE header file code, and 
> /sbin/modprobe contained 82kb of data that seemed like random noise. I 
> think each file was the same size as it was originally, just with 
> different data, but I'm not sure.
> 
> The corruption happened on two separate partitions on a single IDE 
> laptop drive, and both were ReiserFS 3.6 partitions. I don't know if 
> this is a kernel bug or a Reiser bug or something else, but I thought 
> the kernel developers should know about this, and be on the lookout for 
> similar things (hopefully with more informative bug reports than mine). 
> I'm sorry I don't have more information, but if anyone wants to know 
> more about my system I'd be glad to help.

I know this is not the answer you're looking for but, could you please
test again using 2.6.0 or 2.6.0-mm1? 2.6.0-test11 is a bit ouf of date
now that 2.6.0 has gone gold.

