Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262690AbTCTXlI>; Thu, 20 Mar 2003 18:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbTCTXkP>; Thu, 20 Mar 2003 18:40:15 -0500
Received: from packet.digeo.com ([12.110.80.53]:16562 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262661AbTCTXkC>;
	Thu, 20 Mar 2003 18:40:02 -0500
Date: Thu, 20 Mar 2003 17:55:32 -0800
From: Andrew Morton <akpm@digeo.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Release of 2.4.21
Message-Id: <20030320175532.3ef85c1b.akpm@digeo.com>
In-Reply-To: <20030320204218.A18517@infradead.org>
References: <20030320195657.GA3270@drcomp.erfurt.thur.de>
	<874r5xyeky.fsf@sdbk.de>
	<20030320203407.GF8256@gtf.org>
	<20030320204218.A18517@infradead.org>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Mar 2003 23:50:16.0312 (UTC) FILETIME=[74E5C780:01C2EF3B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Mar 20, 2003 at 03:34:07PM -0500, Jeff Garzik wrote:
> > For critical fixes, release a 2.4.20.1, 2.4.20.2, etc.  Don't disrupt
> > the 2.4.21-pre cycle, that would be less productive than just patching
> > 2.4.20 and rolling a separate release off of that.
> 
> I think the naming is illogical.  If there's a bugfix-only release
> it whould have normal incremental numbers.  So if marcelo want's
> it he should clone a tree of at 2.4.20, apply the essential patches
> and bump the version number in the normal 2.4 tree to 2.4.22-pre1

No point in making things too complex.  2.4.20-post1 is something people can
easily understand.

I needed that for the ext3 problems which popped up shortly after 2.4.20 was
released - I was reduced to asking people to download fixes from my web page.

And having a -post stream may allow us to be a bit more adventurous in the
-pre stream.

