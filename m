Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275270AbTHGKJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 06:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275273AbTHGKJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 06:09:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35018 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S275270AbTHGKJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 06:09:17 -0400
Date: Thu, 7 Aug 2003 12:09:03 +0200
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: cb-lkml@fish.zetnet.co.uk, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Disk priority dependend on nice level...
Message-ID: <20030807100903.GH858@suse.de>
References: <20030806232810.GA1623@elf.ucw.cz> <20030807055754.GP7982@suse.de> <20030807100104.GA166@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807100104.GA166@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07 2003, Pavel Machek wrote:
> Hi!
> 
> > > I ported `subj` to 2.6.0-test2. I do not yet have idea if it works,
> > > but it compiles ;-).
> > 
> > This wont do much, you might as well forget it. Disk priorities is far
> > more work than you appear to think :)
> 
> This was not my patch, I only ported it.
> 
> I'm not heading for "perfect" disk priorities (not now :-), but having
> something with at least measurable effect would be nice.
> 
> For a start "niced processes get starved during I/O" should do the
> trick. (And it would help my lingvistics workloads).

Well it just cannot work in any sort of useful way like this, I think
the patch is pretty useless...

-- 
Jens Axboe

