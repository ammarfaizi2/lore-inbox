Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVG0OcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVG0OcD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 10:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVG0O32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 10:29:28 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:16787 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262264AbVG0O1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 10:27:48 -0400
Date: Wed, 27 Jul 2005 16:29:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:master] overview of soon-to-be-posted patches
Message-ID: <20050727142944.GK6920@suse.de>
References: <20050726131215.GA23916@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050726131215.GA23916@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26 2005, Tejun Heo wrote:
>  Hello, Jens.
> 
>  I hope you had fun on your vacation and at OLS.  I'm posting 18
> welcome-back patches today. :-p This mail is to show the overview of
> the patches.  All patches are against master head of linux-2.6-block
> tree.
> 
> patch #1	: fix-elevator_find.  remove try_module_get race in
> 		  elevator_find.
> patch #2	: fix-cfq_find_next_crq.  fix cfq_find_next_crq bug
> 		  in cfq.
> patch #3-7	: generic dispatch queue patchset.  implements generic
> 		  dispatch queue.
> patch #8	: reimplement-elevator-switch.  reimplements elevator
> 		  switch using generic dispatch queue.  draining isn't
> 		  needed anymore.
> patch #9-#18	: ordered reimplementation patchset.  reimplements
> 		  I/O barrier handling.

Nice work! I'll review this, added to list...

-- 
Jens Axboe

