Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265100AbRGBNpu>; Mon, 2 Jul 2001 09:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265120AbRGBNpl>; Mon, 2 Jul 2001 09:45:41 -0400
Received: from zodiac.mimuw.edu.pl ([193.0.99.1]:45740 "HELO
	students.mimuw.edu.pl") by vger.kernel.org with SMTP
	id <S265100AbRGBNpd>; Mon, 2 Jul 2001 09:45:33 -0400
Date: Mon, 2 Jul 2001 15:46:18 +0200 (CEST)
From: Cezary Kaliszyk <ck189400@zodiac.mimuw.edu.pl>
To: "Philip V. Neves" <pneves@telus.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Possible problem with IDE device driver in kernel.
In-Reply-To: <97010223353900.00997@rasputan>
Message-ID: <Pine.LNX.4.30.0107021543150.830-100000@orka>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 1997, Philip V. Neves wrote:

> I would like to report a bug that I've seen in a few linux kernels now. This
> may be a serious problem with the IDE controler software because it may cause
> a hard drive to ware out over a period of time. I've noticed for a long time
> that when linux is loaded the hard drive light on my computer goes on and
> stays on. It never turns off. If I boot with windows the light turns off. I
> think it may be the device driver that forgets to turn of the light. Could
> one of you please confirm if this is a problem with the kernel and get back
> to me if it is not.
>
> Thank you,
>
>
> Philip V. Neves

I experience the same feature, but not only in Linux.

BeOS, FreeBSD, NetBSD, OpenBSD do not turn off the IDE light.

The manual for my main board (GA-6BXDS) sais that the light does not
turn off if no SCSI devices are attached to the board and SCSI is set to
'off' in the BIOS. But even if I turn it on, the light is constantly lit.

If I use a kernel compiled for Pentium (not PII which I really have) the
lamp does turn off sometimes (I mean with some kernels, I don't see any
other regularity).

I'm using a western Digital Caviar disk (WDC AC29100D) for over 2 years
now, and everything but for the light is fine.

Cezary Kaliszyk



