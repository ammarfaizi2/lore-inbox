Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129602AbRCAOdv>; Thu, 1 Mar 2001 09:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129607AbRCAOdk>; Thu, 1 Mar 2001 09:33:40 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:12352 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129602AbRCAOdZ>; Thu, 1 Mar 2001 09:33:25 -0500
Date: Thu, 1 Mar 2001 15:35:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Ivan Stepnikov <iv@spylog.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel is unstable
Message-ID: <20010301153512.F32484@athlon.random>
In-Reply-To: <001701c0a230$40e12240$0e04a8c0@iv> <20010301122753.S15688@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010301122753.S15688@mea-ext.zmailer.org>; from matti.aarnio@zmailer.org on Thu, Mar 01, 2001 at 12:27:53PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 12:27:53PM +0200, Matti Aarnio wrote:
> 	With   malloc(1M):
> 
> ...
> 44089000-4418a000 rw-p 00000000 00:00 0
> 4418a000-4428b000 rw-p 00000000 00:00 0
> 4428b000-4438c000 rw-p 00000000 00:00 0
> 4438c000-4448d000 rw-p 00000000 00:00 0
> 4448d000-4458e000 rw-p 00000000 00:00 0
> 4458e000-4468f000 rw-p 00000000 00:00 0
> 4468f000-44790000 rw-p 00000000 00:00 0
> 44790000-44891000 rw-p 00000000 00:00 0

This is actually another bug completly orthogonal to the VM deadlock with the
empty ZONE_NORMAL.

>From the above it's pretty obvious the clever vma merging is broken in 2.4.

Andrea
