Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279638AbRJ2XoU>; Mon, 29 Oct 2001 18:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279637AbRJ2XoK>; Mon, 29 Oct 2001 18:44:10 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19974 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S279630AbRJ2Xny>; Mon, 29 Oct 2001 18:43:54 -0500
Date: Mon, 29 Oct 2001 15:41:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: please revert bogus patch to vmscan.c
In-Reply-To: <20011029183927.J25434@redhat.com>
Message-ID: <Pine.LNX.4.33.0110291541140.16703-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 29 Oct 2001, Benjamin LaHaise wrote:
> On Mon, Oct 29, 2001 at 03:36:03PM -0800, David S. Miller wrote:
> > It isn't a bug, the referenced bit is a heuristic.  The referenced bit
> > being wrong cannot result in corrupted user memory.
>
> We might as well choose what pages to swap out according to a random number
> generator then.

Show me a number. Andrea showed his performance. And I claim that our
"random number generator" is really close to reality.

		Linus

