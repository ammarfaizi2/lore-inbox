Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267528AbRGWUCg>; Mon, 23 Jul 2001 16:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267529AbRGWUC0>; Mon, 23 Jul 2001 16:02:26 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:18184 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267528AbRGWUCV>; Mon, 23 Jul 2001 16:02:21 -0400
Date: Mon, 23 Jul 2001 13:00:48 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Jeff Dike <jdike@karaya.com>, <user-mode-linux-user@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, Jan Hubicka <jh@suse.cz>
Subject: Re: user-mode port 0.44-2.4.7
In-Reply-To: <20010723202734.C16919@athlon.random>
Message-ID: <Pine.LNX.4.33.0107231259520.13272-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Mon, 23 Jul 2001, Andrea Arcangeli wrote:
>
> gcc can assume 'state' stays constant in memory not just during the
> 'case'.

The point is that if the kernel has _any_ algorithm where it cares, it's a
kernel bug. With volatile or without.

SHOW ME THE CASE WHERE IT CARES. Let's fix it. Let's not just hide it with
"volatile".

		Linus

