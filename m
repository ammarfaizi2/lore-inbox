Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311739AbSDTTd6>; Sat, 20 Apr 2002 15:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312255AbSDTTd5>; Sat, 20 Apr 2002 15:33:57 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4869 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311739AbSDTTd4>; Sat, 20 Apr 2002 15:33:56 -0400
Date: Sat, 20 Apr 2002 12:33:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove BK docs ... + x86-64 2.5.8 sync
In-Reply-To: <p73u1q68cfu.fsf_-_@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.33.0204201230140.11732-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20 Apr 2002, Andi Kleen wrote:
> > I don't buy that - I'm not getting changes from any new magical BK "men in
> > black". The patches are the same kind they always were, the last few
> > entries in my changelog are now the x86-64 merge (which was half a meg,
> > and yes it wasn't posted on linux-kernel, but no, it never was before BK
> > either), and before that the extensively discussed SSE register content
> > leak patch.
> 
> I didn't post the huge patch on l-k because the last time I sent large
> patches to l-k I got flamed badly by people who still seem to use 9600
> baud modems[1] to read mail.

Note: I did in no way try to blame Andi on this: quite the reverse. I'm 
saying that this was how it worked back before BK too - the bulk of the 
patches literally come to me as "private" patches, and they aren't cc'd to 
linux-kernel.

(Side note: that doesn't mean that they haven't had comments on the 
mailing lists, or that earlier versions or at least parts of them haven't 
been sent on the kernel list).

> I don't want to use BitKeeper because I don't like open logging. I hope
> I can continue to maintain the x86-64 port even without being part
> of the inner bitkeeper circle.

Absolutely - as you noticed I accepted the patch, even though there was a 
clash (with a released kernel) in there.

>	 It would be good if you did e.g.
> a pre patch for every change that could require action from architecture
> or other maintainers as sync point (i guess that could be made easy with
> the appropiate script)

This is why I think it might be a good reason to just have a daily script: 
not just to create the patches, but also to kind of keep a running 
commentary on the kernel list on what I've merged..

		Linus

