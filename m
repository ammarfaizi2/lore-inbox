Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315304AbSEAFsX>; Wed, 1 May 2002 01:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315303AbSEAFsW>; Wed, 1 May 2002 01:48:22 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:21989 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S315304AbSEAFsV>; Wed, 1 May 2002 01:48:21 -0400
Date: Tue, 30 Apr 2002 22:48:13 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Patricia Gaughen <gone@us.ibm.com>, Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] discontigmem support for ia32 NUMA box against 2.4.19pre7 
Message-ID: <3848329515.1020206892@[10.10.2.3]>
In-Reply-To: <200205010056.g410ujG03375@w-gaughen.des.beaverton.ibm.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sort of on this topic, I had considered removing the 
> CONFIG_HIGHMEM ifdef's because you need to have highmem 
> turned on to use this code (I should do some magic in the 
> config file to make sure that happens), but I hadn't done 
> that as of yet... any opinions on this?

Might be useful to have non-HIGHMEM for debug, esp when I
do the ZONE_NORMAL spreading around - if it's already
in there, don't bother ripping it out.

M.

