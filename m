Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbTH1Tpv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 15:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264187AbTH1Tpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 15:45:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6099 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264147AbTH1Tpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 15:45:49 -0400
Date: Thu, 28 Aug 2003 21:45:48 +0200
From: Jens Axboe <axboe@suse.de>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why no cdda cdrom dma use in 2.6?
Message-ID: <20030828194548.GG16684@suse.de>
References: <3F4E5ACC.1090500@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4E5ACC.1090500@wmich.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 28 2003, Ed Sweetman wrote:
> It seems like this is a win win patch for the cdrom that was heavily 
> tested in 2.4 in the akpm tree. I'm just wondering why it was never 
> incorporated into 2.5 and thus 2.6? It's a shame to not have it in the 
> kernel by default.

>From my perspective, it would be fine to include in 2.6 right now. The
2.4 patch relied heavily on buffer_heads though, so you would have to
adapt the patch to bio first. Actually, it should be doable in a much
less hackish manner.

-- 
Jens Axboe

