Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268968AbRHPW5Q>; Thu, 16 Aug 2001 18:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268963AbRHPW5G>; Thu, 16 Aug 2001 18:57:06 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27145 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268929AbRHPW44>; Thu, 16 Aug 2001 18:56:56 -0400
Subject: Re: Dual 1.7 GHz Xeon -- slow, interrupts not balance, etc
To: ossama@doc.ece.uci.edu (Ossama Othman)
Date: Thu, 16 Aug 2001 23:59:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, ossama@uci.edu
In-Reply-To: <20010816154525.A11206@ece.uci.edu> from "Ossama Othman" at Aug 16, 2001 03:45:25 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15XW6d-0006Gm-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wasn't expecting a 70% increase in speed but I did expect a
> noticeable performance boost rather than a equal or lesser
> performance.  Was I expecting too much?

It certainly seems so. The PIV seems to be very touchy about code 
patterns and the kind of jobs its fed. Gcc at the moment doesn't have PIV
optimisations either. The Athlon by contrast is extremely good at handling
code compiled for any CPU variant and that meant Athlon didnt need much
if any work for performance

> I'll send this stuff off to linux-smp, as stated by the message.  I
> also get the following (probably unrelated) messages:

OK

> agpgart: Unsupported Intel chipset (device id: 2531), you might want
> to try agp_try_unsupported=1.
> agpgart: no supported devices found.

Thats fine - your chipset is newer than the AGP code knows. 

> BTW, if this mailing list isn't the appropriate forum for these
> issues, I'd be glad to move it to another forum.  I certainly don't
> want to both the community with noise.

Its the right one for the IRQ problems certainly
