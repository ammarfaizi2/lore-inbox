Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbTABPFH>; Thu, 2 Jan 2003 10:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbTABPFH>; Thu, 2 Jan 2003 10:05:07 -0500
Received: from verein.lst.de ([212.34.181.86]:14097 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S261518AbTABPFG>;
	Thu, 2 Jan 2003 10:05:06 -0500
Date: Thu, 2 Jan 2003 16:10:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Christoph Hellwig <hch@lst.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, will@cs.earlham.edu
Subject: Re: Linux v2.5.54
Message-ID: <20030102161020.A11276@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Adrian Bunk <bunk@fs.tum.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	will@cs.earlham.edu
References: <Pine.LNX.4.44.0301011935410.8506-100000@penguin.transmeta.com> <20030102150839.GN6114@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030102150839.GN6114@fs.tum.de>; from bunk@fs.tum.de on Thu, Jan 02, 2003 at 04:08:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 04:08:40PM +0100, Adrian Bunk wrote:
> --- linux-2.5.54/fs/befs/linuxvfs.c.old	2003-01-02 16:03:34.000000000 +0100
> +++ linux-2.5.54/fs/befs/linuxvfs.c	2003-01-02 16:03:46.000000000 +0100
> @@ -12,7 +12,7 @@
>  #include <linux/stat.h>
>  #include <linux/nls.h>
>  #include <linux/buffer_head.h>
> -#include <linux/statfs.h>
> +#include <linux/vfs.h>


Yes, that's the proper fix.  Sorry for the breakage :P

