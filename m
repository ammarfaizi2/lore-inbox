Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313089AbSDGK7A>; Sun, 7 Apr 2002 06:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313091AbSDGK67>; Sun, 7 Apr 2002 06:58:59 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:35335 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S313089AbSDGK67>;
	Sun, 7 Apr 2002 06:58:59 -0400
Date: Sun, 7 Apr 2002 06:58:57 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: Russell King <rmk@arm.linux.org.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: WatchDog Driver Updates
In-Reply-To: <20020407115212.B30048@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0204070658280.3791-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 7 Apr 2002, Russell King wrote:

> On Sun, Apr 07, 2002 at 06:35:55AM -0400, Rob Radez wrote:
> > Hmm...I'm not seeing any standards here.  Some drivers would just send
> > whether the watchdog device was open, some would only send 0, sc1200
> > would send whether the device was enabled or disabled, one did 'int one=1'
> > and then a few lines later copy_to_user'd 'one', and it looks like all of
> > three of twenty would actually return proper WDIOF flags.
>
> Maybe Alan would like to comment and clear up this issue - I believe the
> interface was Alan's design.  Certainly Alan wrote most of the early
> watchdog drivers.
>
> Thanks.

Ok, well, there's a new patch up at http://osinvestor.com/bigwatchdog-2.diff
that does these changes.

Regards,
Rob Radez

