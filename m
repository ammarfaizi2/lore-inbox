Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130774AbQLUEje>; Wed, 20 Dec 2000 23:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130881AbQLUEjY>; Wed, 20 Dec 2000 23:39:24 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:19469 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130774AbQLUEjG>; Wed, 20 Dec 2000 23:39:06 -0500
Date: Wed, 20 Dec 2000 23:09:09 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Extreme IDE slowdown with 2.2.18
In-Reply-To: <E148tvX-0002Jp-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.31.0012202306230.748-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2000, Alan Cox wrote:

>Date: Thu, 21 Dec 2000 00:49:45 +0000 (GMT)
>From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>To: Julian Anastasov <ja@ssi.bg>
>Cc: Robert Högberg <robho956@student.liu.se>,
>     linux-kernel <linux-kernel@vger.kernel.org>
>Content-Type: text/plain; charset=us-ascii
>Subject: Re: Extreme IDE slowdown with 2.2.18
>
>> > known problem with the 2.2.18 kernel?
>>
>> 	Yes, 2.2.18 is not friendly to all MVP3 users. The autodma
>> detection was disabled for the all *VP3 users in drivers/block/ide-pci.=
>> c.
>
>Because it was causing disk corruption for some people.

I wish I read this email 24 hours ago.  ;o(

>It took a lot of tracking down and I want the shipped kernel
>safe. I now know I'm covering too many chip versions so 2.2.19
>I can get the later VP3's back okay

Any info I can provide to help with my corruption problem
enabling UDMA?

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo
MVP3] (rev 04)
        Flags: bus master, medium devsel, latency 16
        Memory at d8000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3
AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Apollo
PRO] (rev 23)
        Subsystem: VIA Technologies, Inc. VT82C596/A/B PCI to ISA
Bridge
        Flags: bus master, stepping, medium devsel, latency 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE
[Apollo] (rev 10) (prog-if 8a [Master SecP PriP])
        Flags: bus master, medium devsel, latency 32
        I/O ports at e000
        Capabilities: [c0] Power Management version 2

00:07.3 Host bridge: VIA Technologies, Inc.: Unknown device 3050
(rev 30)
        Flags: medium devsel



Dunno if that helps...



----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

Red Hat FAQ tip: Having trouble upgrading RPM 3.0.x to RPM 4.0.x?  Upgrade 
first to version 3.0.5, and then to 4.0.x.  All packages are available on 
Red Hat's ftp sites:       ftp://ftp.redhat.com  ftp://rawhide.redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
