Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVFWBS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVFWBS5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 21:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbVFWBS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:18:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25238 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261830AbVFWBSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:18:53 -0400
Date: Wed, 22 Jun 2005 18:18:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Bell <kernel@mikebell.org>
Cc: greg@kroah.com, gregkh@suse.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
Message-Id: <20050622181825.204fbcb7.akpm@osdl.org>
In-Reply-To: <20050623010031.GB17453@mikebell.org>
References: <20050621062926.GB15062@kroah.com>
	<20050620235403.45bf9613.akpm@osdl.org>
	<20050621151019.GA19666@kroah.com>
	<20050623010031.GB17453@mikebell.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Bell <kernel@mikebell.org> wrote:
>
> On Tue, Jun 21, 2005 at 08:10:19AM -0700, Greg KH wrote:
> > There might be some complaints.  But I doubt they would be from anyone
> > running a -mm tree as those people kind of know the current status of
> > things in the kernel.  There have been numerous warnings as to the fact
> > that this was going away, and I waited a _year_ to do this.
> 
> I use -mm and I'm complaining.

Thanks!

> It breaks a lot of my embedded setups which have read-only storage only
> and thus need /dev on devfs or tmpfs.

Well that's quite a problem.  We're certainly causing people such as
yourself to take on quite a lot of work.  But on the other hand we do want
the kernel to progress sanely, and that sometimes involves taking things
out.

I don't have enough info to know whether the world would be a better place
if we keep devfs, remove devfs or remove devfs even later on.  I don't
think anyone knows, which is why we're taking this little
disable-it-and-see-who-shouts approach.
