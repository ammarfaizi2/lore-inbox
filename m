Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbTDIJCD (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 05:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTDIJCD (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 05:02:03 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:22534
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262933AbTDIJCC (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 05:02:02 -0400
Date: Wed, 9 Apr 2003 02:13:03 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Keith Ansell <keitha@edp.fastfreenet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
Subject: Re: bdflush flushing memory mapped pages. 
In-Reply-To: <007601c2fecd$12209070$230110ac@kaws>
Message-ID: <Pine.LNX.4.10.10304090209440.12558-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Funny you mention this point!

I just spent 30-45 minutes on the phone talking to Jens about this very
issue.  Jens states he can map the model in to 2.5. and will give it a
fling in a bit.  This issue is a must; however, I had given up on the idea
until 2.7.  However, the issues he and I addressed, in combination to your
request jive in sync.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Wed, 9 Apr 2003, Keith Ansell wrote:

> help
> 
> My application uses SHARED memory mapping files for file I/O, and we have
> observed
> that Linux does not flush dirty pages to disk until munmap or msync are
> called.
> 
> I would like to know are there any development plans which would address
> this issue or
> if there is a version of bdflush which flushes write required pages (dirty
> pages) to disk?
> 
> Regards
>         Keith Ansell.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

