Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290713AbSA3Wwk>; Wed, 30 Jan 2002 17:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290704AbSA3Wwb>; Wed, 30 Jan 2002 17:52:31 -0500
Received: from lsanca1-ar27-4-63-184-089.vz.dsl.gtei.net ([4.63.184.89]:23936
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S290713AbSA3WwW>; Wed, 30 Jan 2002 17:52:22 -0500
Date: Wed, 30 Jan 2002 14:52:16 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: David Dyck <dcd@tc.fluke.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.3 missing <linux/malloc.h>
In-Reply-To: <Pine.LNX.4.33.0201301239370.19671-100000@dd.tc.fluke.com>
Message-ID: <Pine.LNX.4.33.0201301446080.7748-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, David Dyck wrote:

>     drivers/base/core.c
>     drivers/base/fs.c
> try to include linux/malloc.h

> and I've noticed that many source files have
>   #include <linux/slab.h>     /* kmalloc(), kfree() */
> instead of trying to include linux/malloc.h

I have been changing the two malloc.h references to slab.h since at least
2.5.3-pre6 and I think possibly also in 2.5.2.

It seems to work ok.

-- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
Job Required in Los Angeles - Will do most things unix or IP for money.
http://www.hawaga.org.uk/resume/resume001.pdf
Live Ben-cam: http://barbarella.hawaga.org.uk/benc-cgi/watchers.cgi


