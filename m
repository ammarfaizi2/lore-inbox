Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290665AbSA3WXk>; Wed, 30 Jan 2002 17:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290668AbSA3WXf>; Wed, 30 Jan 2002 17:23:35 -0500
Received: from ns.caldera.de ([212.34.180.1]:38874 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S290665AbSA3WXJ>;
	Wed, 30 Jan 2002 17:23:09 -0500
Date: Wed, 30 Jan 2002 23:22:47 +0100
Message-Id: <200201302222.g0UMMlL19060@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: stoffel@casc.com (John Stoffel)
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Momchil Velikov <velco@fadata.bg>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <15448.28224.481925.430169@gargle.gargle.HOWL>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <15448.28224.481925.430169@gargle.gargle.HOWL> you wrote:
> Isn't this a good place to use AVL trees then, since they balance
> automatically?  Admittedly, it may be more overhead than we want in
> the case where the tree is balanced by default anyway.  

OpenUnix uses AVL trees for the pagecache.  The overhead in struct page
is immense..
