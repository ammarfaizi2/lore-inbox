Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSGHM2p>; Mon, 8 Jul 2002 08:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSGHM2p>; Mon, 8 Jul 2002 08:28:45 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:40206 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S316878AbSGHM2n>;
	Mon, 8 Jul 2002 08:28:43 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Tomas Szepe <szepe@pinerecords.com>
Date: Mon, 8 Jul 2002 14:30:59 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: spurious 8259A interrupt: IRQ7
CC: linux-kernel@vger.kernel.org, pat@cs.curtin.edu.au
X-mailer: Pegasus Mail v3.50
Message-ID: <A4F8F3A725D@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Jul 02 at 12:05, Tomas Szepe wrote:
> > I have read through quite a few mailing lists and other sources but
> > can't find an adequate solution. One solution I found was to turn off
> > Local APIC support and IO-APIC support in the kernel, which I tried and
> > it worked, but I'd rather not do this. I realise the error isn't of a
> > huge concern but it's still annoying having it appear everytime the
> > machine boots up.
> 
> Your fix is to just realize that this is a mere warning -- Nothing's
> wrong with your setup.
> 
> If you dig out a thread that came through here abt. two months ago,
> you'll find a comprehensive explanation of what the message means.

Fortunately... since kernel HZ changed to 1000Hz, I have about two these
spurious interrupts delivered to the CPU on my A7V each second. Fortunately 
they are always really spurious, not misdelivered other interrupts, but 
seeing values like 10000 in ERR field in /proc/interrupts is something new 
to me ;-) Maybe VIA or AMD should really clarify what's the problem.
                                                            Petr Vandrovec
                                                            
