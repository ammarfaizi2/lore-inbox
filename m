Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279888AbRJ3HeC>; Tue, 30 Oct 2001 02:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279889AbRJ3Hdw>; Tue, 30 Oct 2001 02:33:52 -0500
Received: from 36.ppp1-2.hob.worldonline.dk ([212.54.84.164]:10880 "EHLO
	milhouse.home.kernel.dk") by vger.kernel.org with ESMTP
	id <S279888AbRJ3Hdj>; Tue, 30 Oct 2001 02:33:39 -0500
Date: Tue, 30 Oct 2001 08:34:09 +0100
From: Jens Axboe <axboe@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM test comparison of 2.4.14-pre5, aa1, and 2.4.13-ac5-fs
Message-ID: <20011030083409.E618@suse.de>
In-Reply-To: <20011030022640.A225@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011030022640.A225@earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30 2001, rwhron@earthlink.net wrote:
> 
> 2.4.14-pre5		fastest for mtest01, smoothest sound.
> 2.4.14pre5aa1
> 2.4.13-ac5-freeswap	fastest for mmap001

Side note -- you cannot directly call this a vm vs vm test, not if you
are doing any significant amount of I/O. The -ac and Linus tree have
several significant changes in the queueing layer that makes this pretty
much and apples and oranges comparison.

-- 
Jens Axboe

