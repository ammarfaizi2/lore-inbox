Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282877AbRLRNUq>; Tue, 18 Dec 2001 08:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282801AbRLRNUg>; Tue, 18 Dec 2001 08:20:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45325 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S282523AbRLRNUU>;
	Tue, 18 Dec 2001 08:20:20 -0500
Date: Tue, 18 Dec 2001 14:20:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Joe Krahn <jkrahn@nc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Common removable media interface?
Message-ID: <20011218142002.C32511@suse.de>
In-Reply-To: <3C1F41D6.43A16F80@nc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C1F41D6.43A16F80@nc.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18 2001, Joe Krahn wrote:
> I think Linux could use a common removable
> media interface, sort of like cdrom.c adds
> a common interface to all CD/DVD. But, cdrom.c
> does such a good job, it almost seems like the
> thing to do is to just add acces to other
> devices to cdrom.c, and maybe rename it to
> media.c. Other media includes IDE floppies,
> regular floppies (if they live much longer),
> solid state media. Maybe even include some
> access to all media (not to replace the real
> drivers) like tapes, non-removable disks, etc.
> 
> Is anyone working on or thinking about
> such a thing?
> Do other people think this would be useful?
> Would it be 'bad' to just add IDE floppy
> access (not well developed) to cdrom.c,
> (which is already mislabelled now that it
> handles DVD)?

Stuff like this belongs in user space, no need to bloat the kernel with
it.

-- 
Jens Axboe

