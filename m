Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264244AbTE0W1Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTE0W1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:27:24 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:36326 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264244AbTE0W1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:27:24 -0400
Date: Tue, 27 May 2003 15:38:22 -0700
From: Andrew Morton <akpm@digeo.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mark shrinkable slabs as being reclaimable
Message-Id: <20030527153822.7dd47ca3.akpm@digeo.com>
In-Reply-To: <1054074662.26966.4.camel@imladris.demon.co.uk>
References: <200305252319.h4PNJkpJ027852@hera.kernel.org>
	<1054074662.26966.4.camel@imladris.demon.co.uk>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2003 22:40:38.0389 (UTC) FILETIME=[FEC05250:01C324A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Sun, 2003-05-25 at 23:11, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1308, 2003/05/25 15:11:47-07:00, akpm@digeo.com
> > 
> > 	[PATCH] mark shrinkable slabs as being reclaimable
> > 	
> > 	All slabs which can be reclaimed via VM presure are marked as being
> > 	shrinkable, so the core slab code will keep count of their pages.
> 
> If my understanding of this is correct -- stuff that will be freed on
> prune_icache() or other memory pressure should be marked such -- then...

That is correct.

> No.
> No.
> No.

OK ;)  Could you please fix that up in your next code drop?


