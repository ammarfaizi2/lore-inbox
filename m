Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311936AbSCXLZY>; Sun, 24 Mar 2002 06:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311940AbSCXLZF>; Sun, 24 Mar 2002 06:25:05 -0500
Received: from ns.caldera.de ([212.34.180.1]:18351 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S311936AbSCXLYz>;
	Sun, 24 Mar 2002 06:24:55 -0500
Date: Sun, 24 Mar 2002 12:24:14 +0100
Message-Id: <200203241124.g2OBOEB12463@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: akpm@zip.com.au (Andrew Morton)
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Updated -aa VM patches
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3C9D7F4B.45B1A766@zip.com.au>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C9D7F4B.45B1A766@zip.com.au> you wrote:
> writeback changes:
>         aa-010-show_stack.patch

The ifdef-mania in this patch is realy ugly - I'd rather prefer to make
the code use show_stack unconditionally and let the currently
non-conforming ports implement it, even it's is a noop.

