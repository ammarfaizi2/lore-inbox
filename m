Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267505AbRHFKC5>; Mon, 6 Aug 2001 06:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267532AbRHFKCh>; Mon, 6 Aug 2001 06:02:37 -0400
Received: from mail.zmailer.org ([194.252.70.162]:34321 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S267505AbRHFKCd>;
	Mon, 6 Aug 2001 06:02:33 -0400
Date: Mon, 6 Aug 2001 13:02:22 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: alad@hss.hns.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: merge_segment() missing in do_mmap_pgoff in 2.4
Message-ID: <20010806130222.Q11046@mea-ext.zmailer.org>
In-Reply-To: <65256AA0.00244DC4.00@sandesh.hss.hns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65256AA0.00244DC4.00@sandesh.hss.hns.com>; from alad@hss.hns.com on Mon, Aug 06, 2001 at 11:59:28AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 11:59:28AM +0530, alad@hss.hns.com wrote:
> I was just going through do_mmap_pgoff()  in mmap.c. In 2.2 kernels after
> inserting the vma in doubly linked list we use to call merge_segments to check
> the possibility of merging it with other peer segments.
> This thing is missing in 2.4. Is this left out intentionally ?? and why ??

  Look at the ongoing thread in   linux-kernel  list with subject:
	Re: /proc/<n>/maps growing..

> --
> Amol
