Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265475AbRGLPMV>; Thu, 12 Jul 2001 11:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265491AbRGLPMB>; Thu, 12 Jul 2001 11:12:01 -0400
Received: from [194.106.48.114] ([194.106.48.114]:7172 "EHLO tim.rpnet.com")
	by vger.kernel.org with ESMTP id <S265475AbRGLPL7>;
	Thu, 12 Jul 2001 11:11:59 -0400
Message-ID: <008a01c10ae4$dc64cf60$0301a8c0@rpnet.com>
From: "Richard Purdie" <rpurdie@bigfoot.com>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <007501c10a1b$bc3a0bc0$0301a8c0@rpnet.com> <01071116375404.29517@frumious.unidec.co.uk> <003f01c10a63$08f50540$0301a8c0@rpnet.com> <200107112351.f6BNpa304221@penguin.transmeta.com>
Subject: Re: PROBLEM: <BUG Report: kernel BUG at slab.c:1062! from pppd with speedtouch drivers and pppoatm>
Date: Thu, 12 Jul 2001 16:10:35 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Looks like a "cmovne" that traps - are you sure you've compiled your
> module with the right CPU flags? In particular, maybe you compiled it
> for a i686, and are running it on a Pentium?

Spot on correct. I wish I could do that from a panic report :)

For the record the atm library also needs recompiling from kernel 2.4.5 to
2.4.6 otherwise you also get problems. Probably those number changes
again...

Thanks to all for your help.

I'd never have found that myself. The ADSL line is now running :)

Cheers,

RP







