Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314446AbSDVS4l>; Mon, 22 Apr 2002 14:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314447AbSDVS4k>; Mon, 22 Apr 2002 14:56:40 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:7078 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314446AbSDVS4j>;
	Mon, 22 Apr 2002 14:56:39 -0400
Date: Mon, 22 Apr 2002 11:58:39 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Alexander Viro <viro@math.psu.edu>
cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com, hannal@us.ibm.com
Subject: Re: [CFT][PATCH] (1/5) sane procfs/dcache interaction
Message-ID: <13910000.1019501919@w-hlinder.des>
In-Reply-To: <Pine.GSO.4.21.0204201304150.25383-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Saturday, April 20, 2002 13:56:35 -0400 Alexander Viro <viro@math.psu.edu> wrote:

> Patchset eliminates a _lot_ of allocation/freeing/guaranteed negative dcache
> lookups for procfs.  It seems to be working here, but I would really appreciate
> help with testing/review.
> 
> First chunk follows, the rest will go in separate mails.
> 
> diff -urN C8-0/include/linux/sched.h C8-unhash_process/include/linux/sched.h
> --- C8-0/include/linux/sched.h	Sun Apr 14 17:53:12 2002
> +++ C8-unhash_process/include/linux/sched.h	Fri Apr 19 01:16:35 2002

Patch 1 of 5 failed to apply to 2.5.8.
Which version are these built against?

Hanna
hannal@us.ibm.com

