Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262590AbRE3CH6>; Tue, 29 May 2001 22:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262564AbRE3CHs>; Tue, 29 May 2001 22:07:48 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:1297 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S262568AbRE3CHh>; Tue, 29 May 2001 22:07:37 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Leif Sawyer <lsawyer@gci.com>
cc: linux kernel mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5 -ac series broken on Sparc64 
In-Reply-To: Your message of "Tue, 29 May 2001 16:30:46 PST."
             <BF9651D8732ED311A61D00105A9CA3150446E125@berkeley.gci.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 30 May 2001 12:07:29 +1000
Message-ID: <13472.991188449@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2001 16:30:46 -0800, 
Leif Sawyer <lsawyer@gci.com> wrote:
>include/linux/irq.h:61: asm/hw_irq.h: No such file or directory
>*** [sched.o] Error 1

You must run make {old,menu,x}config first to define the asm -> asm-$(ARCH)
symlink.

