Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbSKMQZE>; Wed, 13 Nov 2002 11:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSKMQZE>; Wed, 13 Nov 2002 11:25:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15632 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261978AbSKMQZD>;
	Wed, 13 Nov 2002 11:25:03 -0500
Date: Wed, 13 Nov 2002 16:31:55 +0000
From: Matthew Wilcox <willy@debian.org>
To: Matt Bernstein <matt@theBachChoir.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.47-ac2
Message-ID: <20021113163155.L30392@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> $ find drivers/ -name "*.[ch]" \
>         -exec grep -l 'Documentation/DMA-mapping.txt' "{}" \;
[...]
> drivers/parisc/sba_iommu.c  

man 1 xargs

sba_iommu.c is a false positive.  if you'd not used -l, you'd've noticed this.

 * See Documentation/DMA-mapping.txt


-- 
Revolutions do not require corporate support.
