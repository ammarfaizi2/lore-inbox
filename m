Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261768AbTCGUT7>; Fri, 7 Mar 2003 15:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261766AbTCGUT7>; Fri, 7 Mar 2003 15:19:59 -0500
Received: from packet.digeo.com ([12.110.80.53]:63127 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261764AbTCGUTx>;
	Fri, 7 Mar 2003 15:19:53 -0500
Date: Fri, 7 Mar 2003 12:30:29 -0800
From: Andrew Morton <akpm@digeo.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andries.Brouwer@cwi.nl, hch@infradead.org, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-Id: <20030307123029.2bc91426.akpm@digeo.com>
In-Reply-To: <20030307193644.A14196@infradead.org>
References: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl>
	<20030307193644.A14196@infradead.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 20:30:19.0773 (UTC) FILETIME=[5F0872D0:01C2E4E8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Mar 07, 2003 at 08:32:01PM +0100, Andries.Brouwer@cwi.nl wrote:
> > > IMHO that's a bad change, (un)register_blkdev should just go away
> > > completly.
> > 
> > Yes, it would be best if the kernel became perfect at once.
> > But the patch is rather large. Better go in small steps.
> > 
> > Did you read the patch?
> 
> Yes, I did.  What I object to is the prototype changes you did which
> make absolutely no sense to get into 2.5 now when the functions will
> disappear before 2.6.  Feel free to change the actual implementation,
> I couldn't care less on you wasting your time on that :)

32-bit dev_t is an important (and very late!) thing to get into the 2.5
stream.  Can we put this ahead of cleanup stuff?

