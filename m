Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274752AbRLLKUp>; Wed, 12 Dec 2001 05:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279277AbRLLKUf>; Wed, 12 Dec 2001 05:20:35 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:30993 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S274752AbRLLKUQ>;
	Wed, 12 Dec 2001 05:20:16 -0500
Date: Wed, 12 Dec 2001 11:19:57 +0100
From: Jens Axboe <axboe@suse.de>
To: Hal Duston <hald@sound.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bio and "old" block drivers
Message-ID: <20011212101957.GE7562@suse.de>
In-Reply-To: <Pine.GSO.4.10.10112111539180.5913-100000@sound.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.10.10112111539180.5913-100000@sound.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11 2001, Hal Duston wrote:
> I'm looking at the bio changes for ps2esdi.  The driver
> appears to no longer work compiled when into the kernel.
> The ps2esdi_init call has been removed from
> ll_rw_blk.c:blk_dev_init.  Where is the new/correct place
> to call this from?  This appears to be the same way with
> many of the other "old" block drivers as well.

Just use module_init to make this happen automagically.

-- 
Jens Axboe

