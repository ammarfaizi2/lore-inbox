Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265675AbSLCUgb>; Tue, 3 Dec 2002 15:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265657AbSLCUgb>; Tue, 3 Dec 2002 15:36:31 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:13718 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S265675AbSLCUga>; Tue, 3 Dec 2002 15:36:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: Jochen Hein <jochen@jochen.org>
Subject: Re: [2.5.50, ACPI] link error
Date: Tue, 3 Dec 2002 12:47:07 -0800
User-Agent: KMail/1.4.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <E18Ix71-0003ik-00@gswi1164.jochen.org> <200212031007.01782.EricAltendorf@orst.edu> <87znrn3q92.fsf@gswi1164.jochen.org>
In-Reply-To: <87znrn3q92.fsf@gswi1164.jochen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212031247.07284.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 December 2002 10:35, Jochen Hein wrote:
> Eric Altendorf <EricAltendorf@orst.edu> writes:
> > On Monday 02 December 2002 12:24, Jochen Hein wrote:
> >> When compiling 2.5.50 with CONFIG_ACPI_SLEEP=y
> >> I get:
> >>
> >> arch/i386/kernel/built-in.o(.data+0x1304): In function
> >
> > `do_suspend_lowlevel':
> >> : undefined reference to `save_processor_state'
> >>
> >> arch/i386/kernel/built-in.o(.data+0x130a): In function
> >
> > `do_suspend_lowlevel':
> >> : undefined reference to `saved_context_esp'
> >
> > Try turning on software suspend in the kernel hacking section.
>
> It is off (and has been all the time, AFAIR).

Right ... I'm no kernel hacker so I don't know why, but I can only get 
the recent kernels to compile with sleep states if I turn *ON* 
software suspend as well.  However, as soon as I turn on swsusp and 
get a compiled kernel, it oops'es on boot.

eric

-- 
"First they ignore you.  Then they laugh at you.
 Then they fight you.  And then you win."             -Gandhi
