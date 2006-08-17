Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932464AbWHQJXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbWHQJXS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWHQJXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:23:18 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:28465 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932464AbWHQJXR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:23:17 -0400
Subject: Re: [patch] s390: kernel page table allocation.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
In-Reply-To: <20060816131042.GB13251@infradead.org>
References: <20060816120622.GD24551@skybase>
	 <20060816131042.GB13251@infradead.org>
Content-Type: text/plain
Organization: IBM Corporation
Date: Thu, 17 Aug 2006 11:23:13 +0200
Message-Id: <1155806593.10261.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-16 at 14:10 +0100, Christoph Hellwig wrote:
> > -             pg_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
> > +             pg_table = (pte_t *) alloc_bootmem_pages(PAGE_SIZE);
> 
> Again, no need to cast the alloc_bootmem_pages return value.

A cleanup of the s390 code in regard to unnecessary casts would make
sense I guess..

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


