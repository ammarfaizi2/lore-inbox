Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130147AbRAQCEJ>; Tue, 16 Jan 2001 21:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130311AbRAQCEA>; Tue, 16 Jan 2001 21:04:00 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:13320 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130147AbRAQCDo>; Tue, 16 Jan 2001 21:03:44 -0500
Date: Tue, 16 Jan 2001 21:04:42 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Urban Widmark <urban@teststation.com>
cc: "richard.morgan9" <richard.morgan9@ntlworld.com>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: eth1: Transmit timed out, status 0000, PHY status 0000
In-Reply-To: <Pine.LNX.4.30.0101162351480.13791-100000@cola.teststation.com>
Message-ID: <Pine.LNX.4.31.0101162102220.722-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2001, Urban Widmark wrote:

>Date: Tue, 16 Jan 2001 23:59:33 +0100 (CET)
>From: Urban Widmark <urban@teststation.com>
>To: richard.morgan9 <richard.morgan9@ntlworld.com>
>Cc: Mike A. Harris <mharris@opensourceadvocate.org>,
>     Linux Kernel mailing list <linux-kernel@vger.kernel.org>
>Content-Type: TEXT/PLAIN; charset=US-ASCII
>Subject: Re: eth1: Transmit timed out, status 0000, PHY status 0000
>
>On Tue, 16 Jan 2001, richard.morgan9 wrote:
>
>> I have the same problem as Urban with a recent DLink 530tx
>> (rhine2).  Pulling the power cable from my atx psu (while the
>> computer was "off") fixed the card, until my next reboot from
>> win98.
>
>I'm not the one with a problem but maybe it has something to do with win98
>and/or the driver used there. I intend to test this myself eventually and
>see if I can do something based on Donald Beckers suggestions on eeprom.
>
>Unless someone else feels like playing with this ... anyone?
>
>Does everyone seeing this have a Rhine-II, pci id 1106:3065, and not the
>older chip found in dfe530tx with pci id 1106:3043?

00:12.0 Ethernet controller: VIA Technologies, Inc.: Unknown
device 3065 (rev 42)
        Subsystem: D-Link System Inc: Unknown device 1400
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at e800
        Memory at e7000000 (32-bit, non-prefetchable)
        Expansion ROM at e6000000 [disabled]
        Capabilities: [40] Power Management version 2

00:13.0 Ethernet controller: Winbond Electronics Corp W89C940
        Flags: medium devsel, IRQ 12
        I/O ports at ec00



And I do not have drivers for the dlink card in win98.  The 2
cards are in my workstation, one goes to my firewall @ 10Mbit and
the other to my build/devel machine at 100mbit which 98 doesn't
get to see.  It is sure interested in the card at boot time
though... EVERY time... ;o(


----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------
Windows 95(n) - 32-bit extensions and graphical shell for a 16-bit patch
to an 8-bit operating system originally coded for a 4-bit microprocessor,
written by a 2-bit company that can't stand 1 bit of competition. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
