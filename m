Return-Path: <linux-kernel-owner+willy=40w.ods.org-S276249AbUKAQ3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S276249AbUKAQ3c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 11:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266607AbUKAQ3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 11:29:31 -0500
Received: from kelvin.pobox.com ([207.8.226.2]:37505 "EHLO kelvin.pobox.com")
	by vger.kernel.org with ESMTP id S266712AbUKAQ0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 11:26:34 -0500
Date: Mon, 1 Nov 2004 09:26:16 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1: drivers/ide/ide-dma.o: value of -130 too large for
 field of 1 bytes at 911
Message-Id: <20041101092616.6c7260a4.dickson@permanentmail.com>
In-Reply-To: <20041101121256.GK2495@stusta.de>
References: <20041101035402.556616d2.dickson@permanentmail.com>
	<20041101121256.GK2495@stusta.de>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004 13:12:56 +0100, Adrian Bunk wrote:

> On Mon, Nov 01, 2004 at 03:54:02AM -0700, Paul Dickson wrote:
> > With the attached .config, I'm getting this while compiling...
> > 
> >...
> >   CC      drivers/ide/ide-dma.o
> > {standard input}: Assembler messages:
> > {standard input}:607: Error: value of -130 too large for field of 1 bytes at 911
> > make[3]: *** [drivers/ide/ide-dma.o] Error 1
> > make[2]: *** [drivers/ide] Error 2
> > make[1]: *** [drivers] Error 2
> > make: *** [bzImage] Error 2
> > 
> > I got the same error with 2.6.9 too.
> > 
> > GCC 3.2.2 and 3.4.1.
> > 
> > Has this been fixed since 2.6.10-rc1?  Searching my Linux-Kernel folder
> > didn't find a match.
> 
> I can't reproduce it with your .config in 2.6.10-rc1.
> 
> Please send the output of ./scripts/ver_linux .


Apparently, it was the RH9 system that was the problem.  The FC2 system
does not have the problem.  I was using the RH9 system for compiling
because it has a 1333 MHz Athlon, while the FC2 system only has a 300 MHz
PII (so I never allowed a complete compilation on that system).  The RH9
system is scheduled for updating to FC3 this weekend or the next.

Thanks for the assistance.

	-Paul

