Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbUBVDAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 22:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbUBVDAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 22:00:09 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:57473 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261656AbUBVC76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 21:59:58 -0500
Date: Sun, 22 Feb 2004 03:59:57 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel vs AMD x86-64
Message-ID: <20040222025957.GA31813@MAIL.13thfloor.at>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Mikael Pettersson <mikpe@csd.uu.se>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org> <16435.14044.182718.134404@alkaid.it.uu.se> <Pine.LNX.4.58.0402180744440.2686@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402180744440.2686@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 07:47:21AM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 18 Feb 2004, Mikael Pettersson wrote:
> > 
> > What about naming? IA-64 is taken, AMD64 is too specific, Intel's
> > "IA-32e" sounds too vague, and I find x86-64 / x86_64 difficult to type.
> > "x64" perhaps?
> 
> x86-64 it is. Maybe you can remap one of your function keys to send the 
> sequence ;)
> 
> This whole "ia32" crap has always been ridiculous - nobody has _ever_ 
> called an x86 anything but x86, and Intel is just making it worse by 
> adding random illogical letters to the end.
> 
> In contrast, x86-64 tells you _exactly_ what it's all about, and is what 
> the kernel has always called the architecture anyway.

hmm, so the current x86_64 will be changed to x86-64 or
will there be x86_64 and x86-64?

probably I missed something important, but AMD64 seems 
to be labeled x86_64 in 2.4 and 2.6


# ls linux-2.4.25/arch/
alpha/  cris/  ia64/  mips/    parisc/  ppc64/  s390x/  sh64/   sparc64/
arm/    i386/  m68k/  mips64/  ppc/     s390/   sh/     sparc/  x86_64/

# ls linux-2.6.3/arch/
alpha/  cris/   ia64/       mips/    ppc64/  sparc/    v850/
arm/    h8300/  m68k/       parisc/  s390/   sparc64/  x86_64/
arm26/  i386/   m68knommu/  ppc/     sh/     um/

TIA,
Herbert

> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
