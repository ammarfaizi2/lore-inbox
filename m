Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281776AbRKWOZm>; Fri, 23 Nov 2001 09:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281560AbRKWOZc>; Fri, 23 Nov 2001 09:25:32 -0500
Received: from [195.63.194.11] ([195.63.194.11]:37906 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S281776AbRKWOZQ>; Fri, 23 Nov 2001 09:25:16 -0500
Message-ID: <3BFE5A02.76AE6DF8@evision-ventures.com>
Date: Fri, 23 Nov 2001 15:15:30 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Updated parameter and modules rewrite (2.4.14)
In-Reply-To: <E166p1R-0004ll-00@wagner>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> 
> Hi all,
> 
>    http://ftp.kernel.org/pub/linux/kernel/people/rusty
> 
>         Unified boot/module parameter and module loader rewrite
> updated to 2.4.14.  I'm off to Linux Kongress, so I'll be difficult to
> contact for 10 days or so.
> 
> Main TODOS:
>         1) Should the PARAM() macros also declare the variables?
>                 Lots of people seem to like writing INT_MODULE_PARM macros...
> 
>         2) Need a less-sucky /proc|/proc/sys patch, to add access to
>            parameters through that.


I did have a look at it and I would like to express my full
encouragements
to yours efforts. Finally somebody out there caring about modularization
of the kernel, who doesn't continuously introduce sick stuff like...

We remember:

1. Highjacking System V IPC for autoloader communication.

2. "Persistant module storage" patches, which destabilize the
   kernel.

3. inter_module* idiocy.

4. Overloaded system calls.
