Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030329AbVIVNYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030329AbVIVNYM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbVIVNYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:24:12 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29485 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030325AbVIVNYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:24:10 -0400
Date: Thu, 22 Sep 2005 15:24:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Mark Lord <liml@rtr.ca>
Cc: Jeff Garzik <jgarzik@pobox.com>, Joshua Kwan <joshk@triplehelix.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: SATA suspend-to-ram patch - merge?
Message-ID: <20050922132406.GH4262@suse.de>
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com> <20050922061849.GJ7929@suse.de> <4332ABDC.3030106@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4332ABDC.3030106@rtr.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22 2005, Mark Lord wrote:
> >>So currently we are in limbo...
> >
> >Which is a shame, since it means that software suspend on sata is
> >basically impossible :)
> 
> Except that it actually does work, with Jen's patch.

(Jens's, not Jen's!)

Yes, I'm very aware of that. The above note refers to what is currently
shipping in Linus's tree, and sata suspend definitely does not work
there.

> Rather than sitting around for another six months hoping the problem
> will go away (it won't), perhaps we should just update/merge Jen's
> patch as a sorely needed interim fix.
> 
> This might then prod James et al into looking more at the SCSI side of
> things, and some year we might see this get replaced with a better scheme.
> 
> This is a real problem, and an immediate solution is needed last spring.

Could not have said it better myself. It's not like the patch is hack
either.

-- 
Jens Axboe

