Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbVJMTQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbVJMTQD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 15:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbVJMTQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 15:16:02 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24155 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750823AbVJMTQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 15:16:01 -0400
Date: Thu, 13 Oct 2005 21:16:43 +0200
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] remove gendisk->stamp_idle field
Message-ID: <20051013191642.GN6603@suse.de>
References: <200510131913.j9DJDNg07632@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510131913.j9DJDNg07632@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13 2005, Chen, Kenneth W wrote:
> struct gendisk has these two fields: stamp, stamp_idle.  Update to
> stamp_idle is always in sync with stamp and they are always the same.
> Therefore, it does not add any value in having two fields tracking
> same timestamp.  Suggest to remove it.
> 
> Also, we should only update gendisk stats with non-zero value.
> Advantage is that we don't have to needlessly calculate memory address,
> and then add zero to the content.

Acked-by: Jens Axboe <axboe@suse.de>

Added to the upstream Linus branch of the block git tree.

-- 
Jens Axboe

