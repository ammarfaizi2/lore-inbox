Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270469AbRHNMqj>; Tue, 14 Aug 2001 08:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270603AbRHNMq3>; Tue, 14 Aug 2001 08:46:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22032 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270469AbRHNMqO>; Tue, 14 Aug 2001 08:46:14 -0400
Subject: Re: Are we going too fast?
To: pete.lkml@toscano.org (Pete Toscano)
Date: Tue, 14 Aug 2001 13:48:06 +0100 (BST)
Cc: romieu@cogenit.fr (Francois Romieu), pf-kernel@mirkwood.net (PinkFreud),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010814002131.A26321@bubba.toscano.org> from "Pete Toscano" at Aug 14, 2001 12:21:31 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Wdc6-00016N-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	- use the uhci USB driver when I'm using a USB printer.  If I
> 	  use the usb-uhci driver with my USB printer, the whole system
> 	  locks.  This has been reported a few times on LKML,
> 	  linux-usb-users, and linux-usb-developers and nobody helped,
> 	  but a few people wrote back with "me too"s.  It was broken in
> 	  the trasnition from 2.4.3 to 2.4.4 and only seems to affect
> 	  SMP systems.  I just gave up on USB printing and went back to
> 	  my parallel port.

usb-uhci seems to not be SMP safe. Ultimately we don't need both uhci
drivers so that hasnt been one that worried me.  Probably we should drop
the other uhci driver over time (2.5 maybe)

Alan
