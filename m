Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbTDMCvl (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 22:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbTDMCvl (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 22:51:41 -0400
Received: from sith.maoz.com ([205.167.76.10]:46242 "EHLO sith.maoz.com")
	by vger.kernel.org with ESMTP id S262549AbTDMCvk (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 22:51:40 -0400
From: Jeremy Hall <jhall@maoz.com>
Message-Id: <200304130303.h3D33kkr031006@sith.maoz.com>
Subject: Re: 2.5.67-mm2
In-Reply-To: <1050198928.597.6.camel@teapot.felipe-alfaro.com> from Felipe Alfaro
 Solana at "Apr 13, 2003 03:55:29 am"
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Date: Sat, 12 Apr 2003 23:03:46 -0400 (EDT)
CC: Andrew Morton <akpm@digeo.com>, LKML <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I dunno about that, but mm2 locks in the boot process and doesn't display 
anything to me through gdb even though it is supposed to.  I have gdb 
console=gdb but that doesn't make the messages flow.

_J

In the new year, Felipe Alfaro Solana wrote:
> On Sun, 2003-04-13 at 03:08, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.67/2.5.67-mm2/
> > 
> > . Lots of misc saved-up things.
> > 
> > . I've changed the 32-bit dev_t patch to provide a 12:20 split rather than
> >   16:16.  This patch is starting to drag a bit and unless someone stops me I
> >   might just go submit the thing.
> 
> Any patches for CardBus/PCMCIA support? It's broken for me since
> 2.5.66-mm2 (it works with 2.5.66-mm1) probably due to PCI changes or the
> new PCMCIA state machine: if I boot my machine with my 3Com CardBus NIC
> plugged in, the kernel deadlocks while checking the sockets, but it
> works when booting with the card unplugged, and then plugging it back
> once the system is stable (for example, init 1).
> 
> I have written to Russell King, but had no response from him. Maybe he
> is too busy. I'm stuck at 2.5.66-mm1 on my laptop.
> 
> -- 
> Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
> See http://www.fsf.org/philosophy/no-word-attachments.html
> Linux Registered User #287198
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
> 

