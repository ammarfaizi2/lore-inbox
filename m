Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267221AbRGYXSu>; Wed, 25 Jul 2001 19:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267390AbRGYXSk>; Wed, 25 Jul 2001 19:18:40 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:51721 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267221AbRGYXSd>; Wed, 25 Jul 2001 19:18:33 -0400
Date: Wed, 25 Jul 2001 16:16:32 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Chris Friesen <cfriesen@nortelnetworks.com>,
        Jeff Dike <jdike@karaya.com>,
        user-mode-linux-user <user-mode-linux-user@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: user-mode port 0.44-2.4.7
In-Reply-To: <20010726004957.F32148@athlon.random>
Message-ID: <Pine.LNX.4.33.0107251615430.22383-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Thu, 26 Jul 2001, Andrea Arcangeli wrote:
>
> I will if Honza assures me that no future version of gcc will cause me to
> crash if I don't declare xtime volatile and I play with it while it can
> change under me (which seems not the case from his last email).

WHY DO YOU NOT ADD THE "VOLATILE" TO THE PLACES THAT _CARE_?

This is not a gcc issue. Even if gcc _were_ to generate bad code, the
global volatile _still_ wouldn't be the correct answer.

		Linus

