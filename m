Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268902AbRHFRTI>; Mon, 6 Aug 2001 13:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268914AbRHFRS6>; Mon, 6 Aug 2001 13:18:58 -0400
Received: from [63.209.4.196] ([63.209.4.196]:40452 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268902AbRHFRSs>; Mon, 6 Aug 2001 13:18:48 -0400
Date: Mon, 6 Aug 2001 10:17:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jakub Jelinek <jakub@redhat.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        David Luyer <david_luyer@pacific.net.au>,
        <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
Subject: Re: /proc/<n>/maps growing...
In-Reply-To: <20010806070124.J3862@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33.0108061015450.8972-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Aug 2001, Jakub Jelinek wrote:
>
> Even worse, it means people not using -ac kernels cannot malloc a lot of
> memory but by recompiling the kernel.

Hey guys. Let's calm down a bit, and look at the problem.

Why the hell is glibc doing something so stupid in the first place? Yes,
we can work around it, but it sounds like the glibc apporoach is slow and
stupid even if we _did_ work around it. Mind explaining what the logic of
"fixing" the kernel is?

		Linus

