Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263093AbVHETMv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263093AbVHETMv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 15:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbVHETMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 15:12:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51890 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263075AbVHETCz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 15:02:55 -0400
Date: Fri, 5 Aug 2005 12:01:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: zanussi@us.ibm.com, linux-kernel@vger.kernel.org, karim@opersys.com,
       prasadav@us.ibm.com
Subject: Re: [-mm patch] relayfs: add read() support
Message-Id: <20050805120115.4f511e36.akpm@osdl.org>
In-Reply-To: <20050805155826.GT5561@suse.de>
References: <17138.53203.430849.147593@tut.ibm.com>
	<20050805144926.GS5561@suse.de>
	<17139.32831.571021.34524@tut.ibm.com>
	<20050805155826.GT5561@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> On Fri, Aug 05 2005, Tom Zanussi wrote:
> > Jens Axboe writes:
> >  > On Thu, Aug 04 2005, Tom Zanussi wrote:
> >  > > At the kernel summit, there was some discussion of relayfs and the
> >  > > consensus was that it didn't make sense for relayfs to not implement
> >  > > read().  So here's a read implementation...
> >  > 
> >  > It needs a few fixes to actually compile without errors. This works for
> >  > me, just tested with the block tracing stuff, works a charm!
> > 
> > Great, glad to hear it!  I should have noted in the posting, though,
> > that you should first apply the 'API cleanup' patch, in which case you
> > shouldn't get the compile errors.
> 
> Ah, I see. The API is also much cleaner than what I looked at a few
> months ago (even before the cleanup).
> 
> Andrew, can you merge it pretty please?

yup, we'll add relayfs to 2.6.14.
