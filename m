Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290070AbSA3Qjj>; Wed, 30 Jan 2002 11:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290018AbSA3QiY>; Wed, 30 Jan 2002 11:38:24 -0500
Received: from bitmover.com ([192.132.92.2]:52901 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290063AbSA3QiA>;
	Wed, 30 Jan 2002 11:38:00 -0500
Date: Wed, 30 Jan 2002 08:37:56 -0800
From: Larry McVoy <lm@bitmover.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130083756.I23269@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
	Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
	Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <E16Vp2w-0000CA-00@starship.berlin> <Pine.LNX.4.33.0201292326110.1428-100000@penguin.transmeta.com> <20020130154233.GK25973@opus.bloom.county> <20020130080308.D18381@work.bitmover.com> <20020130160707.GL25973@opus.bloom.county> <20020130081134.F18381@work.bitmover.com> <20020130161825.GM25973@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020130161825.GM25973@opus.bloom.county>; from trini@kernel.crashing.org on Wed, Jan 30, 2002 at 09:18:25AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Er, not the pristine tree, the linuxppc_2_4 tree, sorry.  I'll try
> again.  One of the problems we hit frequently is that we have to move
> files from linuxppc_2_4_devel into linuxppc_2_4, once they prove stable.
> But just creating a normal patch, or cp'ing the files means when we pull
> linuxppc_2_4 back into linuxppc_2_4_devel we get a file conflict, and
> have to move one of the files (the previously existing one) into the
> deleted dir.  How do we cleanly move just a few files from a child tree
> into the parent?  I think this is a lot like what would happen, if Linus
> used BK and we wanted to send him support for some platforms, but not
> all of the other changes we have.

BitKeeper is like a distributed, replicated file system with atomic changes.
That has certain advantages, much like a database.  What you are asking 
violates the database rules, if I understand you properly.  Are you asking
to move part of a changeset?  That's a no no, that's like moving the 
increment to your bank account without the decrement to mine; the banks
frown on that :-)

Or are you asking more about the out of order stuff, i.e., whole changesets
are fine but not all of them.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
