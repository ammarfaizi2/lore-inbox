Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbULJS3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbULJS3f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 13:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbULJS3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 13:29:35 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:17821 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261794AbULJS3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 13:29:20 -0500
Date: Fri, 10 Dec 2004 19:29:17 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [RFC PATCH] debugfs - yet another in-kernel file system
Message-ID: <20041210182917.GA2495@wohnheim.fh-wedel.de>
References: <20041210005055.GA17822@kroah.com> <20041210172126.GA23146@wohnheim.fh-wedel.de> <20041210173556.GA8714@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041210173556.GA8714@kroah.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 December 2004 09:35:56 -0800, Greg KH wrote:
> On Fri, Dec 10, 2004 at 06:21:26PM +0100, J?rn Engel wrote:
> > On Thu, 9 December 2004 16:50:56 -0800, Greg KH wrote:
> 
> > > +#include <linux/config.h>
> > > +#include <linux/module.h>
> > > +#include <linux/fs.h>
> > > +#include <linux/mount.h>
> > > +#include <linux/pagemap.h>
> > > +#include <linux/init.h>
> > > +#include <linux/namei.h>
> > 
> > I like to sort the above alphabetically.  Shouldn't matter, but it
> > looks neat and since there is no other natural order...
> 
> Well config.h should be first.  After that, sometimes it matters, but
> usually not.

I buy the config.h point.  For the rest, I actually like to receive
the breakage when order matters.  It shouldn't matter, so there goes
another patch...

> Just being "correct" :)
> I don't think they would want special nodes, but hey, let's not prevent
> anyone from doing anything.  If some looney person wants to make device
> nodes in debugfs, then they deserve the ridicule they will get when
> doing it...

Thought so.  But hey, there may be valid reasons to do so.  And if
there are, I'd like to hear the story.

Jörn

-- 
When people work hard for you for a pat on the back, you've got
to give them that pat.
-- Robert Heinlein
