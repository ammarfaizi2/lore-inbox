Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266311AbUHISMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUHISMo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266824AbUHISMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:12:41 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:33454 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266819AbUHISMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:12:17 -0400
Date: Mon, 9 Aug 2004 20:12:01 +0200
From: Jens Axboe <axboe@suse.de>
To: brking@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] blk_queue_tags_resize_failure
Message-ID: <20040809181201.GE28171@suse.de>
References: <200408091550.i79FoDat359564@westrelay02.boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408091550.i79FoDat359564@westrelay02.boulder.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09 2004, brking@us.ibm.com wrote:
> 
> Fixes blk_queue_resize_tags to properly handle allocation failures.
> Currently, if a memory allocation failure occurs during
> blk_queue_resize_tags, the tag map ends up getting freed, which should
> not happen. The old tag map should be preserved and only the resize
> should fail.

Shows it hasn't been used much yet :-)

Thanks, applied.

-- 
Jens Axboe

