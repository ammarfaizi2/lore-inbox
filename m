Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310261AbSCKRKv>; Mon, 11 Mar 2002 12:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310279AbSCKRKm>; Mon, 11 Mar 2002 12:10:42 -0500
Received: from bitmover.com ([192.132.92.2]:4525 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S310261AbSCKRKc>;
	Mon, 11 Mar 2002 12:10:32 -0500
Date: Mon, 11 Mar 2002 09:10:31 -0800
From: Larry McVoy <lm@bitmover.com>
To: Tom Lord <lord@regexps.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
Message-ID: <20020311091031.O26447@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Tom Lord <lord@regexps.com>, linux-kernel@vger.kernel.org
In-Reply-To: <200203092222.OAA03372@morrowfield.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200203092222.OAA03372@morrowfield.home>; from lord@regexps.com on Sat, Mar 09, 2002 at 02:22:33PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2002 at 02:22:33PM -0800, Tom Lord wrote:
>        $ bk mv old new 
> 
>        No danger, no drawbacks, no hand editing of history files. 
> 
> I like the arch way of renaming a file:
> 
> 	$ mv old new
> 
> (Yes, history is preserved, etc.)

Come on, Tom, truth in advertising.  If you don't have the file identifier 
in the file, what you just described doesn't work.

Arch has a concept of an "inode" quite similar to BitKeeper, in fact
one wonders where the idea came from :-), and as long as the the "inode"
is embedded in the file, you can do what Tom says above.  If it isn't,
that won't work, no matter what he says.  I speak from the experience
of importing lots of kernel versions into BK and trying to automate the
detection of renames.  Can't be done and if Tom claims it can, then 
ask him to demonstrate how by taking a a few thousand kernel patches
and autodetecting the renames.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
