Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268089AbTBMQfI>; Thu, 13 Feb 2003 11:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268091AbTBMQfI>; Thu, 13 Feb 2003 11:35:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35343 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268089AbTBMQfH>; Thu, 13 Feb 2003 11:35:07 -0500
Date: Thu, 13 Feb 2003 08:40:59 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: James Simmons <jsimmons@infradead.org>
cc: Vojtech Pavlik <vojtech@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] input: Get rid of kbd_pt_regs [5/14]
In-Reply-To: <Pine.LNX.4.44.0302131637340.20201-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.44.0302130840040.1470-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 13 Feb 2003, James Simmons wrote:
> 
> Actually why do we have this function in keyboard.c when we have 
> sysrq_handle_showregs in sysrq.c? Both do the same thing.

Because I still use the old approach, and I want that keyboard thing to 
work on all kernels, regardless of whether they have sysrq compiled in or 
not.

		Linus

