Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280025AbRJaCn1>; Tue, 30 Oct 2001 21:43:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280023AbRJaCnR>; Tue, 30 Oct 2001 21:43:17 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24432 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280035AbRJaCnE>; Tue, 30 Oct 2001 21:43:04 -0500
Date: Wed, 31 Oct 2001 03:43:32 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Udo A. Steinberg" <reality@delusion.de>, airlied@csn.ul.ie,
        linux-kernel@vger.kernel.org
Subject: Re: oops on 2.4.13-pre5 in prune_dcache
Message-ID: <20011031034332.L1340@athlon.random>
In-Reply-To: <3BDF51BE.4450888F@delusion.de> <Pine.LNX.4.33.0110301720380.19263-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.33.0110301720380.19263-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Oct 30, 2001 at 05:23:59PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 05:23:59PM -0800, Linus Torvalds wrote:
> But blaming the thing on bad RAM is not a good strategy if there are many
> of these reports. I'd love to see more of a pattern, though, because

Dunno why, but usually all bitflips triggers during heavy list walking,
so it's not too much surprisingly. I recall the most frequent bitflips
were happening walking the buffer header lists in 2.2, but I recall
dcache walks also oopsing due bitflips in 2.2.

Andrea
