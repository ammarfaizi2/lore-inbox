Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266827AbUHISNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266827AbUHISNU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266819AbUHISNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:13:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:20142 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266816AbUHISLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:11:37 -0400
Date: Mon, 9 Aug 2004 20:11:33 +0200
From: Jens Axboe <axboe@suse.de>
To: brking@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] blk_resize_tags_fix
Message-ID: <20040809181133.GD28171@suse.de>
References: <200408091551.i79FpAeQ063458@northrelay04.pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091551.i79FpAeQ063458@northrelay04.pok.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09 2004, brking@us.ibm.com wrote:
> 
> init_tag_map should not initialize the busy_list, refcnt, or busy fields
> in the tag map since blk_queue_resize_tags can call it while requests are
> active. Patch moves this initialization into blk_queue_init_tags.
> 
> Signed-off-by: Brian King <brking@us.ibm.com>

Thanks Brian, applied.

-- 
Jens Axboe

