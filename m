Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbTEZR6H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 13:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTEZR6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 13:58:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22975 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261923AbTEZR6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 13:58:06 -0400
Date: Mon, 26 May 2003 20:11:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCHES] add ata scsi driver
Message-ID: <20030526181117.GK845@suse.de>
References: <3ED1B261.8030708@pobox.com> <Pine.LNX.4.44.0305260956590.11328-100000@home.transmeta.com> <20030526172405.GJ845@suse.de> <3ED255FE.10609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ED255FE.10609@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26 2003, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Mon, May 26 2003, Linus Torvalds wrote:
> >
> >>>What does the block layer need, that it doesn't have now?
> >>
> >>Exactly. I'd _love_ for people to really think about this.
> >
> >
> >In discussion with Jeff, it seems most of what he wants is already
> >there. He just doesn't know it yet :-)
> 
> 
> Another important point is time.
> 
> I continue to agree that a native block driver is the best direction.
> 
> But with 2.6.0 looming, I think it's best to evolve my ATA driver to be 
> a native block driver from a scsi one.   Not start out as a native 
> driver.  That's significant pre-2.6 churn.

I don't think that makes any sense. If you really do find missing
functionality that are candidates to be generic block property, we can
add them.

> Or, it lives out-of-tree until 2.7 and people with SATA hardware have to 
> go out-of-tree for their driver for months and months, until the working 
> driver is deemed sufficiently native :)  In the meantime, distros 
> wanting working SATA will just ship the SCSI driver as-is.  :(

I don't know why you are even worrying about this yet, time will decide
what happens. As it stands right now, I still consider your driver to be
something to play with, not something that should go into the kernel
anytime soon.

Maybe in 6 months time it has evolved to be something really great, we
add it then. Right now you are still in the design stages in some areas.


-- 
Jens Axboe

