Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261821AbTCGW1O>; Fri, 7 Mar 2003 17:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261825AbTCGW1O>; Fri, 7 Mar 2003 17:27:14 -0500
Received: from packet.digeo.com ([12.110.80.53]:62876 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261821AbTCGW1L>;
	Fri, 7 Mar 2003 17:27:11 -0500
Date: Fri, 7 Mar 2003 14:33:19 -0800
From: Andrew Morton <akpm@digeo.com>
To: Greg KH <greg@kroah.com>
Cc: hch@infradead.org, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-Id: <20030307143319.2413d1df.akpm@digeo.com>
In-Reply-To: <20030307221217.GB21315@kroah.com>
References: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl>
	<20030307193644.A14196@infradead.org>
	<20030307123029.2bc91426.akpm@digeo.com>
	<20030307221217.GB21315@kroah.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 22:37:40.0443 (UTC) FILETIME=[293A2AB0:01C2E4FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Fri, Mar 07, 2003 at 12:30:29PM -0800, Andrew Morton wrote:
> > 
> > 32-bit dev_t is an important (and very late!) thing to get into the 2.5
> > stream.  Can we put this ahead of cleanup stuff?
> 
> Can we get people to agree that this will even go into 2.5, due to the
> lateness of it?  I didn't think it was going to happen.

I've never seen the patches so I cannot say.  But I'd at least like to get
the whole thing under test so we can make that evaulation.

> But if it is, a lot of character drivers need to be audited...

What has to be done there?
