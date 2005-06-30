Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262896AbVF3PgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262896AbVF3PgI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 11:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262899AbVF3PgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 11:36:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28356 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262896AbVF3Pfu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 11:35:50 -0400
Date: Thu, 30 Jun 2005 17:37:20 +0200
From: Jens Axboe <axboe@suse.de>
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] kernel BUG at include/linux/blkdev.h:601
Message-ID: <20050630153717.GB2243@suse.de>
References: <20050630021800.27887.qmail@web52605.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630021800.27887.qmail@web52605.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30 2005, Srihari Vijayaraghavan wrote:
> --- Srihari Vijayaraghavan
> <sriharivijayaraghavan@yahoo.com.au> wrote:
> > Vanilla 2.6.12 or 2.6.12-git* (the below BUG/Panic
> > report is from 2.6.12-git9).
> > [...] 
> > kernel BUG at include/linux/blkdev.h:601!
> > [...]
> > EIP is at __ide_end_request+0x118/0x125
> > [...]
> >  [<c01f5eca>] ide_end_request+0x55/0x57
> 
> [Sorry for replying to my own email]
> 
> 2.6.13-rc1 (plus Hugh's get_request patch) doesn't
> suffer from this problem, unlike 2.6.12 and 2.6.12-git
> releases.

That's a little strange, as there should be no changes in this area so
far. Are you 100% sure?

-- 
Jens Axboe

