Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277012AbRJKWdv>; Thu, 11 Oct 2001 18:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277011AbRJKWdl>; Thu, 11 Oct 2001 18:33:41 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:16736 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S277008AbRJKWdh>; Thu, 11 Oct 2001 18:33:37 -0400
Date: Fri, 12 Oct 2001 00:31:48 +0200
From: Christian Ullrich <chris@chrullrich.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Vincent Sweeney <v.sweeney@dexterus.com>, arvest@orphansonfire.com,
        linux-kernel@vger.kernel.org
Subject: Re: Partitioning problems in 2.4.11
Message-ID: <20011012003148.B435@christian.chrullrich.de>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Vincent Sweeney <v.sweeney@dexterus.com>, arvest@orphansonfire.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0110111538200.24742-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.GSO.4.21.0110111538200.24742-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Oct 11, 2001 at 04:00:11PM -0400
X-Current-Uptime: 0 d, 00:28:43 h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexander Viro wrote on Thursday, 2001-10-11:

> a) does 2.4.10-ac12 work for you?  It had got essentially the same
> partition-related code that we have in 2.4.11.  I suspect that causes
> of breakage are different, so the answer may not be the same for everybody
> affected.
> 
> d) patch below closes two known holes.  It's known to be not enough in
> one case (see above) and unlikely to help in another (sda9).  However,
> let's get these holes out of the way first.

a) -10-ac11, -10-ac12 and -12 with your patch all behave like -11.

d) The patch does apparently not fix this particular bug.

-- 
Christian Ullrich		     Registrierter Linux-User #125183

"Sie können nach R'ed'mond fliegen -- aber Sie werden sterben"
