Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280839AbRKOODA>; Thu, 15 Nov 2001 09:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280838AbRKOOCj>; Thu, 15 Nov 2001 09:02:39 -0500
Received: from mail.comune.modena.it ([195.223.135.244]:45563 "EHLO
	toutatis.comune.modena.it") by vger.kernel.org with ESMTP
	id <S280840AbRKOOCe>; Thu, 15 Nov 2001 09:02:34 -0500
Message-ID: <001701c16ddd$c3aba2d0$bc02090a@comnet.comune.modena.it>
From: "Andrea Aime" <aaime@libero.it>
To: <saw@saw.sw.com.sg>
Cc: <linux-kernel@vger.kernel.org>
Subject: 2.4.15-pre4: eepro100, wait_for_cmd timeout
Date: Thu, 15 Nov 2001 14:35:52 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,
I have a problems with my Intel PRO/100 VE integrated ethernet
card on my Acer Travelmate notebook... I've tried to find a solution
without bothering you, but with no luck.
My card get recognized and the module eepro10 is loaded by
the network start script, and it may even work for a while, but...
as soon as a long data transfer occurs (how long? well, 1 Meg is enough),
the driver hangs with a "eepro100: wait_for_cmd timeout" message,
and the network becomes unreachable and it stays as such unless I reload
the driver (I have compiled it as a module). This is the only message I get
from the driver.
The same problem occurs with kernel 2.4.10 vanilla (Linus one) and 2.4.8
(mandrake stock kernel). I didn't tried ac kernels (sorry... should I do
that?).
I also downloaded and compiled Intel drivers, which claims to support
Intel PRO/100 VE, but with no luck (insmod e100 says the device isn't there)
Any help would be much appreciated :-) Thanks in advance
Best regards
Andrea Aime

PS: please cc me, I'm not

