Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315192AbSEQGKG>; Fri, 17 May 2002 02:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315432AbSEQGKF>; Fri, 17 May 2002 02:10:05 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62338 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315192AbSEQGKE>;
	Fri, 17 May 2002 02:10:04 -0400
Date: Fri, 17 May 2002 08:09:55 +0200
From: Jens Axboe <axboe@suse.de>
To: Sanket Rathi <sanket.rathi@cdac.ernet.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bounce Buffer Patch
Message-ID: <20020517060955.GS11948@suse.de>
In-Reply-To: <Pine.GSO.4.10.10205171118320.17118-100000@mailhub.cdac.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17 2002, Sanket Rathi wrote:
> I have read about bounce buffer and understand.
> but from where i can get the code of that patch and how it internally
> works.

You mean the patch to avoid bounce buffering? Andrea has an uptodate
version here:

http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre8aa3/00_block-highmem-all-18b-11.gz

In short, it does its magic by not relying on the virtual mapping of a
given page. If you want more info than that, you'll have to ask more
qualified questions.

-- 
Jens Axboe

