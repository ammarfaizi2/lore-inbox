Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270848AbRHSWqd>; Sun, 19 Aug 2001 18:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270855AbRHSWqX>; Sun, 19 Aug 2001 18:46:23 -0400
Received: from mail.webmaster.com ([216.152.64.131]:36033 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S270848AbRHSWqQ>; Sun, 19 Aug 2001 18:46:16 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Alex Bligh - linux-kernel" <linux-kernel@alex.org.uk>
Cc: "Oliver Xymoron" <oxymoron@waste.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Entropy from net devices - keyboard & IDE just as 'bad' [was Re: [PATCH] let Net Devices feed Entropy, updated (1/2)]
Date: Sun, 19 Aug 2001 15:46:29 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMGEOEDEAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <483044230.998264308@[169.254.45.213]>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > To what level of accuracy do you think you can measure when
> > interrupts
> > occur?

> Better than the necessary 1 jiffie on non-i386 platforms and some
> i386 platforms.

	On those platforms, you simply can't have good entropy and still have user
accounts on the box with the default hardware. Sorry, the hardware just
doesn't permit it. You would have to set up some secure way to draw entropy
off an external pool, there's just nothing else you can do. (I believe there
are non-x87 platforms that have good timers, just not all of them.)

	DS

