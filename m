Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270645AbRHJVW4>; Fri, 10 Aug 2001 17:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270648AbRHJVWg>; Fri, 10 Aug 2001 17:22:36 -0400
Received: from [64.156.208.74] ([64.156.208.74]:36519 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S270645AbRHJVWe>; Fri, 10 Aug 2001 17:22:34 -0400
Date: Fri, 10 Aug 2001 14:22:17 -0700 (PDT)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
X-X-Sender: <kernel@sol.compendium-tech.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Can I have a serial display output and a kbd PS/2 input?
In-Reply-To: <9l0n95$1me$1@ncc1701.cistron.net>
Message-ID: <Pine.LNX.4.33.0108101416550.9874-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2001, Miquel van Smoorenburg wrote:

> In article <001b01c12194$a34a3370$66011ec0@frank>,
> Frank Torres <frank@ingecom.net> wrote:
> >Sorry to be insistent in this point, but perhaps requesting the problem this
> >way someone figures out what I am trying to do.
> >The display is already configured and sending getty line from inittab waits
> >for an input from serial so it doesn't work.
> >Any other ideas? This is my last try.
>
> If you want /dev/console to behave so that it sends output to the
> serial device yet takes input from the PC keyboard, no, that cannot
> be done. Right now /dev/console can be associated with only one
> device for both input and output at the same time.
>
> Output from kernel printk's does go to all console devices though.

Well, as a sleightly more expensive solution, you could build a Sun
keyboard to serial adapter. Somewhere on the SuSE webpage there is
instructions on how to do this. IIRC, the keyboard only uses the RxD pin
on the serial port so you would be free to use the TxD pin for your serial
LCD.

The schematic can be had here:
http://www.suse.cz/development/input/adapters

good luck, and hope this is of some use to you.

 Kelsey Hudson                                           khudson@ctica.com
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

