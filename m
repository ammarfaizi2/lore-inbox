Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283345AbRK2R2b>; Thu, 29 Nov 2001 12:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283339AbRK2R2V>; Thu, 29 Nov 2001 12:28:21 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:45581 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283337AbRK2R2M>;
	Thu, 29 Nov 2001 12:28:12 -0500
Date: Thu, 29 Nov 2001 18:27:45 +0100
From: Jens Axboe <axboe@suse.de>
To: Peter Osterlund <petero2@telia.com>
Cc: Ron Lawrence <rlawrence@netraverse.com>, linux-kernel@vger.kernel.org
Subject: Re: CDROM ioctl bug (fwd)
Message-ID: <20011129182745.O10601@suse.de>
In-Reply-To: <Pine.LNX.4.33.0111281009140.1724-100000@monster.jayfay.com> <m2elmi1mjx.fsf@ppro.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2elmi1mjx.fsf@ppro.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29 2001, Peter Osterlund wrote:
> In general, who is responsible for unplugging the request queue after
> queuing an ioctl command?

The queuer is responsible for that. As Doug mentioned, you have the same
race that was long standing in sg as well which I fixed some months ago.

-- 
Jens Axboe

