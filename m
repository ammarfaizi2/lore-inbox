Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbTKWEX3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 23:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263267AbTKWEX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 23:23:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:32459 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263262AbTKWEX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 23:23:28 -0500
Date: Sat, 22 Nov 2003 20:23:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@muc.de>
cc: md@Linux.IT, <linux-kernel@vger.kernel.org>
Subject: Re: irq 15: nobody cared! with KT600 chipset and 2.6.0-test9
In-Reply-To: <m3vfpbiwir.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.44.0311222022120.2379-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 23 Nov 2003, Andi Kleen wrote:
> 
> It's a long standing bug in how we handle VIA on board devices in ACPI.
> It was a big problem on x86-64 too until I cheated and used only
> PIC mode when there is a VIA southbridge.

That doesn't explain the lack of autodetection, and the early irq15 
registration.

That would explain why no interrupts make it at all, but why do we not 
even probe for irq15 here?

		Linus

