Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131065AbRBARkY>; Thu, 1 Feb 2001 12:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131265AbRBARkP>; Thu, 1 Feb 2001 12:40:15 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:38159 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131065AbRBARkD>; Thu, 1 Feb 2001 12:40:03 -0500
Subject: Re: 2.2.16 3c90x ?
To: apark@cdf.toronto.edu
Date: Thu, 1 Feb 2001 17:41:06 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.30.0102011220540.5429-100000@marvin.cdf> from "apark@cdf.toronto.edu" at Feb 01, 2001 12:33:49 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ONjI-0004i6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just wondering...  How safe is it to switch from 10Mbit network to
> 100Mbit network while the machine is up?

Providing the driver is properly coded absolutely fine

> from 10Mbit to 100Mbit while machine was up, it just froze solid.
> I'm using 3Com 3c905C Tornado network card and the corresponding driver
> is 3c90x.
> 

Use the standard kernel 3c59x.c driver instead. That one for me at least
is happy doing 10/100 switches

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
