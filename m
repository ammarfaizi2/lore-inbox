Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284499AbRLLAi5>; Tue, 11 Dec 2001 19:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284432AbRLLAis>; Tue, 11 Dec 2001 19:38:48 -0500
Received: from www3.aname.net ([62.119.28.103]:16768 "EHLO www3.aname.net")
	by vger.kernel.org with ESMTP id <S284569AbRLLAim>;
	Tue, 11 Dec 2001 19:38:42 -0500
From: "Johan Ekenberg" <johan@ekenberg.se>
To: "\"Brad Dameron\"" <bdameron@tscnet.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Lockups with 2.4.14 and 2.4.16
Date: Wed, 12 Dec 2001 01:38:07 +0100
Message-ID: <000b01c182a5$44bd35b0$050010ac@FUTURE>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2377.0
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We use the same motherboards. And for some reason if you put 1 gig in them
> exactly and then in the kernel under "Processor type/High Memory Support"
we
> set it to use 4 gig it locks up the machine every once in a while.

How would it lock up? Could you describe the symptoms in more detail so that
I can compare?

> We ended up putting in 1.5 gig of ram and that seemed to fix it.

Oh, how did you do that? We tried to put 2Gb on one board but it wouldn't
recognize more than 1 Gb. I'm fairly sure we flashed the bios with the
latest firmware. Which board is it you have, Epox BXB-S or Epox KP6-BS?

> If you didn't
> compile in the 4 gig support Linux wouldn't recognize the full 1 gig of
> memory for some reason. This is on a Redhat 7.1 machine with 2.4.x
kernel's.

Yes, I noticed that too. Unfortunately, I've tested with both 1G and 4G
support when configuring the kernel, and the i/o lockups still happen.

