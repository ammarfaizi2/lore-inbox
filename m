Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291966AbSBAUYE>; Fri, 1 Feb 2002 15:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291970AbSBAUX5>; Fri, 1 Feb 2002 15:23:57 -0500
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:4038 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S291966AbSBAUXq>; Fri, 1 Feb 2002 15:23:46 -0500
From: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
Message-Id: <200202012023.VAA04954@faui02b.informatik.uni-erlangen.de>
Subject: Re: [PATCH] Q40 input api support.
To: vojtech@suse.cz (Vojtech Pavlik)
Date: Fri, 1 Feb 2002 21:23:40 +0100 (MET)
Cc: jsimmons@transvirtual.com (James Simmons), linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20020201204513.A18925@suse.cz> from "Vojtech Pavlik" at Feb 01, 2002 08:45:13 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Fri, Feb 01, 2002 at 08:43:04PM +0100, Richard Zidlicky wrote:
> 
> > 
> > > > > +static inline void q40kbd_write(unsigned char val)
> > > > > +{
> > > > > +	/* FIXME! We need a way how to write to the keyboard! */
> > > > > +}
> > > > 
> > > > absolutely no way to write to the keyboard.
> > > 
> > > Really? Too bad. So no way to set LEDs, no way to detect the keyboard,
> > > no way to set it to "Scancode Set 3"?
> > 
> > no way to control LED's, keyboard is assumed present, scancode set 
> > is AT
> 
> Ok, in that case we'll need to pass a flag to atkbd.c (via the serio
> layer) telling it not to try any detection / initialization of the
> keyboard.

that looks fine.

Richard

