Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVGLQUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVGLQUf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 12:20:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVGLQSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 12:18:36 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:18609 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261572AbVGLQSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 12:18:18 -0400
Subject: Re: Real-Time Preemption Patch -RT-2.6.12-final-V0.7.51-26 failed
	,to compile
From: Steven Rostedt <rostedt@goodmis.org>
To: steve@keysounds.co.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <30280207$112117937442d3d6ee8b2c78.56547598@config8.schlund.de>
References: <30280207$112117937442d3d6ee8b2c78.56547598@config8.schlund.de>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 12 Jul 2005 12:18:10 -0400
Message-Id: <1121185090.6917.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-12 at 16:56 +0200, steve@keysounds.co.uk wrote:
> (From Steve Wooding at a different address) 
> 
> Thanks for the help Daniel, but it still doesn't compile. I now get the
> following compile error:
> 
> In file included from arch/x86_64/kernel/mce.c:17:
> include/linux/fs.h: In function `lock_super':
> include/linux/fs.h:828: warning: implicit declaration of function `down'
> include/linux/fs.h: In function `unlock_super':
> include/linux/fs.h:833: warning: implicit declaration of function `up'
> In file included from arch/x86_64/kernel/mce.c:18:
> include/linux/semaphore.h: At top level:
> include/linux/semaphore.h:26: error: conflicting types for 'down'
> include/linux/fs.h:828: error: previous implicit declaration of 'down'
> was here
> include/linux/semaphore.h:38: error: conflicting types for 'up'
> include/linux/fs.h:833: error: previous implicit declaration of 'up' was
> here
> include/linux/semaphore.h: In function `sem_is_locked':
> include/linux/semaphore.h:43: warning: implicit declaration of function
> `compat_sem_is_locked'
> make[1]: *** [arch/x86_64/kernel/mce.o] Error 1
> make: *** [arch/x86_64/kernel] Error 2
> 

Hi Steve,

I just took your config you had here (it would have been nicer to attach
it, since that makes it easier to copy, not to mention strip from
replies :-).  And I was able to compile Ingo's latest kernel with it,
without any problems.  What version are you using? I compiled 51-27.

-- Steve


