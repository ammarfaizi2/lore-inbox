Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbUC0RyU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 12:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUC0RyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 12:54:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:22234 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261844AbUC0RyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 12:54:19 -0500
Date: Sat, 27 Mar 2004 18:54:12 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm4
Message-ID: <20040327175412.GB3175@suse.de>
References: <20040326131816.33952d92.akpm@osdl.org> <20040326132212.14bac327.akpm@osdl.org> <20040326214007.A10869@infradead.org> <20040326140027.044c96a3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040326140027.044c96a3.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26 2004, Andrew Morton wrote:
> > > 
> > >  Suppress cdroms in /proc/partitions
> > 
> > What's this patch trying to archive?  IDE cdroms are partitionable in
> > 2.5..

I'm not trying to kill partioning (which doesn't exist, btw), it's just
an artifact of flagging the gendisk removable that they don't show up in
/proc/partitions

-- 
Jens Axboe

