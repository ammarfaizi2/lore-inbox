Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263967AbRF1T1J>; Thu, 28 Jun 2001 15:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264071AbRF1T07>; Thu, 28 Jun 2001 15:26:59 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:33031 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263967AbRF1T0u>; Thu, 28 Jun 2001 15:26:50 -0400
Date: Thu, 28 Jun 2001 12:25:28 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Patrick Dreker <patrick@dreker.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David Woodhouse <dwmw2@infradead.org>, <jffs-dev@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Cosmetic JFFS patch.
In-Reply-To: <3B3B7EC4.F4C8F2F0@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0106281218550.15199-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Jun 2001, Jeff Garzik wrote:
>
> As Alan said, driver versions are incredibly useful.  People use update
> their drivers over top of kernel drivers all the time.  Vendors do it
> too.  "Run dmesg and e-mail me the output" is 1000 times more simple for
> end users.

Fair enough. Especially as "dmesg" will output even the debugging messages
that do not actually end up being printed on the screen unless explicitly
asked for.

I'd also like to acknowledge the fact that at bootup it's usually very
nice to see "what was the last message it printed before it hung", and
that there's a fair reason for drivers to print out a single line of "I
just registered myself" for that reason. If that line happens to contain a
version string, all the better.

And if the user has to boot with "debug" to see all the information when
the machine hangs at bootup (when you can't just mail dmesg), that's
probably acceptable.

		Linus

