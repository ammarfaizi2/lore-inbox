Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313125AbSC1Jui>; Thu, 28 Mar 2002 04:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313126AbSC1Ju1>; Thu, 28 Mar 2002 04:50:27 -0500
Received: from vaak.stack.nl ([131.155.140.140]:8199 "HELO mailhost.stack.nl")
	by vger.kernel.org with SMTP id <S313125AbSC1JuL>;
	Thu, 28 Mar 2002 04:50:11 -0500
Date: Thu, 28 Mar 2002 10:50:09 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Dalecki <dalecki@evision-ventures.com>, <andersen@codepoet.org>,
        Andre Hedrick <andre@linux-ide.org>, jw schultz <jw@pegasys.ws>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Offtopic: Re: DE and hot-swap disk caddies
In-Reply-To: <E16qWNt-0007Ij-00@the-village.bc.nu>
Message-ID: <20020328103854.O5099-100000@toad.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Mar 2002, Alan Cox wrote:

> > Then there is this talking around about the "tristate of some" device.
> > I'm really a bit sick of it. Becouse there is no such a state
> > like a tri-state. We have just bus drivers on both ends.
> > They are implemented usually as Schmidt triggers. They have three
> > possible states on output: low voltage, high voltage, high resistance.
>
> Which is one, two, three states -> tri-state.

Eeks, a Linux developper who can count ;-)

> Electronics terminology then abuses that to mean the high impedance state (not
> high resistance please if we are going to be picky).

Correct, though I hope in most cases the impedance is almost equal to the
resistance, otherwise there would be problems at the current high speeds.

For those who don't know the difference:

Resistance is only a part of impedance. Inpedance also contains a
frequency-dependant part, caused by induction in, and capacity between
wires and electronic devices.

The idea in formula:

Induction = 	Resistance +
		frequency * Induction +
		1 / (frequency * Capacity)

For an accurate formula, see any book about EE.

Jos

