Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbRHMIRa>; Mon, 13 Aug 2001 04:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267743AbRHMIRJ>; Mon, 13 Aug 2001 04:17:09 -0400
Received: from [194.30.80.67] ([194.30.80.67]:52495 "EHLO
	serv_correo.ingecom.net") by vger.kernel.org with ESMTP
	id <S261289AbRHMIRB>; Mon, 13 Aug 2001 04:17:01 -0400
Message-ID: <006b01c123d0$aef36140$66011ec0@frank>
From: "Frank Torres" <frank@ingecom.net>
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
Cc: "Linux-Kernel \(Lista Correo\)" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0108101416550.9874-100000@sol.compendium-tech.com>
Subject: Re: Can I have a serial display output and a kbd PS/2 input?
Date: Mon, 13 Aug 2001 10:19:27 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.3018.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just to say thanks all folks. I was insisting on the same point you
explained to me. In spite of that I needed confirmation; any. It would be
interesting anyway to develop a console which could have the input and the
output from/to diferent devices.
Now I'll have to make one of the consoles to login automatically (I'm trying
the qlogin program) and then my next step will be to develop a small set of
functions to give aplications programmers an easy way to control some
devices like this display. So far I've been writing some modules with the
archiknown vi, but know I'll have to write a lot of code. Any IDE suggested?
I downloaded the RHIDE. Is it good? I haven't tested it yet.

Thanks all again.
Frank

----- Original Message -----
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: <linux-kernel@vger.kernel.org>
Sent: Friday, August 10, 2001 11:22 PM
Subject: Re: Can I have a serial display output and a kbd PS/2 input?


> On Fri, 10 Aug 2001, Miquel van Smoorenburg wrote:
>
> > In article <001b01c12194$a34a3370$66011ec0@frank>,
> > Frank Torres <frank@ingecom.net> wrote:
> > >Sorry to be insistent in this point, but perhaps requesting the problem
this
> > >way someone figures out what I am trying to do.
> > >The display is already configured and sending getty line from inittab
waits
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



