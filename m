Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVEZGlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVEZGlR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 02:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVEZGlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 02:41:16 -0400
Received: from dvhart.com ([64.146.134.43]:49059 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261223AbVEZGkH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 02:40:07 -0400
Date: Wed, 25 May 2005 23:40:08 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc5-mm1
Message-ID: <176910000.1117089608@[10.10.2.4]>
In-Reply-To: <175590000.1117089446@[10.10.2.4]>
References: <175590000.1117089446@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--"Martin J. Bligh" <mbligh@mbligh.org> wrote (on Wednesday, May 25, 2005 23:37:26 -0700):

> Build failure on numaq:
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/numaq

I take that back ... it's actually every ia32 machine I have that 
fails to build ...

M.

> In file included from include/linux/sched.h:12,
>                  from arch/i386/kernel/asm-offsets.c:7:
> include/linux/jiffies.h:42:3: #error You lose.
> include/linux/jiffies.h:213:31: division by zero in #if
> include/linux/jiffies.h:213:31: division by zero in #if
> include/linux/jiffies.h:213:31: division by zero in #if
> include/linux/jiffies.h:213:31: division by zero in #if
> include/linux/jiffies.h:213:31: division by zero in #if
> include/linux/jiffies.h:213:31: division by zero in #if
> include/linux/jiffies.h:213:31: division by zero in #if
> include/linux/jiffies.h:213:31: division by zero in #if
> include/linux/jiffies.h:213:31: division by zero in #if
> include/linux/jiffies.h:213:31: division by zero in #if
> include/linux/jiffies.h:213:31: division by zero in #if
> include/linux/jiffies.h:213:31: division by zero in #if
> include/linux/jiffies.h:213:31: division by zero in #if
> include/linux/jiffies.h:213:31: division by zero in #if
> include/linux/jiffies.h:213:31: division by zero in #if
> include/linux/jiffies.h:213:31: division by zero in #if
> include/linux/jiffies.h:257:30: division by zero in #if
> In file included from include/linux/sched.h:12,
>                  from arch/i386/kernel/asm-offsets.c:7:
> include/linux/jiffies.h: In function `jiffies_to_msecs':
> include/linux/jiffies.h:262: error: `CONFIG_HZ' undeclared (first use in this function)
> include/linux/jiffies.h:262: error: (Each undeclared identifier is reported only once
> include/linux/jiffies.h:262: error: for each function it appears in.)
> include/linux/jiffies.h:268:36: division by zero in #if
> include/linux/jiffies.h: In function `jiffies_to_usecs':
> include/linux/jiffies.h:273: error: `CONFIG_HZ' undeclared (first use in this function)
> include/linux/jiffies.h:281:30: division by zero in #if
> include/linux/jiffies.h: In function `msecs_to_jiffies':
> include/linux/jiffies.h:286: error: `CONFIG_HZ' undeclared (first use in this function)
> include/linux/jiffies.h:294:36: division by zero in #if
> include/linux/jiffies.h: In function `usecs_to_jiffies':
> include/linux/jiffies.h:299: error: `CONFIG_HZ' undeclared (first use in this function)
> include/linux/jiffies.h: In function `timespec_to_jiffies':
> include/linux/jiffies.h:318: error: `CONFIG_HZ' undeclared (first use in this function)
> include/linux/jiffies.h:324: error: `SHIFT_HZ' undeclared (first use in this function)
> include/linux/jiffies.h: In function `jiffies_to_timespec':
> include/linux/jiffies.h:337: error: `CONFIG_HZ' undeclared (first use in this function)
> include/linux/jiffies.h: In function `timeval_to_jiffies':
> include/linux/jiffies.h:359: error: `CONFIG_HZ' undeclared (first use in this function)
> include/linux/jiffies.h:363: error: `SHIFT_HZ' undeclared (first use in this function)
> include/linux/jiffies.h: In function `jiffies_to_timeval':
> include/linux/jiffies.h:375: error: `CONFIG_HZ' undeclared (first use in this function)
> include/linux/jiffies.h:385:6: division by zero in #if
> include/linux/jiffies.h:385:6: division by zero in #if
> include/linux/jiffies.h:385:6: division by zero in #if
> include/linux/jiffies.h:385:6: division by zero in #if
> include/linux/jiffies.h:385:6: division by zero in #if
> include/linux/jiffies.h:385:6: division by zero in #if
> include/linux/jiffies.h:385:6: division by zero in #if
> include/linux/jiffies.h:385:6: division by zero in #if
> include/linux/jiffies.h:385:6: division by zero in #if
> include/linux/jiffies.h:385:6: division by zero in #if
> include/linux/jiffies.h:385:6: division by zero in #if
> include/linux/jiffies.h:385:6: division by zero in #if
> include/linux/jiffies.h:385:6: division by zero in #if
> include/linux/jiffies.h:385:6: division by zero in #if
> include/linux/jiffies.h:385:6: division by zero in #if
> include/linux/jiffies.h:385:6: division by zero in #if
> include/linux/jiffies.h: In function `jiffies_to_clock_t':
> include/linux/jiffies.h:386: error: `CONFIG_HZ' undeclared (first use in this function)
> include/linux/jiffies.h: In function `clock_t_to_jiffies':
> include/linux/jiffies.h:397: error: `CONFIG_HZ' undeclared (first use in this function)
> include/linux/jiffies.h:416:6: division by zero in #if
> include/linux/jiffies.h:416:6: division by zero in #if
> include/linux/jiffies.h:416:6: division by zero in #if
> include/linux/jiffies.h:416:6: division by zero in #if
> include/linux/jiffies.h:416:6: division by zero in #if
> include/linux/jiffies.h:416:6: division by zero in #if
> include/linux/jiffies.h:416:6: division by zero in #if
> include/linux/jiffies.h:416:6: division by zero in #if
> include/linux/jiffies.h:416:6: division by zero in #if
> include/linux/jiffies.h:416:6: division by zero in #if
> include/linux/jiffies.h:416:6: division by zero in #if
> include/linux/jiffies.h:416:6: division by zero in #if
> include/linux/jiffies.h:416:6: division by zero in #if
> include/linux/jiffies.h:416:6: division by zero in #if
> include/linux/jiffies.h:416:6: division by zero in #if
> include/linux/jiffies.h:416:6: division by zero in #if
> include/linux/jiffies.h: In function `jiffies_64_to_clock_t':
> include/linux/jiffies.h:417: error: `CONFIG_HZ' undeclared (first use in this function)
> make[1]: *** [arch/i386/kernel/asm-offsets.s] Error 1
> make: *** [arch/i386/kernel/asm-offsets.s] Error 2
> 05/25/05-20:57:45 Build the kernel. Failed rc = 2
> 05/25/05-20:57:45 build: kernel build Failed rc = 1


