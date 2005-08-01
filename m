Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVHAUab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVHAUab (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVHAUaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:30:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29154 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261221AbVHAUa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:30:28 -0400
Date: Mon, 1 Aug 2005 22:32:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Daniel Drake <dsd@gentoo.org>
Cc: Otto Meier <gf435@gmx.net>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Driver for sata adapter promise sata300 tx4
Message-ID: <20050801203228.GS22569@suse.de>
References: <42EDE918.9040807@gmx.net> <42EE3501.7010107@gentoo.org> <42EE3FB8.10008@gmx.net> <42EE4ADF.4080502@gentoo.org> <20050801201756.GQ22569@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801201756.GQ22569@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01 2005, Jens Axboe wrote:
> On Mon, Aug 01 2005, Daniel Drake wrote:
> > Otto Meier wrote:
> > >My question is also are these features (NCQ/TCQ) and the heigher 
> > >datarate be supported by this
> > >modification? or is only the basic feature set of sata 150 TX4 supported?
> > 
> > NCQ support is under development. Search the archives for Jens Axboe's 
> > recent patches to support this. I don't know about TCQ.
> 
> It's done for ahci, because we have documentation. I have no intention
> on working on NCQ for chipset where full documentation is not available.
> But the bulk of the code is the libata core support, adding NCQ support
> to a sata_* driver should now be fairly trivial (with docs).

Oh, and forget TCQ. It's a completely worthless technology inherited
from PATA, whos continued existence can only be explained by some
companies having invested money adding firmware support for it already
and/or because it sounds good to marketing who apparently rely on
customers thinking it must be similar to SCSI TCQ because it shares the
same name. In reality, they really share nothing. IDE TCQ makes a
mockery of the TLA, I hope the people that came up with it bury their
heads in shame for having wasted peoples time actually tring it out.

-- 
Jens Axboe

