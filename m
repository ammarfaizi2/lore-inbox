Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUHWRAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUHWRAK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 13:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUHWRAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 13:00:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19870 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265812AbUHWRAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 13:00:05 -0400
Date: Mon, 23 Aug 2004 18:59:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: serialize access to ide device
Message-ID: <20040823165954.GA24089@suse.de>
References: <20040802131150.GR10496@suse.de> <200408211913.47982.bzolnier@elka.pw.edu.pl> <20040823121540.GN2301@suse.de> <200408231702.54426.bzolnier@elka.pw.edu.pl> <412A1645.4070200@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412A1645.4070200@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23 2004, Jeff Garzik wrote:
> As a tangent...
> 
> 
> Per-host synchronization is REQUIRED for controllers which indicate 
> "simplex" BMDMA.  And I think for some strange non-simplex controllers 
> too (though I guess they could be classified as simplex).

I think this is exactly the case mentioned (where that level of
serialization is required), so not a tangent :)

-- 
Jens Axboe

