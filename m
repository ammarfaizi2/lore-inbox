Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262934AbRF2WKe>; Fri, 29 Jun 2001 18:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262702AbRF2WKZ>; Fri, 29 Jun 2001 18:10:25 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:57606 "EHLO
	mailout01.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S262694AbRF2WKL>; Fri, 29 Jun 2001 18:10:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Jordan <ledzep37@home.com>, Jordan Breeding <jordan.breeding@inet.com>
Subject: Re: USB Keyboard errors with 2.4.5-ac
Date: Sat, 30 Jun 2001 00:11:00 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <3B3CBA86.355500A@inet.com>
In-Reply-To: <3B3CBA86.355500A@inet.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01063000110000.01057@cookie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 June 2001 19:27, Jordan Breeding wrote:
> noticed my real problem with the keyboard.  The kernel apparently
> expects a PS/2 (AT) keyboard to be plugged in because if there isn't one
> the kernel reports timeouts and seems slower than when there is a PS/2
> keyboard present, my guess is because it is waiting on all of those
> timeouts.  

I use a USB keyboard (Macally iKey) and mouse (Logitech iFeel) without 
problems.  I also get these messages, but I dont see any performance problem. 
It may help you to enable an option like "Legacy USB keyboard support" in 
your BIOS. This will emulate a PS/2 keyboard until USB is initialized.

> The next major keyboard thing I noticed is that I can type on
> certain keys but if I do anything like hit the caps lock key or number
> lock a couple of times then the keyboard stops responding completely and
> the kernel tells me that there was an error waiting on a IRQ on CPU #1.

This was discussed in the USB mailing list a few weeks ago. Several people 
experienced this problem, including me.  As a workaround, use the alternate 
UHCI (JE) driver.

bye...
