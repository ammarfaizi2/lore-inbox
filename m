Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313254AbSEJJx6>; Fri, 10 May 2002 05:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313260AbSEJJx6>; Fri, 10 May 2002 05:53:58 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:24305 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S313254AbSEJJx5>; Fri, 10 May 2002 05:53:57 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15579.39081.528187.280027@wombat.chubb.wattle.id.au>
Date: Fri, 10 May 2002 19:53:45 +1000
To: Jens Axboe <axboe@suse.de>
Cc: Anton Altaparmakov <aia21@cantab.net>, Andrew Morton <akpm@zip.com.au>,
        Peter Chubb <peter@chubb.wattle.id.au>, linux-kernel@vger.kernel.org,
        martin@dalecki.de, neilb@cse.unsw.edu.au
Subject: Re: [PATCH] remove 2TB block device limit
In-Reply-To: <20020510090514.GL9183@suse.de>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Jens" == Jens Axboe <axboe@suse.de> writes:

Jens> On Fri, May 10 2002, Anton Altaparmakov wrote:
>> Why not the even dumber one? Forget FMT_SECTOR_T and always use %Lu
>> and typecast (unsigned long long)sector_t_variable in the printk.

Jens> I like that better too, it's what I did in the block layer too.

That's exactly what I did in the patch....

Except most places I used u64 not unsigned long long (it's the same
thing on all architectures, and much shorter to type).

Peter C
