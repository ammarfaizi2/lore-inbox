Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287307AbSA3ADe>; Tue, 29 Jan 2002 19:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287359AbSA3ACT>; Tue, 29 Jan 2002 19:02:19 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43525 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S287145AbSA3ABD>; Tue, 29 Jan 2002 19:01:03 -0500
Date: Tue, 29 Jan 2002 15:59:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Nathan Scott <nathans@sgi.com>
cc: Andi Kleen <ak@suse.de>, <linux-kernel@vger.kernel.org>,
        Andreas Gruenbacher <ag@bestbits.at>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <20020130104004.C81308@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.33.0201291552170.1747-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 30 Jan 2002, Nathan Scott wrote:
>
> Al had several (additional) issues with the original patch, but I
> think we progressively worked through them - Al stopped suggesting
> changes at one point anyway, and the level of abuse died away ;),
> so I guess he became more satisfied with them.

I think you can safely assume that if Al doesn't curse you to hell, he can
be considered happy.

> Not much point apportioning blame - its as much my fault - I
> hadn't heard back from you at all since day 1, so figured you
> were just not interested in this stuff, so I stopped sending.

Basically, you should always consider email to me to be a unreliable
medium, with no explicit congestion control. So think of an email like a
TCP packet, with exponential backoff - except the times are different (in
TCP, the initial timeout is three seconds, and the max timeout is 2
minutes. In "Linus-lossy-network" it makes sense to use different
default and maximum values ;)

		Linus

