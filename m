Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267418AbRHAQTx>; Wed, 1 Aug 2001 12:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267452AbRHAQTm>; Wed, 1 Aug 2001 12:19:42 -0400
Received: from [63.209.4.196] ([63.209.4.196]:46864 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267418AbRHAQTh>; Wed, 1 Aug 2001 12:19:37 -0400
Date: Wed, 1 Aug 2001 09:18:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Arjan van de Ven <arjanv@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: booting SMP P6 kernel on P4 hangs.
In-Reply-To: <3B67CE6A.A670093E@redhat.com>
Message-ID: <Pine.LNX.4.33.0108010917540.20829-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Aug 2001, Arjan van de Ven wrote:
> >
> > It should boot, and it looks like the problem may be a bad MP table.
>
> Oh it is. And it's due to a recommendation Intel makes to bios writers.
> As a result, every P4 I've encountered shares this bug. Intel knows it's
> an invalid MP table, but refuses to change the recommendation.

What's the recommendation? We might be able to change the specific code in
question..

Or are they just trying to strongarm the move to the horrid ACPI tables?

		Linus

