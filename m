Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266231AbRF3RyQ>; Sat, 30 Jun 2001 13:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266234AbRF3RyG>; Sat, 30 Jun 2001 13:54:06 -0400
Received: from mta5.rcsntx.swbell.net ([151.164.30.29]:45017 "EHLO
	mta5.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S266231AbRF3Rx6>; Sat, 30 Jun 2001 13:53:58 -0400
Date: Sat, 30 Jun 2001 12:53:49 -0500
From: Jordan <lezep37@home.com>
Subject: Re: USB Keyboard errors with 2.4.5-ac
To: Tim Jansen <tim@tjansen.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Reply-to: Jordan <ledzep37@home.com>,
        Jordan Breeding <jordan.breeding@inet.com>
Message-id: <3B3E1228.C841CA4C@home.com>
Organization: University of Texas at Dallas
MIME-version: 1.0
X-Mailer: Mozilla 4.76 (Macintosh; U; PPC)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
In-Reply-To: <3B3CBA86.355500A@inet.com> <01063000110000.01057@cookie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Jansen wrote:
> 
> On Friday 29 June 2001 19:27, Jordan Breeding wrote:
> > noticed my real problem with the keyboard.  The kernel apparently
> > expects a PS/2 (AT) keyboard to be plugged in because if there isn't one
> > the kernel reports timeouts and seems slower than when there is a PS/2
> > keyboard present, my guess is because it is waiting on all of those
> > timeouts.
> I use a USB keyboard (Macally iKey) and mouse (Logitech iFeel) without
> problems.  I also get these messages, but I dont see any performance problem.
> It may help you to enable an option like "Legacy USB keyboard support" in
> your BIOS. This will emulate a PS/2 keyboard until USB is initialized.
> > The next major keyboard thing I noticed is that I can type on
> > certain keys but if I do anything like hit the caps lock key or number
> > lock a couple of times then the keyboard stops responding completely and
> > the kernel tells me that there was an error waiting on a IRQ on CPU #1.
> This was discussed in the USB mailing list a few weeks ago. Several people
> experienced this problem, including me.  As a workaround, use the alternate
> UHCI (JE) driver.
> bye...

Yes, the JE driver did solve my problems, the keyboard now works on the
console and under X, and of course the mouse still works.  Thank you for
the help.

Jordan
