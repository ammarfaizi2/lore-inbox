Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266224AbRGKBP5>; Tue, 10 Jul 2001 21:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267134AbRGKBPs>; Tue, 10 Jul 2001 21:15:48 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31288 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S266224AbRGKBPg>; Tue, 10 Jul 2001 21:15:36 -0400
Date: Wed, 11 Jul 2001 03:15:56 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Brian Strand <bstrand@switchmanagement.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
Message-ID: <20010711031556.A3496@athlon.random>
In-Reply-To: <3B4BA19C.3050706@switchmanagement.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B4BA19C.3050706@switchmanagement.com>; from bstrand@switchmanagement.com on Tue, Jul 10, 2001 at 05:45:16PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 05:45:16PM -0700, Brian Strand wrote:
> We are running 3 Oracle servers, each dual CPU, 1 1GB and 2 2GB memory, 
>  between 36-180GB of RAID.  On June 26, I upgraded all boxes from Suse 
> 7.0 to Suse 7.2 (going from kernel version 2.2.16-40 to 2.4.4-14). 
>  Reviewing Oracle job times (jobs range from a few minutes to 10 hours) 
> before and after, performance is almost exactly twice as poor after the 
> upgrade versus before the upgrade.  Nothing in the hardware or Oracle 
> configuration has changed on any server.  Does anyone have any ideas as 
> to what might cause this?

We need to restrict the problem. How are you using Oracle?  Through any
filesystem? If yes which one? Or with rawio?  Is your workload cached
most of the time or not?

thanks,
Andrea
