Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131429AbRDBWku>; Mon, 2 Apr 2001 18:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131424AbRDBWkk>; Mon, 2 Apr 2001 18:40:40 -0400
Received: from hyperion.expio.net.nz ([202.27.199.10]:34576 "EHLO expio.co.nz")
	by vger.kernel.org with ESMTP id <S131459AbRDBWk3>;
	Mon, 2 Apr 2001 18:40:29 -0400
Message-ID: <011f01c0bbc5$ffc92e60$1400a8c0@expio.net.nz>
From: "Simon Garner" <sgarner@expio.co.nz>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E14kCnK-0006pa-00@the-village.bc.nu>
Subject: Re: Asus CUV4X-D, 2.4.3 crashes at boot
Date: Tue, 3 Apr 2001 10:40:36 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>

> > I've seen the exact same behavior with my CUV4X-D (2x1GHz) under
> > 2.4.2 (debian woody).  In addition, the kernel would sometimes hang
> > around NMI watchdog enable.  At least, I think it's trying to
>
> Known problem. Thats one reason why -ac trees had nmi watchdog turned off.


It still crashes with nmi_watchdog turned off.

Running with noapic fixes it but then the system crashes if you access the
RTC with hwclock (and probably creates a hundred other problems...).

How can I get this chipset/motherboard supported properly under Linux? I'm
happy to test patches etc. on the box. *pleading*


Cheers

Simon Garner

