Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262916AbREWAOV>; Tue, 22 May 2001 20:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262913AbREWAOL>; Tue, 22 May 2001 20:14:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7686 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262915AbREWAOA>;
	Tue, 22 May 2001 20:14:00 -0400
Date: Wed, 23 May 2001 02:14:05 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] struct char_device
Message-ID: <20010523021405.B29489@suse.de>
In-Reply-To: <Pine.GSO.4.21.0105221909001.17373-100000@weyl.math.psu.edu> <3B0AFEFE.1198871C@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22 2001, Jeff Garzik wrote:
> so... why not implement partitions as simply doing block remaps to the
> lower level device?  That's what EVMS/LVM/md are doing already.

That is indeed the plan, having partitions simply being 'just another'
sector remap when submitting I/O

-- 
Jens Axboe

