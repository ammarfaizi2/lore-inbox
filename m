Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319197AbSH2MiL>; Thu, 29 Aug 2002 08:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319198AbSH2MiL>; Thu, 29 Aug 2002 08:38:11 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:8433 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S319197AbSH2MiL>; Thu, 29 Aug 2002 08:38:11 -0400
Date: Thu, 29 Aug 2002 14:42:30 +0200
From: Frank Otto <Frank.Otto@tc.pci.uni-heidelberg.de>
To: mike heffner <mdheffner@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:  conflict between apm and system clock on Inspiron 8100
Message-ID: <20020829144230.B8042@goedel.pci.uni-heidelberg.de>
References: <200208281504.g7SF4Xl04292@goedel.pci.uni-heidelberg.de> <20020828170033.10142.qmail@web40203.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020828170033.10142.qmail@web40203.mail.yahoo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Wed, Aug 28, 2002 at 10:00:33AM -0700, mike heffner wrote:
> Hi Frank,
> 
>  From your e-mail it seems that the kernel is the
> problem, not the bios.  Is that your understanding?  I
> started pestering Dell for a bios without this
> problem.  Should I be digging through the kernel code
> instead?

Frankly, I don't know. The behaviour of the BIOS sure is bad,
but I don't know the APM specifications, so the BIOS might still
be operating within these limits. Good luck though for getting a
better BIOS from Dell. If you have any success, please let me know.

I doubt that this can be fixed in the kernel. If the kernel enables
interrupts during APM calls but the BIOS still turns them off, what
should the kernel do about this? Well, there still exists the possibilty
that the kernel's method for enabling interrupts during APM calls is
flawed in some way, or doesn't work with certain BIOSes. In this case,
it might be possible to fix it in the kernel.

Cheers,
Frank
