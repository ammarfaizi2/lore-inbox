Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261884AbTCGXma>; Fri, 7 Mar 2003 18:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261877AbTCGXlz>; Fri, 7 Mar 2003 18:41:55 -0500
Received: from packet.digeo.com ([12.110.80.53]:59295 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261905AbTCGXkT>;
	Fri, 7 Mar 2003 18:40:19 -0500
Date: Fri, 7 Mar 2003 15:46:24 -0800
From: Andrew Morton <akpm@digeo.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: cherry@osdl.org, rddunlap@osdl.org, hch@infradead.org,
       Joel.Becker@oracle.com, greg@kroah.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] register_blkdev
Message-Id: <20030307154624.12105fa3.akpm@digeo.com>
In-Reply-To: <20030307233636.A19260@infradead.org>
References: <UTC200303071932.h27JW1o11962.aeb@smtp.cwi.nl>
	<20030307193644.A14196@infradead.org>
	<20030307123029.2bc91426.akpm@digeo.com>
	<20030307221217.GB21315@kroah.com>
	<20030307225517.GF2835@ca-server1.us.oracle.com>
	<20030307225710.A18005@infradead.org>
	<20030307151744.73738fdd.rddunlap@osdl.org>
	<1047080297.10926.180.camel@cherrytest.pdx.osdl.net>
	<20030307233636.A19260@infradead.org>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Mar 2003 23:50:45.0868 (UTC) FILETIME=[5F24EAC0:01C2E504]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> If you actually looked at the block layer code instead of just talking
> along you'd see that the major/minor split has absolutely zero meaning
> for the actual driver interface in 2.5.  The only major numbers have
> any meanting to is pretty printing (/proc/devices and __bdevname).
> 

Christoph, it would help this discussion very much if you could tell everyone
how we should set about solving the many-disks problem.  In detail.

Thanks.

