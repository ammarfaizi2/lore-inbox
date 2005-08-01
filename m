Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbVHAUmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbVHAUmN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVHAUmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:42:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27882 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261261AbVHAUkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:40:42 -0400
Date: Mon, 1 Aug 2005 22:42:42 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Daniel Drake <dsd@gentoo.org>, Otto Meier <gf435@gmx.net>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Driver for sata adapter promise sata300 tx4
Message-ID: <20050801204241.GU22569@suse.de>
References: <42EDE918.9040807@gmx.net> <42EE3501.7010107@gentoo.org> <42EE3FB8.10008@gmx.net> <42EE4ADF.4080502@gentoo.org> <20050801201756.GQ22569@suse.de> <20050801203228.GS22569@suse.de> <42EE87DF.1080508@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EE87DF.1080508@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01 2005, Jeff Garzik wrote:
> Jens Axboe wrote:
> >Oh, and forget TCQ. It's a completely worthless technology inherited
> >from PATA,
> 
> Agreed.
> 
> There are a few controllers where we may -eventually- add TCQ support, 
> controllers that do 100% of TCQ in hardware.  But that's so far down the 
> priority list, it's below just about everything else.
> 
> There may just be little motivation to -ever- support TCQ, even when 
> libata is the 'main' IDE driver, sometime in the future.

Host supported TCQ only removes the pain from the software side, it
still doesn't make it a fast techology. The only reason you would want
to support that would be "it's easy, why not...". From my POV, I would
refuse to support it just from an ideological standpoint :-)

Legacy TCQ, hell no, not in a million years.

-- 
Jens Axboe

