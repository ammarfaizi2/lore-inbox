Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289323AbSAVOvG>; Tue, 22 Jan 2002 09:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289324AbSAVOu5>; Tue, 22 Jan 2002 09:50:57 -0500
Received: from bs1.dnx.de ([213.252.143.130]:25248 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S289323AbSAVOul>;
	Tue, 22 Jan 2002 09:50:41 -0500
Date: Tue, 22 Jan 2002 15:47:32 +0100 (CET)
From: Robert Schwebel <robert@schwebel.de>
X-X-Sender: <robert@callisto.local>
Reply-To: <robert@schwebel.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] AMD Elan patch
In-Reply-To: <Pine.LNX.4.33.0112311900380.3056-100000@callisto.local>
Message-ID: <Pine.LNX.4.33.0201221545350.21377-100000@callisto.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[please send answers also per mail]

I've uploaded a new version of the patch (2.4.18-pre4.2) which basically
includes a change to the serial port code by Juergen Beisert. This patch
should fix problems with systems that use interrupt sharing UARTs.

Latest stuff is as usual on

  http://www.pengutronix.de/software/elan_en.html

Please test this extensively and report about your success.

I have another patch from Sven Geggus in the pipeline which makes it
possible to change the CPU's clock frequency on the fly. I would like to
integrate it but do not have a more-than-33-MHz Elan system available for
testing. If someone has a contact to a hardware supplyer who wants to send
me a board please tell me - SSV seems not to be cooperative here.

Other stuff waiting for integration:

- watchdog driver
- support for systems with external timer 0 clock source
- CS8900 bug ("transmission underflow")

Robert
--
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+

