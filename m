Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272718AbRISVyJ>; Wed, 19 Sep 2001 17:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274199AbRISVx7>; Wed, 19 Sep 2001 17:53:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31830 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S272718AbRISVxy>; Wed, 19 Sep 2001 17:53:54 -0400
To: Dan Hollis <goemon@anime.net>
Cc: Arjan van de Ven <arjanv@redhat.com>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <Pine.LNX.4.30.0109191249130.26700-100000@anime.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Sep 2001 15:44:45 -0600
In-Reply-To: <Pine.LNX.4.30.0109191249130.26700-100000@anime.net>
Message-ID: <m1adzqg8j6.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Hollis <goemon@anime.net> writes:

> On Wed, 19 Sep 2001, Arjan van de Ven wrote:
> > If it were only 5%, I would vote for disabling the optimisation given the
> > number of problems; however it's 2x _and_ you can trigger the bug as normal
> > user from userspace too... so we need to fix the hardware/bios.
> 
> But we really dont know what the hell that bit is doing. It might trigger
> some other obscure bugs and make things a real mess.
> 
> Until we get some answer from VIA its IMHO a bad idea to start twiddling
> this bit willy-nilly on all machines.

That is the only way we can get information.  We can twiddle this bit and
run memory performance tests on machines that aren't affected and
other stress tests on machines that are affected and see if we can see
if stability is impacted.

Additionaly the motherboards could be instrumented, and we could see
if there are any timing differences.

Of course VIA looking at what they have done and what that bit is
supposed to be is easiest as they have the schemantics of those
chips.  But there is not reason to be limited to just that approach.

Eric
