Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbTAaWli>; Fri, 31 Jan 2003 17:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbTAaWli>; Fri, 31 Jan 2003 17:41:38 -0500
Received: from bitmover.com ([192.132.92.2]:5573 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262824AbTAaWlh>;
	Fri, 31 Jan 2003 17:41:37 -0500
Date: Fri, 31 Jan 2003 14:50:57 -0800
From: Larry McVoy <lm@bitmover.com>
To: Larry McVoy <lm@bitmover.com>, bitkeeper-announce@bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: bkbits.net downtime
Message-ID: <20030131225057.GA18662@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Larry McVoy <lm@bitmover.com>, bitkeeper-announce@bitmover.com,
	linux-kernel@vger.kernel.org
References: <200301312114.h0VLEmC11997@work.bitmover.com> <20030131145018.N3904@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030131145018.N3904@schatzie.adilger.int>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, with BK it should be possible to have read only clones on
> multiple servers, should it not?  

Oh, sure.  Even if we were down for a week, the trees which people care
about are almost certainly on their local disks so they could set up
servers all over the place make the data available if need be.

bkbits.net is a cache, it's not the authoritative source of anything.

> I wonder if any of the kernel.org mirror sites would be interested in
> hosting a clone of one or more BK repositories.

Eventually we'll have a version of the BKD that we've bullet proofed
enough that we'd encourage that.  For the time being we've encouraged
hosting at bkbits.net simply because (a) the infrastructure is there
and (b) if there are security problems then it's our mess not yours.

It's partially self interest: if kernel.org got compromised and it was
our fault then we'd get a black eye.  If bkbits got compromised we'd 
just fix it up quietly  (and, no, so far it has never been broken into
but that's probably because we're very careful about how we run things,
even if you got in via BKD you'd have no write permissions on anything
but tmp dirs).
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
