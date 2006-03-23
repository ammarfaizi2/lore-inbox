Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWCWDcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWCWDcc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWCWDcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:32:31 -0500
Received: from main.gmane.org ([80.91.229.2]:52695 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932134AbWCWDca (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:32:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [GIT PATCH] Remove devfs from 2.6.16
Date: Thu, 23 Mar 2006 12:33:13 +0900
Message-ID: <dvt4rl$2b8$1@sea.gmane.org>
References: <20060320212338.GA11571@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s185160.ppp.asahi-net.or.jp
User-Agent: Mail/News 1.5 (X11/20060322)
In-Reply-To: <20060320212338.GA11571@kroah.com>
X-Enigmail-Version: 0.94.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> They are the same "delete devfs" patches that I submitted for 2.6.12 and
> 2.6.13 and 2.6.14 and 2.6.15.  It rips out all of devfs from the kernel
> and ends up saving a lot of space.  Since 2.6.13 came out, I have seen
> no complaints about the fact that devfs was not able to be enabled
> anymore, and in fact, a lot of different subsystems have already been
> deleting devfs support for a while now, with apparently no complaints
> (due to the lack of users.)
> 
> It's also been over 8 months past the date when we said we would delete
> devfs from the kernel tree in the file,
> Documentation/feature-removal-schedule.txt, and over one and one half
> years since we publicly announced to the world that devfs would be
> removed from the kernel tree.  So, I think people have had plenty of
> advance notice that this was going to happen by now :)
> 
> Please pull from:
> 	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/devfs-2.6.git/
> or if master.kernel.org hasn't synced up yet:
> 	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/devfs-2.6.git/
> 
> I've posted all of these patches before, but if people really want to look at them, they can be found at:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-05-devfs/
> 
> Also, if people _really_ are in love with the idea of an in-kernel
> devfs, I have posted a patch that does this in about 300 lines of code,
> called ndevfs.  It is available in the archives if anyone wants to use
> that instead (it is quite easy to maintain that patch outside of the
> kernel tree, due to it only needing 3 hooks into the main kernel tree.)

OK, I completely agree with that, but shouldn't there be left something in
the Documentation at least? A note like "devfs was superseded by udev since
2.6.?? and was completely removed since 2.6.??" or something along the same
line of thought? It will just make life easier for people finding lots of
old pages and HOWTOs on the Net mentioning devfs.

Unfortunately I couldn't find a proper place for that note...
Maybe a new file Documentation/filesystems/devfs.txt instead of the 
Documentation/filesystems/devfs directory present now?


Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

