Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTLWQcv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 11:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbTLWQcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 11:32:47 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:59024 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261784AbTLWQcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 11:32:46 -0500
Date: Tue, 23 Dec 2003 17:32:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Pascal Schmidt <der.eremit@email.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-mm1
Message-ID: <20031223163245.GA23184@suse.de>
References: <15N7L-7y2-3@gated-at.bofh.it> <E1AYofU-0000QA-00@neptune.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AYofU-0000QA-00@neptune.local>
X-OS: Linux 2.4.23aa1-axboe i686
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23 2003, Pascal Schmidt wrote:
> On Tue, 23 Dec 2003 06:20:14 +0100, you wrote in linux.kernel:
> 
> > +atapi-mo-support.patch
> > 
> >  Fix support for ATAPI MO drives (needs updating to reflect the changes in
> >  mt-ranier-support.patch).
> > 
> > +mt-ranier-support.patch
> > 
> >  Mt Ranier support in the CDROM uniform layer.
> 
> Since the atapi-mo patch is mine, is there something I need to do?

Nah don't worry about it, Andrew and I just agreed that I'd merge the
remaining changes once 2.6.0-mm1 was up. Basically, MO needs to set
_RAM capability so we can kill the various MO checks.

Jens

