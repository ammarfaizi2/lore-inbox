Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314287AbSEMQ5I>; Mon, 13 May 2002 12:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314289AbSEMQ5G>; Mon, 13 May 2002 12:57:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:25223 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S314287AbSEMQ5C>;
	Mon, 13 May 2002 12:57:02 -0400
Date: Mon, 13 May 2002 18:56:43 +0200
From: Jens Axboe <axboe@suse.de>
To: Neil Conway <nconway.list@ukaea.org.uk>
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 62
Message-ID: <20020513165643.GD17509@suse.de>
In-Reply-To: <3CDFE2C7.5454B13A@ukaea.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13 2002, Neil Conway wrote:
> PS: 2.4 doesn't even have the spinlock as a parameter to
> blk_init_queue().

Right, the "queue" (well global in 2.4) lock has always been grabbed
prior to request_fn entry.

-- 
Jens Axboe

