Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262867AbTEBBoj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 21:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbTEBBoj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 21:44:39 -0400
Received: from adsl-157-199-211.dab.bellsouth.net ([66.157.199.211]:34789 "EHLO
	midgaard.us") by vger.kernel.org with ESMTP id S262867AbTEBBog
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 21:44:36 -0400
Subject: Re: must-fix list for 2.6.0
From: Andreas Boman <aboman@midgaard.us>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030501194711.A24651@infradead.org>
References: <20030429155731.07811707.akpm@digeo.com>
	 <20030501153325.A15458@infradead.org>
	 <20030501114229.64fbbfa2.akpm@digeo.com>
	 <20030501194711.A24651@infradead.org>
Content-Type: text/plain
Message-Id: <1051840627.913.2.camel@asgaard.midgaard.us>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (Preview Release)
Date: 01 May 2003 20:57:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-01 at 13:47, Christoph Hellwig wrote:
> On Thu, May 01, 2003 at 11:42:29AM -0700, Andrew Morton wrote:
> > I had two concerns with smalldevfs:
> > 
> > - It's dropping a semaphore (i_sem?) during its synchronous userspace
> >   callout.  That was for deadlock avoidance and may have introduced a race.
> 
> That's a design bug carried over from the old devfs and needs fixing by
> changing the way userspace notification works.
> 
> > - The new userspace doesn't support the compatibility names.  Just some
> >   config file, or a tarball or a dang shell script full of `ln -s'
> >   calls would fix that up, I think.
> 
> Well, that's easily fixable.  Does someone actually have a copy if the
> devfs_helper tarball around?  Adam's seems to have vanished and his
> ftp server is down, too.
> 
I think this is the latest tarball Adam had, though i could be mistaken.
http://users.eiwaz.com/~aboman/files/misc/devfs_helper-0.2.tar.gz

	Andreas


