Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316640AbSEVSTp>; Wed, 22 May 2002 14:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316641AbSEVSTi>; Wed, 22 May 2002 14:19:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13502 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S316640AbSEVSSB>;
	Wed, 22 May 2002 14:18:01 -0400
Date: Wed, 22 May 2002 14:18:01 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Christoph Hellwig <hch@infradead.org>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] split namei.h out of fs.h
In-Reply-To: <20020522190213.A17774@infradead.org>
Message-ID: <Pine.GSO.4.21.0205221417250.2737-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 May 2002, Christoph Hellwig wrote:

> Currently fs.h is full of unrelated declarations and included in almost
> any source file. Thus it makes sense to spilt certain aspects out that are
> only used by few users.
> 
> This patch starts with the namei/path lookup interface and splits it into
> <linux/namei.h> which is now directly included by the 24 files that actually
> need it.

Please, make a version that would take open_namei() and may_open() into the
same place.

