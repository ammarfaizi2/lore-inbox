Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVHAUeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVHAUeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVHAUeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:34:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:18149 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261151AbVHAUds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:33:48 -0400
Date: Mon, 1 Aug 2005 22:35:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Daniel Drake <dsd@gentoo.org>, Otto Meier <gf435@gmx.net>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Driver for sata adapter promise sata300 tx4
Message-ID: <20050801203540.GT22569@suse.de>
References: <42EDE918.9040807@gmx.net> <42EE3501.7010107@gentoo.org> <42EE3FB8.10008@gmx.net> <42EE4ADF.4080502@gentoo.org> <20050801201756.GQ22569@suse.de> <42EE866B.5030005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EE866B.5030005@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Mon, Aug 01 2005, Daniel Drake wrote:
> >
> >>Otto Meier wrote:
> >>
> >>>My question is also are these features (NCQ/TCQ) and the heigher 
> >>>datarate be supported by this
> >>>modification? or is only the basic feature set of sata 150 TX4 supported?
> >>
> >>NCQ support is under development. Search the archives for Jens Axboe's 
> >>recent patches to support this. I don't know about TCQ.
> >
> >
> >It's done for ahci, because we have documentation. I have no intention
> >on working on NCQ for chipset where full documentation is not available.
> >But the bulk of the code is the libata core support, adding NCQ support
> >to a sata_* driver should now be fairly trivial (with docs).
> 
> 
> I have docs for the Promise NCQ stuff.  Once NCQ is fully fleshed out (I 
> haven't wrapped my brain around it in a couple weeks), it shouldn't be 
> difficult to add NCQ support to sata_promise.

Excellent!

-- 
Jens Axboe

