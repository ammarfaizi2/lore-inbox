Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbWCHKRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbWCHKRU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 05:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWCHKRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 05:17:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:4401 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932548AbWCHKRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 05:17:19 -0500
Date: Wed, 8 Mar 2006 11:17:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Mike Christie <michaelc@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] update max_sectors documentation
Message-ID: <20060308101659.GJ4595@suse.de>
References: <1141777621.5594.3.camel@max>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141777621.5594.3.camel@max>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07 2006, Mike Christie wrote:
> Hi Jens,
> 
> I was looking over Kai's scsi command size email and was going to try
> and add it to some block docs and noticed I did not send the update to
> the max_sectors biodoc.txt. Sorry about that. Here is the patch against
> 2.6.16-rc5.
> 
> The max_sectors has been split into max_hw_sectors and max_sectors for some
> time. A patch to have blk_queue_max_sectors enforce this was sent by
> me and it broke IDE. This patch updates the documentation.

Thanks Mike, committed.

-- 
Jens Axboe

