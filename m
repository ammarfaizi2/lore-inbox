Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265108AbRFUS4u>; Thu, 21 Jun 2001 14:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265109AbRFUS4l>; Thu, 21 Jun 2001 14:56:41 -0400
Received: from smtp.snet.net ([204.60.6.55]:35983 "EHLO smtp.snet.net")
	by vger.kernel.org with ESMTP id <S265108AbRFUS4X>;
	Thu, 21 Jun 2001 14:56:23 -0400
Subject: Re: Controversy over dynamic linking -- how to end the panic
From: Wei Weng <wweng@kencast.com>
To: Timur Tabi <ttabi@interactivesi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <qi1bhC.A.lfF.ZEkM7@dinero.interactivesi.com>
In-Reply-To: <qi1bhC.A.lfF.ZEkM7@dinero.interactivesi.com>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 21 Jun 2001 16:01:58 -0400
Message-Id: <993153729.7844.3.camel@Monet>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Jun 2001 13:46:48 -0500, Timur Tabi wrote:
> ** Reply to message from "Eric S. Raymond" <esr@snark.thyrsus.com> on Thu, 21
> Jun 2001 14:14:42 -0400
> 
> 
> > To calm down the lawyers, I as the principal kernel maintainer and
> > anthology copyright holder on the code am therefore adding the
> > following interpretations to the kernel license:
> > 
> > 1. Userland programs which request kernel services via normal system
> >    calls *are not* to be considered derivative works of the kernel.
> > 
> > 2. A driver or other kernel component which is statically linked to
> >    the kernel *is* to be considered a derivative work.
> > 
> > 3. A kernel module loaded at runtime, after kernel build, *is not*
> >    to be considered a derivative work.
> 
> Although these are good things to add, I don't think they're compatible with
> the GPL.  That is, Linus can't just state these "interpretations" and add them
> to the GPL, because it will weaken the GPL as a whole.  I say that because you
> do not include any language that clarifies that from a legal sense.
Hell, why does the linux community need to care about other *greedy*
people who don't want to GPL their work anyway? If you want to protect
GPL as the principle in Linux, well, screw the device driver makers!

> I heard recently that kernel modules are technically, from the GPL
> point-of-view, a derivative work, because they include kernel header files.
> However, since Linus understands that this precludes binary-only modules, he has
> "made an exception" to the Linux kernel license.
> 
> The problem with that is that I have never seen any written evidence of this.
> 
> IANAL, but IMO, there are only two solutions:
> 
> 1. License the Linux kernel under a different license that is effectively the
> GPL but with additional text that clarifies the binary module issue.
> Unfortunately, this license cannot be called the GPL.  Politically, this would
> probably be a bad idea.
> 
> 2. License the Linux kernel under TWO licenses, one the GPL, and another which
> talks about the binary module issue.  Unfortunately, this would probably not
> work either, as technically these two licenses are incompatible.
> 
> I guess what I'm trying to say is that this issue won't be resolve simply by
> some "interpretations" by Linus as to what is and is not a derived work.  I
> think the FSF needs to be involved in this.
> 
> To be honest, I disagree that #include'ing a GPL header file should force your
> app to be GPL as well.  That may be how the license reads, but I think it's a
> very bad idea.  I could write 1 million lines of original code, but if someone
> told me that but simply adding #include <stdio.h> my code is now a derivative of
> the stdio.h, I'd tell him to go screw himself.
What is the difference between including kernel header file and
including GPLed header file? 


Best Regards,


Wei



