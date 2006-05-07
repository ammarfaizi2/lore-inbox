Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWEHHCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWEHHCc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 03:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWEHHCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 03:02:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48141 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S932355AbWEHHCb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 03:02:31 -0400
Date: Sun, 7 May 2006 07:35:39 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: minixfs bitmaps and associated lossage
Message-ID: <20060507073539.GA5765@ucw.cz>
References: <44560796.8010700@gmail.com> <20060506162956.GO27946@ftp.linux.org.uk> <20060506163737.GP27946@ftp.linux.org.uk> <20060506220451.GQ27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060506220451.GQ27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	Warning: text below is a mild example of software coproarchaeology,
> so if you are easily squicked by tangled mess of bugs and dumb lossage,
> well... you've been warned.

:-)

> 	So...  What the hell can we do?  Layouts (4) and (5) are clearly
> broken and _never_ worked - there's nothing that would manage to create
> such filesystem.  So these are obvious candidates for switching - either
> to (2) (correct) or to (3) (broken, but at least match util-linux fsck.minix
> and mkfs.minix on such platforms).  The question being, what do we do with
> (3) (big-endian metadata, little-endian bitmaps) and what do we do with
> Linux fsck.minix?  Aside of repeating the mantra, that is ("All Software
> Sucks, All Hardware Sucks")...

Remove minix write support? Only writers care about bitmap layout,
right?
							Pavel
-- 
Thanks for all the (sleeping) penguins.
