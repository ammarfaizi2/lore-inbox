Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265478AbRGCRqy>; Tue, 3 Jul 2001 13:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265545AbRGCRqo>; Tue, 3 Jul 2001 13:46:44 -0400
Received: from fe040.worldonline.dk ([212.54.64.205]:57355 "HELO
	fe040.worldonline.dk") by vger.kernel.org with SMTP
	id <S265478AbRGCRqg>; Tue, 3 Jul 2001 13:46:36 -0400
Date: Tue, 3 Jul 2001 19:47:16 +0200
From: Jens Axboe <axboe@suse.de>
To: mdaljeet@in.ibm.com
Cc: Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: Re: mmap
Message-ID: <20010703194716.A1027@suse.de>
In-Reply-To: <CA256A7D.004D2B0F.00@d73mta01.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA256A7D.004D2B0F.00@d73mta01.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02 2001, mdaljeet@in.ibm.com wrote:
> [1] IMHO it would be more useful if iobufs would use a scatterlist
>     instead of an struct page* array.

No that would be horrible, at least with the current scatterlist. A page
based scatterlist would be alright though -- but this boils down to the
per-page offset debate again.

-- 
Jens Axboe
