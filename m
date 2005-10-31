Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbVJaTHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbVJaTHl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 14:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbVJaTHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 14:07:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51780 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964794AbVJaTHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 14:07:40 -0500
Date: Mon, 31 Oct 2005 20:08:13 +0100
From: Jens Axboe <axboe@suse.de>
To: Mark Seger <Mark.Seger@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Re: Patch for inconsistent recording of block device statistics]
Message-ID: <20051031190813.GC19267@suse.de>
References: <435D0F45.90906@hp.com> <20051025064014.GO2811@suse.de> <435E7A7B.3040806@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <435E7A7B.3040806@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25 2005, Mark Seger wrote:
> yes, the patch worked.  The general discussion was that the byte counter 
> gets incremented when requests are queued, not when they're acted upon 
> as is the case with the count of I/Os.  As a result, the disk write 
> numbers don't make any sense reporting impossibly high numbers (>100MB 
> and as high as 450!) during some times and at other reporting zeros.  
> The entire time, the I/O counts are happily showing what appear to be 
> correct numbers.  Here's a snapshot taken during a portion of a 2GB file 
> file to /tmp.

I've applied my path to the for-linus git branch, I will push it for
2.6.15 as well. Thanks for reminding me!

-- 
Jens Axboe

