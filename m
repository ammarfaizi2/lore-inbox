Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbTEASbD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 14:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTEASbD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 14:31:03 -0400
Received: from verein.lst.de ([212.34.181.86]:54791 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261369AbTEASbC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 14:31:02 -0400
Date: Thu, 1 May 2003 20:40:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make <linux/blk.h> obsolete
Message-ID: <20030501204012.A16641@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Adrian Bunk <bunk@fs.tum.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <20030501200719.A16182@lst.de> <20030501183804.GC21168@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030501183804.GC21168@fs.tum.de>; from bunk@fs.tum.de on Thu, May 01, 2003 at 08:38:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 01, 2003 at 08:38:04PM +0200, Adrian Bunk wrote:
> On Thu, May 01, 2003 at 08:07:19PM +0200, Christoph Hellwig wrote:
> >...
> > +/* this file is obsolete, please use <linux/blkdev.h> instead */
> >...
> 
> #warning linux/blk.h is deprecated, use linux/blkdev.h instead.
> #include <linux/blkdev.h>
> 
> or simply remove the blk.h and fix all files trying to include it?

Later.  First thing is to kill the content, next the users.
Adding the warning now would make a normal compile very verbose..

