Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265271AbSJaR5a>; Thu, 31 Oct 2002 12:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265261AbSJaRz4>; Thu, 31 Oct 2002 12:55:56 -0500
Received: from waste.org ([209.173.204.2]:37053 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S265267AbSJaRxw>;
	Thu, 31 Oct 2002 12:53:52 -0500
Date: Thu, 31 Oct 2002 12:00:09 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: What's left over.
Message-ID: <20021031180009.GC3620@waste.org>
References: <20021031163650.GC25906@waste.org> <Pine.LNX.4.44.0210310937550.1410-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210310937550.1410-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 09:38:41AM -0800, Linus Torvalds wrote:
> 
> Note that as far as ACL's go, enough people have convinced me that we want 
> them, with clear real-life issues. So don't worry about them, I'll merge 
> it.

Ok, so now lets work on a Documentation/filesystems patch pointing
out a few of the common pitfalls, as I definitely agree they invite
some grave mistakes and are best avoided in most scenarios.

- /tmp-style symlink issues on shared directories
- vast majority of software (including security tools) ACL-unaware
- much harder to check for correctness

Al, I'm sure you have more..

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
