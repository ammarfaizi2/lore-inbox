Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275822AbRJ2PdE>; Mon, 29 Oct 2001 10:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275989AbRJ2Pcz>; Mon, 29 Oct 2001 10:32:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5469 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S275822AbRJ2Pcn>; Mon, 29 Oct 2001 10:32:43 -0500
To: Daniel Duke <danduke@iprimus.com.au>
Cc: "Linux Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.x freezes on boot
In-Reply-To: <01C16009.C6751AA0.danduke@iprimus.com.au>
From: ebiederman@uswest.net (Eric W. Biederman)
Date: 29 Oct 2001 08:22:27 -0700
In-Reply-To: <01C16009.C6751AA0.danduke@iprimus.com.au>
Message-ID: <m1bsiqjwss.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Duke <danduke@iprimus.com.au> writes:

> As the subject indicates, I'm having trouble running 2.4.x kernels.  I've 
> tried 2.4.10 and 2.4.13, and both of them compile perfectly (no errors) but 
> when I insert them into LILO and reboot I get the following:
> 
> LILO:  Linux
> Loading Linux........
> 
> and the computer freezes at this point, every time.  I've tried compiling 
> it for PIII/Celeron Coppermine (which is the correct one for me I think) 
> and 386.  I've compiled the kernel under Debian GNU/Linux 2.2r3 (kernel 
> 2.2.19) with GCC 2.91.66.

Hmm.  It looks like something is up wrong with lilo.  If you don't get
as far as the Uncompressing line, you haven't even gotten to the linux
kernel.  It may be something in the 16 bit setup code that queries
the BIOS but that is unlikely.

Hmm.  Actually more likely which kernel have you pointed lilo to?
arch/i386/boot/bzImage?

Eric
