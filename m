Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263803AbRFEIbz>; Tue, 5 Jun 2001 04:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263804AbRFEIbp>; Tue, 5 Jun 2001 04:31:45 -0400
Received: from chiara.elte.hu ([157.181.150.200]:32783 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S263803AbRFEIbc>;
	Tue, 5 Jun 2001 04:31:32 -0400
Date: Tue, 5 Jun 2001 10:29:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Missing cache flush.
In-Reply-To: <9fhqlj$7jt$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0106051027390.2339-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 4 Jun 2001, Linus Torvalds wrote:

>  - even when it works, it is necessarily very very very slow. Not to be
>    used lightly. As you can imagine, the work-around is even slower.

i've measured it once, IIRC it was around 10-15 millisecs on normal
pentiums, so while it's indeed the slowest x86 instruction on the planet,
it's still perhaps acceptable for hot-swapping ECC RAM.

	Ingo

