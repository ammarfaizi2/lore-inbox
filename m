Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277629AbRJLLgl>; Fri, 12 Oct 2001 07:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277630AbRJLLgc>; Fri, 12 Oct 2001 07:36:32 -0400
Received: from elin.scali.no ([62.70.89.10]:6929 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S277629AbRJLLgO>;
	Fri, 12 Oct 2001 07:36:14 -0400
Subject: Re: so, no way to kill process? have to reboot?
From: Terje Eggestad <terje.eggestad@scali.no>
To: paulus@samba.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <15302.35510.947325.295210@cargo.ozlabs.ibm.com>
In-Reply-To: <3BC6097F.79B6E2D1@nortelnetworks.com> 
	<15302.35510.947325.295210@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 12 Oct 2001 13:36:42 +0200
Message-Id: <1002886602.12392.73.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


fre, 2001-10-12 kl. 08:16 skrev Paul Mackerras:
    Christopher Friesen writes:
    
    > Well, the unkillable process continues on.  Does nobody else have any ideas on
    > how to kill an unkillable process in the R state thats sucking up all my unused
    > cpu cycles?
    
    I would suspect that it is actually looping inside the kernel, which
    would mean that there indeed was no way to kill it.  You could try
    alt-scrolllock on the console and see if you get a register dump of
    it, or maybe one of the alt-sysrq magic keys might give you some
    information.  But I suspect that rebooting is ultimately going to be
    your only solution.
    
You might find out if it's looping inside the kernel by doing strace -p
<pid>, if you're stuck in a syscall, I *belive* strace'll tell you.

You wouldn't by any chance be developing a kernel module??

    Paul.
    
    -
    To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
    the body of a message to majordomo@vger.kernel.org
    More majordomo info at  http://vger.kernel.org/majordomo-info.html
    Please read the FAQ at  http://www.tux.org/lkml/
-- 
_________________________________________________________________________

Terje Eggestad                  terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 70 Bogerud                      +47 975 31 574  (MOBILE)
N-0621 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

