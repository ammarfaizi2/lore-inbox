Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291946AbSBATqw>; Fri, 1 Feb 2002 14:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291939AbSBATp0>; Fri, 1 Feb 2002 14:45:26 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:53767 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291935AbSBATpS>; Fri, 1 Feb 2002 14:45:18 -0500
Date: Fri, 1 Feb 2002 20:45:13 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Richard Zidlicky 
	<Richard.Zidlicky@stud.informatik.uni-erlangen.de>
Cc: James Simmons <jsimmons@transvirtual.com>, linux-m68k@lists.linux-m68k.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Q40 input api support.
Message-ID: <20020201204513.A18925@suse.cz>
In-Reply-To: <20020201165538.A17286@suse.cz> <200202011943.UAA04625@faui02b.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202011943.UAA04625@faui02b.informatik.uni-erlangen.de>; from Richard.Zidlicky@stud.informatik.uni-erlangen.de on Fri, Feb 01, 2002 at 08:43:04PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 08:43:04PM +0100, Richard Zidlicky wrote:

> 
> > > > +static inline void q40kbd_write(unsigned char val)
> > > > +{
> > > > +	/* FIXME! We need a way how to write to the keyboard! */
> > > > +}
> > > 
> > > absolutely no way to write to the keyboard.
> > 
> > Really? Too bad. So no way to set LEDs, no way to detect the keyboard,
> > no way to set it to "Scancode Set 3"?
> 
> no way to control LED's, keyboard is assumed present, scancode set 
> is AT

Ok, in that case we'll need to pass a flag to atkbd.c (via the serio
layer) telling it not to try any detection / initialization of the
keyboard.

-- 
Vojtech Pavlik
SuSE Labs
