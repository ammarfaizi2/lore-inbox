Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278722AbRJ3XXy>; Tue, 30 Oct 2001 18:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274806AbRJ3XXo>; Tue, 30 Oct 2001 18:23:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24847 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278722AbRJ3XXZ>; Tue, 30 Oct 2001 18:23:25 -0500
Date: Tue, 30 Oct 2001 15:21:30 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pre5 VM livelock
In-Reply-To: <20011031001847.F1340@athlon.random>
Message-ID: <Pine.LNX.4.33.0110301520520.1188-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 Oct 2001, Andrea Arcangeli wrote:
>
> I agree it's oom, I think it's the infinite loop, it probably thinks
> this memory is freeable but maybe it's all anonymous mlocked memory, or
> maybe there's no swap at all that is equivalent for the vm.

It doesn't have to be mlocked - Jeff has zero swap left.

		Linus

