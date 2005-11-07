Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbVKGEoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbVKGEoj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 23:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbVKGEoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 23:44:39 -0500
Received: from dslb138.fsr.net ([12.7.7.138]:23473 "EHLO sandall.us")
	by vger.kernel.org with ESMTP id S1751186AbVKGEoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 23:44:39 -0500
Date: Sun, 6 Nov 2005 20:54:30 -0800 (PST)
From: Eric Sandall <eric@sandall.us>
X-X-Sender: sandalle@cerberus
To: Willy Tarreau <willy@w.ods.org>
cc: Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Tony Luck <tony.luck@gmail.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: New (now current development process)
In-Reply-To: <20051031064109.GO22601@alpha.home.local>
Message-ID: <Pine.LNX.4.63.0511062052590.24477@cerberus>
References: <4d8e3fd30510291026x611aa715pc1a153e706e70bc2@mail.gmail.com>
 <12c511ca0510291157u5557b6b1x85a47311f0e16436@mail.gmail.com>
 <20051029195115.GD14039@flint.arm.linux.org.uk> <Pine.LNX.4.64.0510291314100.3348@g5.osdl.org>
 <20051031064109.GO22601@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 31 Oct 2005, Willy Tarreau wrote:
> On Sat, Oct 29, 2005 at 01:28:23PM -0700, Linus Torvalds wrote:
>
>> So I'm planning on continuing with it unchanged for now. Two-week merge
>> window until -rc1, and then another -rc kernel roughly every week until
>> release. With the goal being 6 weeks, and 8 weeks being ok.
>>
>> I don't think anybody has been really unhappy with this approach? Hmm?
>
> I believe it was a good experience. However, I still find it sad that
> there are changes between the latest -rc and the final version. This
> time, it seems it did not cause trouble, but in the past, it happened
> several times, because any valid fix can have side effects.
>
> I think that if you could announce what you intend to release with a
> message like "I will make this -final tomorrow", there would be some
> time to test builds in various configs, and check that no obvious bug
> has been introduced.

A -final should never be changed from the last -rc. That defeats the
purpose of having -rc releases (rc == 'release candidate' ;)). If you
do make changes to the last -rc, then you need to release another -rc
with those changes. If all's good, then you can release that /last/
- -rc with /no/ changes as the One and True Release.

- -sandalle

- --
Eric Sandall                     |  Source Mage GNU/Linux Developer
eric@sandall.us                  |  http://www.sourcemage.org/
http://eric.sandall.us/          |  SysAdmin @ Inst. Shock Physics @ WSU
http://counter.li.org/  #196285  |  http://www.shock.wsu.edu/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDbt4KHXt9dKjv3WERAiIXAKClGeeapTkGJ7gFWymHISb99JGw7QCgrPag
lArvgGMUprksA28CX+9I2Bc=
=8xAI
-----END PGP SIGNATURE-----
