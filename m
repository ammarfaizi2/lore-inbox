Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271082AbRHOHtS>; Wed, 15 Aug 2001 03:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271081AbRHOHtI>; Wed, 15 Aug 2001 03:49:08 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:33028 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S271082AbRHOHs4>; Wed, 15 Aug 2001 03:48:56 -0400
Date: Wed, 15 Aug 2001 09:49:07 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can I have a serial display output and a kbd PS/2 input?
Message-ID: <20010815094907.A5404@suse.cz>
In-Reply-To: <9l0n95$1me$1@ncc1701.cistron.net> <Pine.LNX.4.33.0108101416550.9874-100000@sol.compendium-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0108101416550.9874-100000@sol.compendium-tech.com>; from kernel@blackhole.compendium-tech.com on Fri, Aug 10, 2001 at 02:22:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2001 at 02:22:17PM -0700, Dr. Kelsey Hudson wrote:
> On Fri, 10 Aug 2001, Miquel van Smoorenburg wrote:
> 
> > In article <001b01c12194$a34a3370$66011ec0@frank>,
> > Frank Torres <frank@ingecom.net> wrote:
> > >Sorry to be insistent in this point, but perhaps requesting the problem this
> > >way someone figures out what I am trying to do.
> > >The display is already configured and sending getty line from inittab waits
> > >for an input from serial so it doesn't work.
> > >Any other ideas? This is my last try.
> >
> > If you want /dev/console to behave so that it sends output to the
> > serial device yet takes input from the PC keyboard, no, that cannot
> > be done. Right now /dev/console can be associated with only one
> > device for both input and output at the same time.
> >
> > Output from kernel printk's does go to all console devices though.
> 
> Well, as a sleightly more expensive solution, you could build a Sun
> keyboard to serial adapter. Somewhere on the SuSE webpage there is
> instructions on how to do this. IIRC, the keyboard only uses the RxD pin
> on the serial port so you would be free to use the TxD pin for your serial
> LCD.
> 
> The schematic can be had here:
> http://www.suse.cz/development/input/adapters
> 
> good luck, and hope this is of some use to you.

Yes, but this won't work either, because the keyboard doesn't send
ASCII.

-- 
Vojtech Pavlik
SuSE Labs
