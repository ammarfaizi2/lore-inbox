Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265268AbUFAVCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265268AbUFAVCc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265356AbUFAVCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:02:00 -0400
Received: from [213.146.154.40] ([213.146.154.40]:13286 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265263AbUFAVBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:01:16 -0400
Date: Tue, 1 Jun 2004 22:01:10 +0100 (BST)
From: jsimmons@pentafluge.infradead.org
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: keyboard problem with 2.6.6
In-Reply-To: <xb7aczq9he1.fsf@savona.informatik.uni-freiburg.de>
Message-ID: <Pine.LNX.4.56.0406012158530.23458@pentafluge.infradead.org>
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de>
 <20040530111847.GA1377@ucw.cz> <xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de>
 <20040530124353.GB1496@ucw.cz> <xb7aczq9he1.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.3 (/)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (0.3 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 NO_REAL_NAME           From: does not include a real name
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>     Vojtech> No. I'm just saying - if you want something that's not in
>     Vojtech> the kernel drivers, just write a driver for it. But the
>     Vojtech> driver must be able to coexist with the other drivers.
> 
> It's easier to write a mouse  driver in userspace than in kernel.  But
> with the  input system  in 2.6, I  am *forced*  to write it  in kernel
> space, and  reboot and  reboot and reboot  when it oops.   Writing the
> driver in kernel  space, I at most get a segfault.   Plus I cannot use
> everything from glibc.  It simply  takes more time and energy to write
> a kernel space driver.

Why not use UML (user mode linux). Jon Smirl was using it to work on fbdev 
drivers in userland. Interrupts where tricky to handle but it might 
work fine now. I have to give it a try again. Once it is setup you can 
develope kernel driver in userland.
