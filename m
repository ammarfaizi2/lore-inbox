Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbTEASZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 14:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbTEASZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 14:25:51 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8159 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261199AbTEASZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 14:25:50 -0400
Date: Thu, 1 May 2003 20:38:04 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make <linux/blk.h> obsolete
Message-ID: <20030501183804.GC21168@fs.tum.de>
References: <20030501200719.A16182@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030501200719.A16182@lst.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 08:07:19PM +0200, Christoph Hellwig wrote:
>...
> +/* this file is obsolete, please use <linux/blkdev.h> instead */
>...

#warning linux/blk.h is deprecated, use linux/blkdev.h instead.
#include <linux/blkdev.h>

or simply remove the blk.h and fix all files trying to include it?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

