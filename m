Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276547AbRI2QpC>; Sat, 29 Sep 2001 12:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276548AbRI2Qox>; Sat, 29 Sep 2001 12:44:53 -0400
Received: from otter.mbay.net ([206.40.79.2]:28420 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S276547AbRI2Qon>;
	Sat, 29 Sep 2001 12:44:43 -0400
Date: Sat, 29 Sep 2001 09:45:04 -0700 (PDT)
From: John Alvord <jalvo@mbay.net>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel changes
In-Reply-To: <20010929131902.J22640@niksula.cs.hut.fi>
Message-ID: <Pine.LNX.4.20.0109290937510.18362-100000@otter.mbay.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Sep 2001, Ville Herva wrote:

> On Fri, Sep 28, 2001 at 02:32:05PM -0700, you [Pavel Zaitsev] said:
> > I have been watching development of 2.4 since 2.4.2, I wonder wether there
> > would be reversion to old process where kernel source will be solidified
> > before starting development branch.
> 
> I think you can think of each new 2.4.x kernel as a candidate for
> solification. The part of the linux community a like me (and perhaps you?)

One aspect that bothers me is the absence of a success criteria. The
current competition for best VM is a good example. The fact is that every
operating system will fail with a high enough load. The best you can hope
for is a better degradation then the prior release. At the moment both
2.4.10 and 2.4.9-ac16 are better then 2.2.19. But people keep testing
under higher and higher loads and (surprise) they both fail... initiating
a search for better degradation logic.

Without a success criteria, this process cannot end.

Other examples are recent updates for multi-quad NUMA machines and changes
to handle locking problems on 8-way machines.

john alvord

