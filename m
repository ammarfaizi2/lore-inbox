Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132879AbRASRx0>; Fri, 19 Jan 2001 12:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135777AbRASRxR>; Fri, 19 Jan 2001 12:53:17 -0500
Received: from nat-pool-e.redhat.com ([199.183.24.19]:42246 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132879AbRASRxM>; Fri, 19 Jan 2001 12:53:12 -0500
Date: Fri, 19 Jan 2001 12:53:10 -0500
From: Bill Nottingham <notting@redhat.com>
To: Torrey Hoffman <torrey.hoffman@myrio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is there a Crystal 4299 sound driver?
Message-ID: <20010119125310.A13945@devserv.devel.redhat.com>
Mail-Followup-To: Torrey Hoffman <torrey.hoffman@myrio.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <4461B4112BDB2A4FB5635DE1995874320223D6@mail0.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4461B4112BDB2A4FB5635DE1995874320223D6@mail0.myrio.com>; from torrey.hoffman@myrio.com on Fri, Jan 19, 2001 at 09:47:00AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torrey Hoffman (torrey.hoffman@myrio.com) said: 
> Here's an lspci -v dump.  The machine is a set top box, pretty much a
> standard PC, but with hardware parts that are rarely seen in normal 
> desktops.  (The graphics card, ethernet card, and MPEG decoder chip
> all required non-standard Linux and X 4.0.2 drivers to work.)

> 00:1f.5 Class 0401: 8086:2415 (rev 02)
> 	Subsystem: 110a:0051
> 	Flags: bus master, medium devsel, latency 0, IRQ 5
> 	I/O ports at 1000
> 	I/O ports at 2000

Use the i810_audio driver; either 2.2.18 or 2.4.0 should be more or
less OK.

Bill
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
