Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279317AbRJWH7s>; Tue, 23 Oct 2001 03:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279318AbRJWH7j>; Tue, 23 Oct 2001 03:59:39 -0400
Received: from mx2.uni-klu.ac.at ([143.205.180.40]:35597 "HELO
	mx2.uni-klu.ac.at") by vger.kernel.org with SMTP id <S279317AbRJWH70>;
	Tue, 23 Oct 2001 03:59:26 -0400
From: "Peter Putzer" <pputzer@edu.uni-klu.ac.at>
To: <linux-kernel@vger.kernel.org>
Subject: FW: Via Rhine and Kernel 2.4.x
Date: Tue, 23 Oct 2001 10:00:15 +0100
Message-ID: <CKENLDDHILEDAKEDLLEEKEEECEAA.pputzer@edu.uni-klu.ac.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

has anyone got an idea what may be wrong in the 2.4.x VIA Rhine driver?
(Please cc: me, as I'm not subscribed to the list)

Greetings,
Peter

-----Original Message-----
From: Donald Becker [mailto:becker@scyld.com]
Sent: Tuesday, October 23, 2001 2:10 AM
To: Peter Putzer
Subject: Re: Via Rhine and Kernel 2.4.x


On Tue, 23 Oct 2001, Peter Putzer wrote:

> sorry to disturb you, but I've got very severe problems with my Via Rhine
> and kernel 2.4.9 resp. 10. It's a no-name PCI 10/100 MBit adapter that
works
> in both Windows (95, 98, 2K) and Linux 2.2.x

Sorry, I don't support the modified driver distributed with the 2.4
kernels.  I only answer questions about my unmodified drivers.
   http://www.scyld.com/network/via-rhine.html
      ftp://www.scyld.com/pub/network/via-rhine.c

>  via-rhine.c:v1.10-LK1.1.11  20/08/2001  Written by Donald Becker
>   http://www.scyld.com/network/via-rhine.html
> PCI: Found IRQ 9 for device 00:0a.0
> via-rhine: reset finished after 5 microseconds.
> eth0: VIA VT3043 Rhine at 0xe000, 00:00:21:d1:07:9b, IRQ 9.
> eth0: MII PHY found at address 1, status 0x782d advertising 01e1 Link
00a1.
> eth0: via_rhine_open() irq 9.
> eth0: reset finished after 5 microseconds.
> eth0: Done via_rhine_open(), status 081a MII status: 782d.
> eth0: VIA Rhine monitor tick, status 0000.
> eth0: Transmit frame #1 queued in slot 0.
> eth0: Interrupt, status 2008.
>  Tx scavenge 0 status 00008100.
> eth0: Transmit error, Tx status 00008100.

This indicates that the transmit was aborted.  Presumably the
transceiver was misconfigured.

Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Second Generation Beowulf Clusters
Annapolis MD 21403			410-990-9993

