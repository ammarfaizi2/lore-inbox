Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268942AbRHBOea>; Thu, 2 Aug 2001 10:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268945AbRHBOeU>; Thu, 2 Aug 2001 10:34:20 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:53265 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268942AbRHBOeI>; Thu, 2 Aug 2001 10:34:08 -0400
Subject: Re: kernel gdb for intel
To: baccala@freesoft.org (Brent Baccala)
Date: Thu, 2 Aug 2001 15:35:48 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <no.id> from "Brent Baccala" at Aug 02, 2001 03:01:50 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SJZk-0000hw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - doesn't support SMP, since I don't have an Intel SMP box.  I'd guess
> what you'd want it to do is an smp_call_function that would halt all the
> processors and put them into some tight little loop while gdb fiddles
> things.  ideas?

With the old old stuff (pre 2.0) gdb stubs I ended up with two copies, one
per cpu on two serial ports. I found that most useful since I could force
events to happen.

Looks nice to me but about the only way you are likely to get Linus to take
in kernel debugging patches is to turn them into hex and disguise them as USB 
firmware ;)

Alan
