Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131545AbRBAXpM>; Thu, 1 Feb 2001 18:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132064AbRBAXpC>; Thu, 1 Feb 2001 18:45:02 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9746 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131545AbRBAXox>; Thu, 1 Feb 2001 18:44:53 -0500
Subject: Re: Serial device with very large buffer
To: abelits@phobos.illtel.denver.co.us (Alex Belits)
Date: Thu, 1 Feb 2001 23:45:23 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.10.10101312301110.1478-100000@mercury> from "Alex Belits" at Feb 01, 2001 03:20:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OTPp-0005MY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   I also propose to increase the size of flip buffer to 640 bytes (so the
> flipping won't occur every time in the middle of the full buffer), however
> I understand that it's a rather drastic change for such a simple goal, and
> not everyone will agree that it's worth the trouble:

Going to a 1K flip buffer would make sense IMHO for high speed devices too

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
