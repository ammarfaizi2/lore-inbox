Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314674AbSEPUdx>; Thu, 16 May 2002 16:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314675AbSEPUdw>; Thu, 16 May 2002 16:33:52 -0400
Received: from dsl-213-023-040-248.arcor-ip.net ([213.23.40.248]:47590 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314674AbSEPUdv>;
	Thu, 16 May 2002 16:33:51 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Anton Altaparmakov <aia21@cantab.net>,
        Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: [PATCH] remove 2TB block device limit
Date: Thu, 16 May 2002 22:32:37 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, axboe@suse.de, akpm@zip.com.au,
        martin@dalecki.de, neilb@cse.unsw.edu.au
In-Reply-To: <Pine.SOL.3.96.1020514023250.22385B-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E178RvR-0008To-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 May 2002 03:36, Anton Altaparmakov wrote:
> ...And yes at the
> moment the pagecache limit is also a problem which we just ignore in the
> hope that the kernel will have gone to 64 bits by the time devices grow
> that large as to start using > 32 bits of blocks/pages...

PAGE_CACHE_SIZE can also grow, so 32 bit architectures are further away
from the page cache limit on than it seems.

-- 
Daniel
