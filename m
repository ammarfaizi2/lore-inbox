Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbSJ1IJC>; Mon, 28 Oct 2002 03:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263203AbSJ1IJC>; Mon, 28 Oct 2002 03:09:02 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40147 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263137AbSJ1IJB>;
	Mon, 28 Oct 2002 03:09:01 -0500
Date: Mon, 28 Oct 2002 09:15:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Nyk Tarr <nyk@giantx.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44-ac4 scsi CDROMEJECT problem
Message-ID: <20021028081507.GD30429@suse.de>
References: <20021027223138.GA601@giantx.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021027223138.GA601@giantx.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27 2002, Nyk Tarr wrote:
> Hi
> 
> This patch of Jens Axboe was missing from 2.5.44-ac4. Was this by design
> or accidental?

Please check blk_do_rq(), it sets rq_dev and rq_disk. So it's indeed
intentional. Since you ask, do you have problems ejecting?

-- 
Jens Axboe

