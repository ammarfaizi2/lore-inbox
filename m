Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263936AbUDFSQJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263939AbUDFSQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:16:09 -0400
Received: from web40506.mail.yahoo.com ([66.218.78.123]:32395 "HELO
	web40506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263936AbUDFSQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:16:04 -0400
Message-ID: <20040406181603.13828.qmail@web40506.mail.yahoo.com>
Date: Tue, 6 Apr 2004 11:16:03 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge 
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200404061618.i36GIHgW003419@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> 
> [...]
> 
> [...]
> 
> > No matter what particular LISP program does - it
> can't
> > crash the kernel - C code can do that easily.
> 
> If the policy check goes into an infinite loop, the
> kernel proper isn't
> technically crashed, but useless anyway. And if you
> can prove that can't
> happen, you just solved the halting problem.
> Congratulation!

My code works during system calls (before the real
one). Interrupts are enabled. If it enters the loop
scheduler still can switch tasks (using timer for
example). If it doesn't work in such way I can easily
call schedule(); implicitly after some time limit will
be reached - it's VM, so it's easy to do such things.

So, it's my pleasure to accept your congratulations
:-) Thanks.

Serge.

__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
