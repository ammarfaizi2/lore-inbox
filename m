Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbQL1Opb>; Thu, 28 Dec 2000 09:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129997AbQL1OpV>; Thu, 28 Dec 2000 09:45:21 -0500
Received: from p3EE3C765.dip.t-dialin.net ([62.227.199.101]:18692 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S129881AbQL1OpL>; Thu, 28 Dec 2000 09:45:11 -0500
Date: Thu, 28 Dec 2000 15:14:41 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.2.18: /proc/apm slows system time (was: Linux 2.2.19pre3)
Message-ID: <20001228151441.A3473@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20001228112305.A2571@emma1.emma.line.org> <E14Bc2d-0003e0-00@the-village.bc.nu> <20001228145337.A2887@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001228145337.A2887@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Thu, Dec 28, 2000 at 14:53:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2000, Matthias Andree wrote:

> Relevant dmesg:
> apm: BIOS version 1.2 Flags 0x03 (Driver version 1.13)
> 
> 
> Board: Gigabyte 7ZXR, BIOS rev. F4 (VIA KT133 chip set, AMIBIOS).

That's not a notebook, with a Duron CPU.

For what it's worth, here's a current /proc/apm output:

1.13 1.2 0x03 0x01 0xff 0x80 -1% -1 ?

That does not really tell us any more than we have APM driver version
1.13, APM BIOS v1.2, that it does support 16 and 32 bit, but idle does
not slow the clock, APM is engaged and enabled, that we're running
on-line and we don't know how long the power plants will last ;-)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
