Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262225AbREXTay>; Thu, 24 May 2001 15:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262227AbREXTao>; Thu, 24 May 2001 15:30:44 -0400
Received: from munch-it.turbolinux.com ([38.170.88.129]:11768 "EHLO
	mail.us.tlan") by vger.kernel.org with ESMTP id <S262225AbREXTad>;
	Thu, 24 May 2001 15:30:33 -0400
Date: Thu, 24 May 2001 12:30:30 -0700
From: Prasanna P Subash <psubash@turbolinux.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dual Athlon on 2.2.19 ?
Message-ID: <20010524123030.B3485@turbolinux.com>
In-Reply-To: <20010522182740.A3125@turbolinux.com> <E152toh-0004uo-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E152toh-0004uo-00@the-village.bc.nu>; from Alan Cox on Thu, May 24, 2001 at 01:02:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

I have a dual athlon on the 760MP chipset.
2.2.20pre1 and 2 dont work. I got it to work partly after applying Johannes Erdfel's
760MP patch in io_apic.c. Even after applying the patch, there are messages like

hdc: IRQ probe failed(0)
hdd: IRQ probe failed(0)
hde: IRQ probe failed(0)

hdc: lost interrupt
hdc: lost interrupt

and then the machine hangs randomly. I an guessing the io_apic does not route the interrupts
correctly.




On Thu, May 24, 2001 at 01:02:11PM +0100, Alan Cox wrote:
> > 	Is there a patch to make dual athlons work on 2.2.19 ? I know it work on
> > 2.4.3-pre1 with AA's patch.
> 
> 2.2.20pre1 and 2.4.current should both work

-- 
Prasanna Subash   ---   psubash@turbolinux.com   ---     TurboLinux, INC
------------------------------------------------------------------------
Linux, the choice          | Reporter, n.:  A writer who guesses his way
of a GNU generation   -o)  | to the truth and dispels it with a  tempest
Kernel 2.4.1          /\\  | of words.   -- Ambrose Bierce, "The Devil's
on a i686            _\\_v | Dictionary" 
                           | 
------------------------------------------------------------------------
