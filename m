Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbWGUBGg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbWGUBGg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 21:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030423AbWGUBGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 21:06:36 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:5717 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030425AbWGUBGf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 21:06:35 -0400
Date: Fri, 21 Jul 2006 03:06:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: Ed Lin <ed.lin@promise.com>,
       "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
       "James.Bottomley" <James.Bottomley@SteelEye.com>,
       hch <hch@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>, promise_linux <promise_linux@promise.com>
Subject: Re: [PATCH] Promise 'stex' driver
Message-ID: <20060721010622.GA24176@suse.de>
References: <NONAMEBMcvsq9IcVux1000001f9@nonameb.ptu.promise.com> <44BFF539.4000700@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44BFF539.4000700@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20 2006, Jeff Garzik wrote:
> 5) [agreement/correction]  The block tagging API supports adapter-wide
> tags just fine.  HOWEVER, I nonetheless feel that block tagging API use
> should be considered post-merge.  The 'stex' driver is working and
> tested today.  Since _no individual SCSI driver_ uses the block layer
> tagging, it is likely that some instability and core kernel development
> will occur, in order to make that work.

I'd disagree. If the driver gets merged with the current tagging, I'll
get you two beers that it never gets changed.

And you are wrong, block layer tagging is used by at least one SCSI
driver. We definitely need to start pushing it more.

-- 
Jens Axboe

