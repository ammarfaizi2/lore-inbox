Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263539AbUA3UIX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 15:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbUA3UIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 15:08:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:25791 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263510AbUA3UIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 15:08:20 -0500
Date: Fri, 30 Jan 2004 12:09:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: gene.heskett@verizon.net
Cc: util@deuroconsult.ro, hyatt@cis.uab.edu, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: Re: 2.6.2-rc2 Interactivity problems with SMP + HT
Message-Id: <20040130120933.5d2d6d34.akpm@osdl.org>
In-Reply-To: <200401301033.43909.gene.heskett@verizon.net>
References: <Pine.LNX.4.44.0401290901510.21120-100000@crafty.cis.uab.edu>
	<Pine.LNX.4.58.0401300919520.8217@hosting.rdsbv.ro>
	<200401301033.43909.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:
>
> On Friday 30 January 2004 02:25, Catalin BOIE wrote:
> >On Thu, 29 Jan 2004, Robert M. Hyatt wrote:
> >> It might be some IDE disk I/O that results from flushing buffers
> >> or whatever.  I don't see this on my SCSI boxes, but I have seen
> >> an IDE box get sluggish at times due to I/O.
> >
> >It is possible.
> >vmstat shows a lot of writes when this happen.
> >Seems that even reads hangs.
> >I remember tat I was in pine and I tried to save a small file (under
> > 1k) and it took 5-7 seconds to do it.
> >
> I'm having similar problems with kmail on the later kernels.

There's a problem with reiserfs and kmail.  If you're using reiserfs, be
sure to have the latest kmail installed, or mount the filesytems with
`nolargeio=1'.
