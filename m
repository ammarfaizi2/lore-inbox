Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278371AbRJMTPh>; Sat, 13 Oct 2001 15:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278368AbRJMTP1>; Sat, 13 Oct 2001 15:15:27 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:41362 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S278367AbRJMTPX>;
	Sat, 13 Oct 2001 15:15:23 -0400
Date: Sat, 13 Oct 2001 15:15:39 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andi Kleen <ak@muc.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        lse-tech@sourceforge.net, Paul.McKenney@us.ibm.com,
        rusty@rustcorp.com.au
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <k23d4njs9x.fsf@zero.aec.at>
Message-ID: <Pine.GSO.4.21.0110131507540.2021-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 13 Oct 2001, Andi Kleen wrote:

> In article <Pine.LNX.4.33.0110131015410.8707-100000@penguin.transmeta.com>,
> Linus Torvalds <torvalds@transmeta.com> writes:
> 
> >  - nobody has shown a case where existing normal locking ends up being
> >    really a huge problem, and where RCU clearly helps.
> 
> The poster child of such a case is module unloading. Keeping reference
> counts for every even non sleeping use of a module is very painful. 
> The current "fix" -- putting module count increases in all possible module 
> callers to fix the unload races is slow and ugly and far too subtle to 
> get everything right. Waiting quiescent periods before unloading is a nice 
> alternative.

... while quiescent stuff is _not_ subtle and not prone to breakage.  Right.
In the same world where Vomit-Making System is elegant, SGI "designs" are
and NT is The Wave Of Future(tm).  Pardon me, but I'll stay in our universe
and away from the drugs of such power.

