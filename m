Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276832AbRJZAme>; Thu, 25 Oct 2001 20:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276988AbRJZAmY>; Thu, 25 Oct 2001 20:42:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61966 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276832AbRJZAmO> convert rfc822-to-8bit; Thu, 25 Oct 2001 20:42:14 -0400
Date: Thu, 25 Oct 2001 17:41:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: =?iso-8859-1?q?Ren=E9=20Scharfe?= <l.s.r@web.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] strtok --> strsep in framebuffer drivers
In-Reply-To: <m15wsSM-007qjJC@smtp.web.de>
Message-ID: <Pine.LNX.4.33.0110251739440.1118-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id RAA28581
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 25 Oct 2001, René Scharfe wrote:
>
> Yes. I assumed my compiler (gcc 2.96) was misbehaving by reporting all
> that warnings about code which is actually just some normal C code. But
> after some consideration I see that it can help greatly in case of
> typos and so on.

Please use an explicit test - I know gcc suggest just an extra set of
parenthesis, but I'm personally convinced that is just because some gcc
people have been damaged by too much LISP.

I think

	if ((a = b))

looks nothing but stupid, while

	if ((a = b) != 0)

"explains" the parenthesis..

		Linus

