Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289208AbSAVIwR>; Tue, 22 Jan 2002 03:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289212AbSAVIwI>; Tue, 22 Jan 2002 03:52:08 -0500
Received: from flubber.jvb.tudelft.nl ([130.161.76.47]:61619 "EHLO
	mail.jvb.tudelft.nl") by vger.kernel.org with ESMTP
	id <S289208AbSAVIwA>; Tue, 22 Jan 2002 03:52:00 -0500
Date: Tue, 22 Jan 2002 09:51:45 +0100 (CET)
From: Robbert Kouprie <robbert@jvb.tudelft.nl>
To: jussi.laako@kolumbus.fi
Cc: linux-kernel@vger.kernel.org
Subject: Re: NIC lockup in 2.4.17 (SMP/APIC/Intel 82557)
Message-ID: <Pine.LNX.4.43.0201220943060.6639-100000@flubber.jvb.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jussi Laako wrote:

> Robbert Kouprie wrote:
> >
> > Thanks for the quick reply :) Just checked it, and it's in slot 2, so
> > that's not the problem. It doesn't share the HPT366 IRQ. This is my
> > /proc/interrupts:
>
> Driver is eepro100? I suspect there is something in eepro100 driver that
> should be protected by a spinlock but is not. I haven't got time to
> analyze it further, yet...
>
>  - Jussi Laako

Yes, eepro100.c. Let me know if I can test something, although I would
need a reproducible testcase also. Still doing some tests with high
network load, as this caused the similar lockup in the other thread.

- Robbert

