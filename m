Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268396AbTBNOPJ>; Fri, 14 Feb 2003 09:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268400AbTBNOPJ>; Fri, 14 Feb 2003 09:15:09 -0500
Received: from hugin.diku.dk ([130.225.96.144]:12292 "HELO hugin.diku.dk")
	by vger.kernel.org with SMTP id <S268396AbTBNOPI>;
	Fri, 14 Feb 2003 09:15:08 -0500
Date: Fri, 14 Feb 2003 15:25:00 +0100 (MET)
From: Peter Finderup Lund <firefly@diku.dk>
To: Robert Dewar <dewar@gnat.com>
cc: tjm@codegen.com, <discuss@x86-64.org>, <linux-kernel@vger.kernel.org>,
       <peter@jazz-1.trumpet.com.au>
Subject: Re: [discuss] Re: [Bug 350] New: i386 context switch very slow
 compared to 2.4 due to wrmsr (performance)
In-Reply-To: <20030214140336.501F2F2D7B@nile.gnat.com>
Message-ID: <Pine.LNX.4.44L0.0302141522350.4760-100000@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2003, Robert Dewar wrote:

> > > The only way to get from long-mode back to legacy-mode is to reset the
> > > processor.  It can be done in software but you will likely lose interrupts.
> >
> > Smartdrv.sys and triple-faults come back, all is forgiven!  ;)
>
> I have an idea, perhaps we can make the keyboard controller recognize a special
> command that will reset the processor :-) :-)

Do you think there is room enough left in the ROM for the microcontroller
used as keyboard controller?  We also need to squeeze in the already
planned backwards compatibility feature to mask the A20 line thru a
special command, you know.

But maybe we could move both these features into the motherboard chipset?

-Peter


