Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281866AbRKSBUN>; Sun, 18 Nov 2001 20:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281867AbRKSBUD>; Sun, 18 Nov 2001 20:20:03 -0500
Received: from mx3out.umbc.edu ([130.85.253.53]:53197 "EHLO mx3out.umbc.edu")
	by vger.kernel.org with ESMTP id <S281866AbRKSBTt>;
	Sun, 18 Nov 2001 20:19:49 -0500
Date: Sun, 18 Nov 2001 20:19:26 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Stuart Young <sgy@amc.com.au>
cc: <linux-kernel@vger.kernel.org>, Anders Peter Fugmann <afu@fugmann.dhs.org>
Subject: Re: SiS630 chipsets && linux 2.4.x kernel == snails pace?
In-Reply-To: <5.1.0.14.0.20011119113205.01eb7dc0@mail.amc.localnet>
Message-ID: <Pine.SGI.4.31L.02.0111182009540.12243284-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001, Stuart Young wrote:

> Have you tried going through with hdparm enabling/disabling the options in
> turn? eg: DMA, Unmasq IRQ, Multi-Count, etc.

What makes no sense is that hdparm -t -T indicates that 2.4.12 is faster.

> I would not be surprised if what was happening was related to DMA causing
> huge locks of the IDE subsystem, and dragging out the disk times, therefore
> throwing the system out the window. Out of your previous posts, I saw you
> mention you fiddled with Unmasq IRQ and 32 bit, but not DMA.

toggled off DMA, to no effect. Interrupts, between the two systems,
actually looked like the 2.4.12 machine was lower over time.
(up 1/6 of the time, had 1/10 of the interrupts)

> Also are these systems per chance running the same brand/model of h/drive?
> While I doubt it, could this be a problem with these drives and these
> boards only in certain modes?

The three systems in question are all running Maxtor hard drives, but two
are 32049H2 20GB, and one is 91024U3, a 10GB.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

