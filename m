Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269494AbRHLW2v>; Sun, 12 Aug 2001 18:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269491AbRHLW2b>; Sun, 12 Aug 2001 18:28:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23824 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269490AbRHLW2Y>; Sun, 12 Aug 2001 18:28:24 -0400
Subject: Re: Hang problem on Tyan K7 Thunder resolved -- SB Live! heads-up
To: nerijus@users.sourceforge.net (Nerijus Baliunas)
Date: Sun, 12 Aug 2001 23:30:36 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rui.p.m.sousa@clix.pt (Rui Sousa),
        linux-kernel@vger.kernel.org
In-Reply-To: <no.id> from "Nerijus Baliunas" at Aug 12, 2001 10:30:39 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15W3ki-0006JT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But later there was a patch from maintainer (Rui Sousa). Besides, there were no
> updates from maintainers for over a year, so I think "non maintainer" did a good
> thing - at least maintainers started to send patches finally. Instead of backing out
> I suggest for maintainers to send more patches...

I've got an even better idea. Its called making major problematic device
changes and debugging them in _UNSTABLE_ kernel trees - like waiting until
2.5 starts. Otherwise 2.4 will never be stable.

Its one thing to take something like the early USB in a stable kernel and
update it because it certainly won't make it worse, and another to update
an emu10k1 driver that worked with one that doesn't work, needs different
user tools and locks all SMP boxes.

Alan
