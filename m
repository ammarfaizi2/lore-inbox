Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269966AbRHEO7f>; Sun, 5 Aug 2001 10:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269968AbRHEO70>; Sun, 5 Aug 2001 10:59:26 -0400
Received: from web13704.mail.yahoo.com ([216.136.175.137]:5384 "HELO
	web13704.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S269967AbRHEO7M>; Sun, 5 Aug 2001 10:59:12 -0400
Message-ID: <20010805145921.19306.qmail@web13704.mail.yahoo.com>
Date: Sun, 5 Aug 2001 07:59:21 -0700 (PDT)
From: jalaja devi <jala_74@yahoo.com>
Subject: kgdb in kerenel2.4.6 : Unable to view the global variables!!
To: linux-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B6A78C1.7A1B13AB@veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I am using kgdb for kernel2.4.6. But I am unable to
see my global variables. Could anyone please tell me
how can i fix this?

Also, When i install the loadmodule.sh, it creates the
gdbscripts. When I source the gdbscript, it gives the
warning,

> > warning : section _ksymtab not found in mymodule.o
> > warning : section _archdata not found in
mymodule.o

Is that related? Any hints will be helpful



Thanks in advance,
Jalaja

--- "Amit S. Kale" <akale@veritas.com> wrote:
> jalaja devi wrote:
> > 
> > Hi,
> > 
> > I have 2 quesions here:
> > 
> > 1. Could any plz tell me what am i missing out
> here?
> > 
> > I basically, trying to debug my my loadable module
> in
> > kernel in kernel2.4.6 version. I patched the
> kernel
> > with 2.4.6 kgdb patch, using the recent version.
> > 
> > I am using the modutils shell script to load my
> module
> > loadmodule.sh which creates a gdbscript. When I
> source
> > the gdbscript I get the following warnings:
> > 
> > warning : section _ksymtab not found in mymodule.o
> > warning : section _archdata not found in
> mymodule.o
> > 
> > Do I need to patch the kernel with the modutils.
> Why
> > do I get these warnings.
> 
> These warnings can be safely ignored.
> 
> > 
> > 2. How can I put a breakpoint to debug my
> init_module?
> > Which is the Kernel Fxn to be invoked to put a
> > breakpoint in my init_module?
> 
> You can place a breakpoint just before the the
> statement
> where kernel calls init_module. Then load the
> generated
> gdb script into gdb once the breakpoint is hit. Now
> you
> can place a breakpoint directly into any statement
> in the
> module code.
> 
> 
> > 
> > Thanks in advance,
> > 
> > Jalaja
> > 
> > __________________________________________________
> > Do You Yahoo!?
> > Make international calls for as low as $.04/minute
> with Yahoo! Messenger
> > http://phonecard.yahoo.com/
> > -
> > To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> Amit Kale
> Veritas Software ( http://www.veritas.com )


__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
