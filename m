Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132562AbRDAVJQ>; Sun, 1 Apr 2001 17:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132563AbRDAVJG>; Sun, 1 Apr 2001 17:09:06 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:337 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S132562AbRDAVIr>; Sun, 1 Apr 2001 17:08:47 -0400
Date: Sun, 1 Apr 2001 16:07:52 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Manfred Spraul <manfred@colorfullife.com>, lm@bitmover.com,
   linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <200104012017.f31KH0D272253@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.3.96.1010401160430.28121K-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Apr 2001, Albert D. Cahalan wrote:
> Manfred Spraul writes:
> > [Larry McVoy]
> 
> >> There was a lot of discussion about possible tools
> >> that would dig out the /proc/pci info

> > I think the tools should not dig too much information out of the system.
> > I remember some Microsoft (win98 beta?) bugtracking software that
> > insisted on sending a several hundert kB long compressed blob with every
> > bug report.
> > IMHO it must be possible to file bugreports without the complete hw info
> > if I know that the bug isn't hw related.
> 
> Yep. The two hardware-related items that usually matter:
> 
> Little-endian or broken-endian?
> 32-bit or 64-bit?

Matters to whom?  You, or the people actually fixing bugs?

"Broken-endian"?  whatever.

/proc/pci data alone with every bug report is usually invaluable.  It
gives you a really good idea of the general layout of the system, and
you can often catch or become aware of related hardware characteristics
which 

linux/REPORTINGS-BUGS was created to give users a hint that we need
-more- information, and tells exactly what general information is useful
to provide.  We do not need less information.

	Jeff




