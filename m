Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751699AbWJEP7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWJEP7M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbWJEP7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:59:12 -0400
Received: from brick.kernel.dk ([62.242.22.158]:26405 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1751699AbWJEP7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:59:10 -0400
Date: Thu, 5 Oct 2006 17:58:46 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sys_splice crashes in 2.6.19rc1 during autotest
Message-ID: <20061005155844.GC5170@kernel.dk>
References: <200610051725.53183.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610051725.53183.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05 2006, Andi Kleen wrote:
> 
> I was running autotest on 2.6.19rc1+x86_64 patchkit and I ended up with a BUG()
> below sys_splice while running some IO test there.
> 
> This was a debugging kernel with PREEMPTION and various other
> debugging options enabled.
> 
> The system ran out of disk space during the test so that
> might have been related and I ended up with a "fio" process
> in D. Also the system was confused afterwards with rm
> oopsing etc.
> 
> File system was reiserfs.

Can you pass me the fio job file you used?

-- 
Jens Axboe

