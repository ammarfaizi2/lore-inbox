Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131560AbQLVBs5>; Thu, 21 Dec 2000 20:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131583AbQLVBsh>; Thu, 21 Dec 2000 20:48:37 -0500
Received: from mail.zikzak.de ([195.21.249.46]:61712 "EHLO mail.zikzak.de")
	by vger.kernel.org with ESMTP id <S131560AbQLVBs1>;
	Thu, 21 Dec 2000 20:48:27 -0500
From: amk@krell.snafu.de (Andreas M. Kirchwitz)
Subject: Re: [PATCH] fix emu10k1 init breakage in 2.2.18
Date: 22 Dec 2000 01:17:58 GMT
Organization: Touched By The Hand Of God.
Message-ID: <slrn945au6.h1q.amk@krell.zikzak.de>
In-Reply-To: <200012191201.NAA02004@harpo.it.uu.se> <slrn93vb44.enh.amk@krell.zikzak.de> <3A407F75.2A8F5188@innominate.com>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juri Haberland wrote:

 >>> 2.2.18 broke the emu10k1 driver when compiled into the kernel.
 >> 
 >> Is there also a fix available to make the bass and treble settings
 >> work again in mixer applications (for example, Gnome mix 1.2.0)?
 > 
 > Yes, put something like "EXTRA_CFLAGS += -DTONE_CONTROL" into the
 > Makefile in drivers/sound/emu10k1/

Ah, TONE_CONTROL... yeah, that's it. Do you know the reason why
bass/treble controls are disabled by default? Aren't they stable
enough for production use?

I'm just wondering why anybody wants to have this turned off. ;-)

	Greetings from Berlin to Berlin ... Andreas
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
