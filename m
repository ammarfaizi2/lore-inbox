Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbRBMRf3>; Tue, 13 Feb 2001 12:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129094AbRBMRfT>; Tue, 13 Feb 2001 12:35:19 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:20996 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129031AbRBMRfI>; Tue, 13 Feb 2001 12:35:08 -0500
Date: Tue, 13 Feb 2001 09:33:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: tridge@linuxcare.com, linux-kernel@vger.kernel.org,
        junichi_morita@ysv.yokogawa.co.jp
Subject: Re: setting cpu speed on crusoe
In-Reply-To: <20010210224855.D7877@bug.ucw.cz>
Message-ID: <Pine.LNX.4.10.10102130928490.29787-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 10 Feb 2001, Pavel Machek wrote:
> 
> > Junichi Morita and I have worked out how to access the crusoe
> > "longrun" settings on the crusoe based VAIO. This allows you to enable
> > power saving mode and slow the cpu down. It should help battery life a
> > lot.
> 
> There is no documentation? I thought transmeta is linux-friendly
> company ;-).

We are, but the documentation we mean for internal use sometimes tends to
be in the "not good enough to be released" category.

Anyway, the register the above is touching has nothing to do with
"longrun", but with "coolrun" - it's the temperature control, not the CPU
speed control. Now, obviously, CPU speed and temperature do have tons of
things in common, which is why it gives somewhat expected results.

We're going through our docs and we have internal programs that we'll
release for this so that you'll not just have docs but actually working
code too. It just needs to be cleaned up a bit, and go through the proper
channels (ever wonder why open source gets deveoped faster?). It really
should be "any day now".

			Linus

