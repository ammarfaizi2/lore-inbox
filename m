Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSEaAcW>; Thu, 30 May 2002 20:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313125AbSEaAcV>; Thu, 30 May 2002 20:32:21 -0400
Received: from bitmover.com ([192.132.92.2]:9117 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S312973AbSEaAcU>;
	Thu, 30 May 2002 20:32:20 -0400
Date: Thu, 30 May 2002 17:32:19 -0700
From: Larry McVoy <lm@bitmover.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Ion Badulescu <ionut@cs.columbia.edu>, Keith Owens <kaos@ocs.com.au>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: KBuild 2.5 Impressions
Message-ID: <20020530173219.X30298@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Lang <david.lang@digitalinsight.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Ion Badulescu <ionut@cs.columbia.edu>,
	Keith Owens <kaos@ocs.com.au>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E17DZCa-0007hI-00@starship> <Pine.LNX.4.44.0205301704550.23527-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2002 at 05:09:16PM -0700, David Lang wrote:
> don't forget that the kbuild2.5 patch was a lot smaller before keith was
> told to "go away and don't bother anyone until the speed problem is fixed"
> a large part of the fix was to use the mmapped db stuff that Larry McVoy
> made available instead of useing the standard db libraries on the system.

wc mdbm.c 
   1404    4736   32921 mdbm.c

Just for the record.  MDBM certainly has limitations, but being too many lines
of code is not one of them.  And it provides ndbm/dbm compat interfaces so
you can pull it out and drop in something else if you like.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
