Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBNMEf>; Wed, 14 Feb 2001 07:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132032AbRBNMEP>; Wed, 14 Feb 2001 07:04:15 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55054 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132013AbRBNMEL>; Wed, 14 Feb 2001 07:04:11 -0500
Subject: Re: Driver for Casio Cassiopia Fiva touchscreen, help with conversion
To: sopwith@redhat.com
Date: Wed, 14 Feb 2001 12:04:41 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.32.0102132034540.20720-100000@devserv.devel.redhat.com> from "Elliot Lee" at Feb 13, 2001 08:57:43 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14T0fr-0004iq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> is a rather Bad Hack (seeing as it was built rather blindly to mimic the
> behaviour of the Windows driver, and has IRQ/port hardcoded in), but it
> works for me with the 2.2.16 kernel.

Thats pretty much how we did the pc110 pad driver too.

> The device outputs 5 byte packets - 1 status byte, 2 bytes each for X & Y
> coordinates. The devel branch of GTK+ has support for /dev/fidmour in the

That also sounds suprisingly familiar. I wonder, I wonder 8)

> I'm wondering if anyone has a resource that would provide information on
> porting this driver to the 2.4 kernel.

Two approaches. #1 You leave it as its own misc device and XInput device as
the pc110 pad does (the pc110pad reports ps/2 codes and does drag/tap in
the driver - might be worth a look to steal that)

> I would welcome comments on this driver, or on the MPC-501 and Linux in
> general. Bonus points to anyone who actually understands why the driver
> works and how the hardware works. :)

You might want to let the guys at www.amherst.co.uk know about it so they can
add it to their resources on the fiva

