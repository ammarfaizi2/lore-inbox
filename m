Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262292AbUJZP01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbUJZP01 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 11:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262293AbUJZP01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 11:26:27 -0400
Received: from alog0342.analogic.com ([208.224.222.118]:896 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262292AbUJZP0Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 11:26:24 -0400
Date: Tue, 26 Oct 2004 11:26:19 -0400 (EDT)
From: linux-os <root@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Timothy Miller <miller@techsource.com>
cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org
Subject: Re: Some discussion points open source friendly graphics [was:
 HARDWARE:   Open-Source-Friendly Graphics Cards -- Viable?]
In-Reply-To: <417E6CF3.503@techsource.com>
Message-ID: <Pine.LNX.4.53.0410261118120.338@chaos.analogic.com>
References: <417D21C8.30709@techsource.com> <417D6365.3020609@pobox.com>
 <MPG.1be854649d4829f8989704@news.gmane.org> <417E6CF3.503@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2004, Timothy Miller wrote:

>
>
> Giuseppe Bilotta wrote:
> > Timothy Miller wrote:
> >
> >>>The reprogramability of the FPGA has many advantages, but
> >>>reprogramability is not its primary purpose.  The primary reason to use
> >>>an FPGA is to minimize NRE for manufacturing.  However, as a result,
> >>>users will be able to download updates.  Additionally, those who are
> >
> >
> > Jeff Garzik wrote:
> >
> >>Will the capability to apply these updates be included with the base card?
> >>Will users need to purchase additional "update FPGA" hardware to do the
> >>reprogramming?
> >
> >
> > Also, what if the reprogramming goes wrong? Do I just throw the
> > card away or will there be some form of recovery possible?
> >
>
>
> For those who are taking the risk of reprogramming it completely,
> they'll already have read the schematics and instructions for using an
> external device to program the PROM.
>
> For everyone else, it's the same problem you get when programming a
> motherboard goes awry.  When the BIOS is hosed, you can't use the MB
> until you replace the chip.
>
> For cost reasons, we likely wouldn't socket the chip, so you'd probably
> have to send it in for an RMA.  We'd reprogram it, and send it back.  Or
> if you have a friend with the right tools, they can do it.
>

Normally you use a boundary-scan (JTAG) serial header so you can program,
reprogram, debug the chip. FPGA development tools expect (require)
this.

Check out http:/www.macraigor.com/full_gnu.htm for their GNU tools
and devices, designed for Linux (and M$).


Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                 98.36% of all statistics are fiction.
