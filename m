Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271978AbRJPXYY>; Tue, 16 Oct 2001 19:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272244AbRJPXYF>; Tue, 16 Oct 2001 19:24:05 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:21318 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271978AbRJPXXp>; Tue, 16 Oct 2001 19:23:45 -0400
Date: Wed, 17 Oct 2001 01:24:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Patrick McFarland <unknown@panax.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: VM
Message-ID: <20011017012407.Q2380@athlon.random>
In-Reply-To: <20011015211216.A1314@localhost> <9qg46l$378$1@penguin.transmeta.com> <20011015230836.B1314@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011015230836.B1314@localhost>; from unknown@panax.com on Mon, Oct 15, 2001 at 11:08:38PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2001 at 11:08:38PM -0400, Patrick McFarland wrote:
> reading what lang wrote, ive been thinking
> 
> Im on the type of machine that swapping the least is most favorable.
> rik's vm seems that it would be able to swap less, and not swap the
> wrong things enough of the time. andrea's, if i try to do something
> major, it swaps like crazy, but I havent tested rik's because I dont

strance if something it should swap less. It may look less responsive
under swap but that's mostly because we swap less and we drop more cache
instead.

Infact if you test 2.4.13pre3aa1 it should swap more and also be
more responsive under swap.

Andrea
