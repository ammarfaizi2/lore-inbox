Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279326AbRKARBe>; Thu, 1 Nov 2001 12:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279337AbRKARBY>; Thu, 1 Nov 2001 12:01:24 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:3340 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S279326AbRKARBN>; Thu, 1 Nov 2001 12:01:13 -0500
Date: Thu, 1 Nov 2001 13:41:12 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stress testing 2.4.14-pre6
In-Reply-To: <9rrsv9$b9l$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0111011340400.5912-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Nov 2001, Linus Torvalds wrote:

> In article <3BE073B6.BDCB3D56@redhat.com>,
> Bob Matthews  <bmatthews@redhat.com> wrote:
> >Hi Linus,
> >
> >We've been doing some stress-testing on 2.4.14-pre6 and have encountered
> >a couple of problems.  The platform is an 8xPIII with 8G RAM and 32G
> >swap.  After running Cerberus for about 3 hours, the machine hung
> >completely.  I was not able to switch VC's.
> 
> There is some race somewhere - I've found one interrupt race (that
> actually seems to exist in the 2.2.x VM too, but is probably _much_
> harder to trigger where an interrupt at _just_ the right time will
> corrupt the per-process local page list.  That looks so unlikely that I
> doubt that is it, but I'm looking for others (the irq one wasn't even a
> SMP race - it's on UP too, surprise surprise). 
> 
> Working on it, in other words.

Would you mind to describe this race? 

Thanks


