Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280190AbRKSHKZ>; Mon, 19 Nov 2001 02:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280191AbRKSHKP>; Mon, 19 Nov 2001 02:10:15 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24327 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S280190AbRKSHJ4>;
	Mon, 19 Nov 2001 02:09:56 -0500
Date: Mon, 19 Nov 2001 08:09:22 +0100
From: Jens Axboe <axboe@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org, ltp-list@lists.sourceforge.net
Subject: Re: I/O tests using elvtune to improve interactive performance
Message-ID: <20011119080922.S11826@suse.de>
In-Reply-To: <138.49c8e42.29247804@aol.com> <20011117030611.A214@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011117030611.A214@earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17 2001, rwhron@earthlink.net wrote:
> Kernel:	2.4.15-pre5
> 
> Test:	Run growfiles tests from Linux Test Project that really hurt
> 	interactive performance.  Simultaneously run "ls -laR /".
> 	Change the elevator read latency value with elvtune.
> 	Also run mp3blaster tests.

Interesting tests, thanks. I wonder if you could be convinced to do
bonnie++ and dbench tests with the same read_latency values used? Also,
I'm assuming you kept write latency at its default of 16384?

-- 
Jens Axboe

