Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136309AbRAJUDE>; Wed, 10 Jan 2001 15:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136310AbRAJUCy>; Wed, 10 Jan 2001 15:02:54 -0500
Received: from hercules.telenet-ops.be ([195.130.132.33]:10254 "HELO
	smtp.pandora.be") by vger.kernel.org with SMTP id <S136309AbRAJUCk>;
	Wed, 10 Jan 2001 15:02:40 -0500
Date: Wed, 10 Jan 2001 20:51:27 +0100
From: mo6 <sjoos@pandora.be>
To: Robert Kaiser <rob@sysgo.de>
Cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Subject: Re: Anybody got 2.4.0 running on a 386 ?
Message-ID: <20010110205127.B982@pandora.be>
In-Reply-To: <01010922090000.02630@rob> <3A5B7F76.ABDFED7A@didntduck.org> <01010922264400.02737@rob>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <01010922264400.02737@rob>; from rob@sysgo.de on Tue, Jan 09, 2001 at 10:17:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 10:17:47PM +0100, Robert Kaiser wrote:
> On Die, 09 Jan 2001 you wrote:
> > Robert Kaiser wrote:
> > > I can't seem to get the new 2.4.0 kernel running on a 386 CPU.
> > > The kernel was built for a 386 Processor, Math emulation has been enabled.
> > > I tried three different 386 boards. Execution seems to get as far as
> > > pagetable_init() in arch/i386/mm/init.c, then it falls back into the BIOS as
> > > if someone had pressed the reset button. The same kernel boots fine on
> > > 486 and Pentium Systems.
> > > 
> > > Any ideas/suggestions ?
> > 
> > 
> > is "Checking if this processor honours the WP bit even in supervisor
> > mode... " the last thing you see before the reset?
> > 
> 
> No, I don't see _any_ messages from the kernel. The last thing I see is
> "Uncompressing Linux... Ok, booting the kernel." 

I dug up an old amd 386 and started compiling kernels for it with gcc 2.95.2:

2.4.0 : doesn't boot, same symptoms as you, Robert, so you're not imagining 
	things :-)
2.2.19pre6 : compiles, boots and runs poifectly
2.3.51 : doesn't compile
2.3.99-pre1 : hrm, *cough*
2.3.99-pre2 : *tsjoum*
2.3.39: compiles and boots okay

here is where I got bored :-)

okay, anyone, which 2.3.x kernels should compile okay ?

With kind regards,
Sven
-- 
If the odds are a million to one against something occurring, chances
are 50-50 it will.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
