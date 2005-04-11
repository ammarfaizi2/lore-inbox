Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVDKAaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVDKAaN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 20:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVDKAaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 20:30:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47073 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261647AbVDKAaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 20:30:06 -0400
Date: Mon, 11 Apr 2005 02:30:05 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Willy Tarreau <willy@w.ods.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: Re: Re: [ANNOUNCE] git-pasky-0.1
Message-ID: <20050411003005.GG5902@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050410173349.GA17549@elte.hu> <20050410174221.GD7858@alpha.home.local> <20050410174512.GA18768@elte.hu> <20050410184522.GA5902@pasky.ji.cz> <Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Apr 10, 2005 at 10:38:11PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
..snip..
> Can you pull my current repo, which has "diff-tree -R" that does what the 
> name suggests, and which should be faster than the 0.48 sec you see..

Am I just missing something, or your diff-tree doesn't handle
added/removed directories?

(Mine does! *hint* *hint* It also doesn't bother with dynamic
allocation, but someone might consider the static path buffer ugly.
Anyway, I hacked it with a plan to do a massive cleanup of the file
later.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
