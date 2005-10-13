Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbVJMTVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbVJMTVX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbVJMTVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:21:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27230 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751629AbVJMTVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:21:21 -0400
Date: Thu, 13 Oct 2005 21:22:03 +0200
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] optimize disk_round_stats
Message-ID: <20051013192202.GO6603@suse.de>
References: <200510131919.j9DJJkg07781@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510131919.j9DJJkg07781@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13 2005, Chen, Kenneth W wrote:
> Following the same idea, it occurs to me that we should only update
> disk stat when "now" is different from disk->stamp.  Otherwise, we
> are again needlessly adding zero to the stats.

Thanks, also applied.

-- 
Jens Axboe

