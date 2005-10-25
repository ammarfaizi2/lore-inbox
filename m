Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbVJYNe0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbVJYNe0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 09:34:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbVJYNe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 09:34:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26052 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932137AbVJYNeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 09:34:25 -0400
Date: Tue, 25 Oct 2005 15:34:24 +0200
From: Jan Kara <jack@suse.cz>
To: David Teigland <teigland@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/16] GFS: quotas
Message-ID: <20051025133424.GD4244@atrey.karlin.mff.cuni.cz>
References: <20051010171048.GK22483@redhat.com> <20051024121617.GM32605@atrey.karlin.mff.cuni.cz> <20051024160927.GC3755@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051024160927.GC3755@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Oct 24, 2005 at 02:16:17PM +0200, Jan Kara wrote:
> > > Code that deals with quotas.
> >   Is there some documentation how the GFS quotas are supposed to work?
> > I've just briefly looked through the code and it seems they are quite
> > similar to the current VFS ones. What are the differences (especially
> > why don't you implement GFS quotas as just another format of VFS quotas)?
> 
> Hi, yes there is.  It's important for gfs to control when it updates the
> quota file.  If every machine sharing the file system needed to read or
> write the quota file on every operation, it would be a terrible
> bottleneck.  Below is a summary of the current implementation that Ken
> wrote and that I'll add to quota.c; let me know if this helps.
  Thanks a lot for the description. It helped a lot. I think it's now
time to read the code in detail :).

								Honza

