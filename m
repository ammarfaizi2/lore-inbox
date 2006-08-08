Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbWHHTBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWHHTBd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWHHTBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:01:33 -0400
Received: from brick.kernel.dk ([62.242.22.158]:53331 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S965035AbWHHTBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:01:32 -0400
Date: Tue, 8 Aug 2006 21:02:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Matthias Dahl <mlkernel@mortal-soul.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sluggish system responsiveness under higher IO load
Message-ID: <20060808190241.GB11829@suse.de>
References: <200608061200.37701.mlkernel@mortal-soul.de> <200608061554.42992.mlkernel@mortal-soul.de> <20060807134841.GC10444@suse.de> <200608081944.12630.mlkernel@mortal-soul.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608081944.12630.mlkernel@mortal-soul.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08 2006, Matthias Dahl wrote:
> > Can you see if this makes any difference whatsoever?
> 
> Sorry but no change for the better with this patch.
> 
> Are there any more informations I can provide to help?

Ok, it was worth a shot. I got another report that the patch fixes this
behaviour, so maybe we are dealing with two seperate issues. It would be
nice if you could gather vmstat 1 info during a problematic period.
blktrace info could also be very useful:

http://brick.kernel.dk/snaps/blktrace-git-20060807122505.tar.gz

-- 
Jens Axboe

