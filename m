Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264395AbRFGKsw>; Thu, 7 Jun 2001 06:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264397AbRFGKsm>; Thu, 7 Jun 2001 06:48:42 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:1798 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S264395AbRFGKs3>; Thu, 7 Jun 2001 06:48:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: hps@intermeta.de, "Henning P. Schmiedehausen" <mailgate@hometree.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sockreg2.4.5-05 inet[6]_create() register/unregister table
Date: Thu, 7 Jun 2001 12:50:43 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <200106051659.LAA20094@em.cig.mot.com> <15134.49211.159673.522020@pizda.ninka.net> <9fnjh0$d1c$1@forge.intermeta.de>
In-Reply-To: <9fnjh0$d1c$1@forge.intermeta.de>
MIME-Version: 1.0
Message-Id: <01060712504301.02053@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 June 2001 12:03, Henning P. Schmiedehausen wrote:
> "David S. Miller" <davem@redhat.com> writes:
> >And my current understanding is that allowing proprietary
> >reimplementations of the VM, VFS, and core networking, is not one of
> >the things which is allowed.
>
> ...is wanted (by you and possibly Linus). Not ...is allowed.
>
> It _is_ already allowed. Someone can use the posted patch which is
> GPL open source, put it into the kernel and use their proprietary
> module.
>
> And this is legal according to the "Kernel GPL, Linus Torvalds
> edition (TM)" which says "any loadable module can be binary only".
> Not "only loadable modules which are drivers". It may not be the
> intention but it is the fact.

I seem to recall something about binary modules being ok as long as 
they stick to the published interface, which would let out binary-only 
extensions to core kernel functionality.  This would seem to permit 
reimplementation.

--
Daniel
