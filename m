Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281483AbRKPSsH>; Fri, 16 Nov 2001 13:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281478AbRKPSr5>; Fri, 16 Nov 2001 13:47:57 -0500
Received: from [208.232.58.25] ([208.232.58.25]:27317 "EHLO kronos.usol.com")
	by vger.kernel.org with ESMTP id <S281483AbRKPSrs>;
	Fri, 16 Nov 2001 13:47:48 -0500
Subject: Via686b audio
From: Sean Middleditch <smiddle@twp.ypsilanti.mi.us>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 16 Nov 2001 13:47:07 -0500
Message-Id: <1005936427.3321.2.camel@smiddle>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I brought up recently an issue with the onboard audio of a laptop with a
Via686b motherboard.  One person said it may be the IRQ routing tables
not being handled by Linux quite right for the motherboard.  I had
thought I sent in the dmesg output of the kernel (with PCI debugging)
but I've had no response and can't find the message in my sent box, so I
thought perhaps I didn't send it.  That is attached here (2.4.13 kernel,
I haven't tried this with the newer 2.4.15-pre5 that I now run).

I also noticed that the audio driver (via82cxxx_audio) gives a message
that it is for 82C686a (not 686b, which is what my motherboard is), and
then errors about timeouts on the AC97 codec - is it possible the 686b
is a little different than 686a in how the AC97 stuff is handled?  I'm
more than willing to apply patches or make small kernel tweaks, if
anyone can tell me what I need to do to debug this and get it working.

I've spoken with another person attempting to get Linux running on the
same laptop series (Compaq Presario 700), and it seems we have similar
issues.  If that makes any difference to anyone.  ^,^

Thanks guys!
Sean Etc.



