Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269515AbRHCRkn>; Fri, 3 Aug 2001 13:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269520AbRHCRke>; Fri, 3 Aug 2001 13:40:34 -0400
Received: from web13103.mail.yahoo.com ([216.136.174.148]:59404 "HELO
	web13103.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S269517AbRHCRk2>; Fri, 3 Aug 2001 13:40:28 -0400
Message-ID: <20010803174037.79791.qmail@web13103.mail.yahoo.com>
Date: Fri, 3 Aug 2001 10:40:37 -0700 (PDT)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: Fw: PATCH: creating devices for multiple sound cards
To: Bill Pringlemeir <bpringle@sympatico.ca>, Zach Brown <zab@zabbo.net>
Cc: Chris Rankin <rankincj@yahoo.com>, linux-kernel@vger.kernel.org,
        nerijus@users.sourceforge.net
In-Reply-To: <m2y9p1nk5a.fsf@sympatico.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ALSA won't replace OSS overnight, and so a small
amount of OSS-maintenance can't possibly hurt. For
example, I use the OSS version of the emu10k1 driver
for DVD sound because the OSS one is realtime-capable
(and so provides better synchronisation) but the ALSA
one isn't yet.

Besides, the API I've tried to fix is actually *used*
by ALSA to provide OSS-emulation devices, except that
it doesn't work on a devfs-based machine with multiple
sound cards because all the device names clash.

Cheers,
Chris

--- Bill Pringlemeir <bpringle@sympatico.ca> wrote:
> >>>>> "Zach" == Zach Brown <zab@zabbo.net> writes:
> [snip]
>  Zach> doing many other things.  Hopefully the
> kernel side of ALSA
>  Zach> will be acceptable for inclusion in 2.5.  At
> least it has an
>  Zach> army of people actively maintaining it.
> 
> If ALSA will replace OSS, then does it make it
> somewhat futile to add
> things to the current set of sound drivers?  I was
> going to look at
> the SBLive driver.  I have been side tracked by an
> xterm bug; it seems
> to have bad handling of utmp on Linux.
> 
> regards,
> Bill Pringlemeir.
> 


__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
