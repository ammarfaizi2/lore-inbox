Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280494AbRJaUpk>; Wed, 31 Oct 2001 15:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280496AbRJaUpa>; Wed, 31 Oct 2001 15:45:30 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:30528 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280494AbRJaUpQ>; Wed, 31 Oct 2001 15:45:16 -0500
Date: Wed, 31 Oct 2001 21:45:40 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Google's mm problem - not reproduced on 2.4.13
Message-ID: <20011031214540.D1291@athlon.random>
In-Reply-To: <E15yzlQ-00021P-00@starship.berlin> <E15z28m-0000vb-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E15z28m-0000vb-00@starship.berlin>; from phillips@bonn-fries.net on Wed, Oct 31, 2001 at 09:39:12PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 09:39:12PM +0100, Daniel Phillips wrote:
> On October 31, 2001 07:06 pm, Daniel Phillips wrote:
> > I just tried your test program with 2.4.13, 2 Gig, and it ran without 
> > problems.  Could you try that over there and see if you get the same result?
> > If it does run, the next move would be to check with 3.5 Gig.
> 
> Ben reports that his test with 2 Gig memory runs fine, as it does for me, but 
> that it locks up tight with 3.5 Gig, requiring power cycle.  Since I only 
> have 2 Gig here I can't reproduce that (yet).

are you sure it isn't an oom condition. can you reproduce on
2.4.14pre5aa1? mainline (at least before pre6) could deadlock with too
much mlocked memory.

Andrea
