Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbTDIJW0 (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 05:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262947AbTDIJW0 (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 05:22:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:42707 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262943AbTDIJWY (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 05:22:24 -0400
Date: Wed, 9 Apr 2003 11:33:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Andre Hedrick <andre@linux-ide.org>, keitha@edp.fastfreenet.com,
       linux-kernel@vger.kernel.org
Subject: Re: bdflush flushing memory mapped pages.
Message-ID: <20030409093347.GA1227@suse.de>
References: <007601c2fecd$12209070$230110ac@kaws> <Pine.LNX.4.10.10304090209440.12558-100000@master.linux-ide.org> <20030409022726.1ec93a0f.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030409022726.1ec93a0f.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09 2003, Andrew Morton wrote:
> Andre Hedrick <andre@linux-ide.org> wrote:
> >
> > 
> > Funny you mention this point!
> > 
> > I just spent 30-45 minutes on the phone talking to Jens about this very
> > issue.  Jens states he can map the model in to 2.5. and will give it a
> > fling in a bit.  This issue is a must; however, I had given up on the idea
> > until 2.7.  However, the issues he and I addressed, in combination to your
> > request jive in sync.
> 
> noooo.....   This isn't going to happen.  There are many reasons.

[snip]

This isn't Andres point at all. He wants a way to defer completion of
requests to the block layer until you actually know they are on platter.
I think he just tied it into this thread because it sort-of deals with
deferred errors as well.

-- 
Jens Axboe

