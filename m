Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbRAVASw>; Sun, 21 Jan 2001 19:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131330AbRAVASm>; Sun, 21 Jan 2001 19:18:42 -0500
Received: from quechua.inka.de ([212.227.14.2]:40242 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129604AbRAVAS1>;
	Sun, 21 Jan 2001 19:18:27 -0500
From: Bernd Eckenfels <inka-user@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - filesystem corruption on soft RAID5 in 2.4.0+
Message-Id: <E14KUgh-0000kk-00@sites.inka.de>
Date: Mon, 22 Jan 2001 01:18:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <14955.19182.663691.194031@notabene.cse.unsw.edu.au> you wrote:
> There have been assorted reports of filesystem corruption on raid5 in
> 2.4.0, and I have finally got a patch - see below.
> I don't know if it addresses everybody's problems, but it fixed a very
> really problem that is very reproducable.

Do you know if it is safe with 2.4.0 kernels to swap on degraded soft raids?
On the debian-devel list there is a discussion. Currently Debisn Systems to
not do swap-on on boot if a raid partition is resyncing.

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
