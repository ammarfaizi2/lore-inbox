Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316100AbSEJSPr>; Fri, 10 May 2002 14:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316101AbSEJSPq>; Fri, 10 May 2002 14:15:46 -0400
Received: from bitmover.com ([192.132.92.2]:18593 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316100AbSEJSPp>;
	Fri, 10 May 2002 14:15:45 -0400
Date: Fri, 10 May 2002 11:15:45 -0700
From: Larry McVoy <lm@bitmover.com>
To: Eli Carter <eli.carter@inet.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: BK problem
Message-ID: <20020510111545.M3965@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Eli Carter <eli.carter@inet.com>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205101725.g4AHPOH05574@work.bitmover.com> <3CDC0A34.2000006@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 12:58:12PM -0500, Eli Carter wrote:
> Larry McVoy wrote:
> > Hi, we've got a problem in one of Linus' trees and it has started to
> > propagate around.  I need your help to track it down and fix it.
> > Please run the following script on your Linux BK trees and contact
> > me if it tells you to do so.  You can fix up the tree by doing the
> > following (warning: takes lots and lots of CPU time so if you don't
> > need the tree it may well be faster to reclone tomorrow after I finish
> > fixing the trees on bkbits).
> 
> Would you mind giving something of a lay-man's explanation of what went 
> wrong and what that means?  In particular, I'm curious about the 
> propagating part...

The short summary is that two people used Linus' import tools and because
of no error on his part, simply the way things worked out, that caused what
we call "duplicate keys" (a lot like duplicate inodes, a lot like it) when
the trees with the imported patch came together.  I wrote a script to fix
up the trees after the fact and the application of that script went wrong
in Linus' tree but was not noticed until later.  It started showing up as
pull errors and then we tracked it down.

The long explanation would take me too long to do in email, I have 
carpal problems and it would amount to writing a "how BK works" paper
and that's too much for me right now.  If you want to understand the
nitty gritty, we can go to voice and I'll tell you.  So far, talking
doesn't seem to hurt my wrists :)
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
