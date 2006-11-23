Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933539AbWKWKi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933539AbWKWKi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 05:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933561AbWKWKi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 05:38:56 -0500
Received: from tornado.reub.net ([203.222.131.131]:46557 "EHLO
	tornado.reub.net") by vger.kernel.org with ESMTP id S933539AbWKWKiz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 05:38:55 -0500
Message-ID: <45657A41.2040400@reub.net>
Date: Thu, 23 Nov 2006 21:38:57 +1100
From: Reuben Farrelly <reuben-linuxkernel@reub.net>
User-Agent: Thunderbird 2.0b1pre (Windows/20061121)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc6-mm1
References: <20061123021703.8550e37e.akpm@osdl.org>
In-Reply-To: <20061123021703.8550e37e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/11/2006 9:17 PM, Andrew Morton wrote:
> Temporarily at
> 
> http://userweb.kernel.org/~akpm/2.6.19-rc6-mm1/
> 
> and will appear later at
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm1/
> 
> 
> 
> - Added per-task I/O accounting via netlink, or via /proc/pid/io.  It
>   attempts to show how much physical I/O a task has caused, or shall cause.

Minor glitch:

   CC      arch/x86_64/kernel/ioport.o
   CC      arch/x86_64/kernel/ldt.o
   CC      arch/x86_64/kernel/setup.o
   CC      arch/x86_64/kernel/i8259.o
   CC      arch/x86_64/kernel/sys_x86_64.o
   CC      arch/x86_64/kernel/x8664_ksyms.o
   CC      arch/x86_64/kernel/i387.o
   CC      arch/x86_64/kernel/syscall.o
   CC      arch/x86_64/kernel/vsyscall.o
arch/x86_64/kernel/vsyscall.c: In function 'vsyscall_init':
arch/x86_64/kernel/vsyscall.c:310: error: 'cpu_vsyscall_notifier' undeclared 
(first use in this function)
arch/x86_64/kernel/vsyscall.c:310: error: (Each undeclared identifier is 
reported only once
arch/x86_64/kernel/vsyscall.c:310: error: for each function it appears in.)
make[1]: *** [arch/x86_64/kernel/vsyscall.o] Error 1
make: *** [arch/x86_64/kernel] Error 2
[root@tornado linux-mm]#


gcc version 4.1.1 20061120 (Red Hat 4.1.1-39)

.config is up at http://www.reub.net/files/kernel/configs/2.6.19-rc6-mm1

Reuben


