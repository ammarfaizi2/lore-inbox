Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286647AbSA2XtH>; Tue, 29 Jan 2002 18:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286821AbSA2Xr7>; Tue, 29 Jan 2002 18:47:59 -0500
Received: from ns.caldera.de ([212.34.180.1]:32450 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S287306AbSA2Xpx>;
	Tue, 29 Jan 2002 18:45:53 -0500
Date: Wed, 30 Jan 2002 00:45:35 +0100
Message-Id: <200201292345.g0TNjZ128039@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org, Momchil Velikov <velco@fadata.bg>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <Pine.LNX.4.33.0201291515480.1747-100000@penguin.transmeta.com>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0201291515480.1747-100000@penguin.transmeta.com> you wrote:
> it _looks_ like the way the radix_node is done, it will
> basically always be a factor-of-two+1 words, which sounds like the worst
> possible schenario from an allocator standpoint.

One advantage of the slab allocator is that if works efficiently with
odd object sizes..

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
