Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289331AbSA3Pu0>; Wed, 30 Jan 2002 10:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289327AbSA3PuQ>; Wed, 30 Jan 2002 10:50:16 -0500
Received: from bitmover.com ([192.132.92.2]:10149 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S289331AbSA3PuD>;
	Wed, 30 Jan 2002 10:50:03 -0500
Date: Wed, 30 Jan 2002 07:49:56 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130074956.C18381@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
	Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
	Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <Pine.LNX.4.33.0201292326110.1428-100000@penguin.transmeta.com> <E16VrlR-0006vL-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16VrlR-0006vL-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 30, 2002 at 10:14:49AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 10:14:49AM +0000, Alan Cox wrote:
> Larry - can bitkeeper easily be persuaded to take "messages" back all the way 
> to the true originator of a change. Ie if a diff gets to Linus he can reject
> a given piece of change and without passing messages back down the chain
> ensure they get the reply as to why it was rejected, and even if
> nobody filled anything in that it was looked at and rejected by xyz at
> time/date ?

It's certainly possible and there are changes we could make to make it more
useful.  Right now, there is no record of a change if it goes and then gets
rejected right back out; it's as if you patched and then you did a reverse
patch.

The good news is that each change (patch) has an identifier, they look like

    awc@bitmover.bitmover.com|ChangeSet|20011230212716|39200

and if we kept a record of those that were rejected, it would be trivial for
a developer to track whether his change was in/not seen/rejected.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
