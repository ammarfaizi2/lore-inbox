Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbTICG5s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 02:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbTICG5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 02:57:47 -0400
Received: from ns.aratech.co.kr ([61.34.11.200]:20676 "EHLO ns.aratech.co.kr")
	by vger.kernel.org with ESMTP id S261341AbTICG5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 02:57:45 -0400
Date: Wed, 3 Sep 2003 16:00:09 +0900
From: Tejun Huh <tejun@aratech.co.kr>
To: Jens Axboe <axboe@suse.de>
Cc: Tejun Huh <tejun@aratech.co.kr>, linux-kernel@vger.kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] ide task_map_rq() preempt count imbalance
Message-ID: <20030903070009.GA464@atj.dyndns.org>
References: <20030903055257.GA31635@atj.dyndns.org> <20030903064057.GA14833@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903064057.GA14833@suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 08:40:57AM +0200, Jens Axboe wrote:
> 
> This doesn't work, it's perfectly legit to use task_map_rq() on a
> non-bio backed request. You need to fix this differently.
> 

 I see.  rq->cbio is required by rq_map_buffer.  I have no idea how
this should be done.  Please ignore the patch and consider it as a bug
report.

-- 
tejun

