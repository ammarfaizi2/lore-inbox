Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLFQWu>; Wed, 6 Dec 2000 11:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbQLFQWl>; Wed, 6 Dec 2000 11:22:41 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:23300 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129183AbQLFQWc>;
	Wed, 6 Dec 2000 11:22:32 -0500
Date: Wed, 6 Dec 2000 16:50:56 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Skip Collins <bernard.collins@jhuapl.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: system hang and corrupt ext2 filesystem with test12-pre5
In-Reply-To: <3A2E51B0.76C65771@jhuapl.edu>
Message-ID: <Pine.LNX.4.21.0012061639360.5492-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2000, Skip Collins wrote:
> For now I am going to fall back to the slower ide bus. But I wanted to
> let people know that there still may be problems with ext2 corruption in
> the latest test kernel.

If your kernel halts, you should not be surprised if you get file system
errors.  You need a journalling filesystem to solve that, and even then,
you will probably loose data.  The magix sysrq can help you sometimes, but
certainly not if your disk (controller) is stuck.

/Tobias


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
