Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280929AbRKTFy4>; Tue, 20 Nov 2001 00:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280925AbRKTFyq>; Tue, 20 Nov 2001 00:54:46 -0500
Received: from asooo.flowerfire.com ([63.254.226.247]:14603 "EHLO
	asooo.flowerfire.com") by vger.kernel.org with ESMTP
	id <S280929AbRKTFy2>; Tue, 20 Nov 2001 00:54:28 -0500
Date: Mon, 19 Nov 2001 23:54:22 -0600
From: Ken Brownfield <brownfld@irridia.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [VM] 2.4.14/15-pre4 too "swap-happy"?
Message-ID: <20011119235422.F10597@asooo.flowerfire.com>
In-Reply-To: <20011119173935.A10597@asooo.flowerfire.com> <Pine.LNX.4.33.0111191543390.19585-200000@penguin.transmeta.com> <20011119210941.C10597@asooo.flowerfire.com> <20011120043222.T1331@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011120043222.T1331@athlon.random>; from andrea@suse.de on Tue, Nov 20, 2001 at 04:32:23AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kswapd goes up to 5-10% CPU (vs 3-6) but it finishes without issue or
apparent interactivity problems.  I'm keeping it in while( 1 ), but it's
been predictable so far.

3-10 is a lot better than 99, but is kswapd really going to eat that
much CPU in an essentially allocation-less state?

But certainly you found the right thing.

Thx all!
-- 
Ken.
brownfld@irridia.com

On Tue, Nov 20, 2001 at 04:32:23AM +0100, Andrea Arcangeli wrote:
| On Mon, Nov 19, 2001 at 09:09:41PM -0600, Ken Brownfield wrote:
| > Well, I think you'll be pleased to hear that your untested patch
| > compiled, booted, _and_ fixed the problem. :)
| 
| Can you try to run an updatedb constantly in background?
| 
| Andrea
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
