Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313833AbSDIJr4>; Tue, 9 Apr 2002 05:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313836AbSDIJrz>; Tue, 9 Apr 2002 05:47:55 -0400
Received: from imladris.infradead.org ([194.205.184.45]:15626 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S313833AbSDIJrz>; Tue, 9 Apr 2002 05:47:55 -0400
Date: Tue, 9 Apr 2002 10:47:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH][RC] radix-tree pagecache for 2.5
Message-ID: <20020409104753.A490@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I have a first release candidate of the radix-tree pagecache for
the 2.5 tree.  This patch contains the following changes over the last version

 - improved OOM handling all over the place		(Andrew Morton)
 - minor fixes/cleanuos					(Andrew Morton, me)
 - switch mapping->page_lock to a r/w lock		(me)

The patch can be found at:

	ftp://ftp.kernel.org/pub/linux/kernel/people/hch/patches/v2.5/2.5.8-pre2/linux-2.5.8-ratcache.patch.gz
	ftp://ftp.kernel.org/pub/linux/kernel/people/hch/patches/v2.5/2.5.8-pre2/linux-2.5.8-ratcache.patch.bz2

In addition a BitKeeper tree is available at http://hkernel.bkbits.net.

