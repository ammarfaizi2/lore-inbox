Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbWIVOgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbWIVOgr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 10:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbWIVOgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 10:36:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26540 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932542AbWIVOgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 10:36:46 -0400
Date: Fri, 22 Sep 2006 15:36:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: GFS2 & DLM merge request
Message-ID: <20060922143627.GA24953@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Jan Engelhardt <jengelh@linux01.gwdg.de>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <1158935874.11901.408.camel@quoit.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158935874.11901.408.camel@quoit.chygwyn.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 03:37:54PM +0100, Steven Whitehouse wrote:
> Hi,
> 
> Linus, I believe that all the outstanding issues raised by Christoph,
> Jan and others relating to GFS2 and DLM are now settled. Please
> therefore consider pulling from:

Clear NACK from me.  The mails I replied to where only the mails Jan started
nitpicking and I looked a little deeper at what he already quoted, maybe
5% of the codebase.  Given the horrors I found there I'm pretty sure there
will be quite a few more.  And given the amount of junk Andrew plans to push
to Linus for 2.6.19 I'll be pretty busy to look at that, aswell as looking
at things I promised David for month now, so I'm a little busy.

>  include/linux/fs.h                 |    3 
>  include/linux/iflags.h             |  102 
>  include/linux/kernel.h             |    1 
>  mm/filemap.c                       |    3 
>  mm/readahead.c                     |    1 

And while we're at it, please don't push core change as part of a subsystem
tree ever.  They should go into clearly marked and separately patches via
-mm.
