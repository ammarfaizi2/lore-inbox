Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313157AbSDYOCb>; Thu, 25 Apr 2002 10:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313160AbSDYOCa>; Thu, 25 Apr 2002 10:02:30 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:28340 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S313157AbSDYOC3>; Thu, 25 Apr 2002 10:02:29 -0400
Date: Thu, 25 Apr 2002 15:05:03 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Robert Schelander <rschelander@aon.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: swap_free: Bad swap offset entry
In-Reply-To: <004601c1ec2e$a59e4bb0$fe78a8c0@robert>
Message-ID: <Pine.LNX.4.21.0204251500060.1104-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2002, Robert Schelander wrote:
> Apr 24 22:19:00 linux kernel: swap_free: Bad swap offset entry 04000000
> Apr 24 22:20:29 linux kernel: swap_free: Unused swap file entry 04000000
> Apr 22 04:01:04 linux kernel: Unable to handle kernel paging request at
> virtual address e71d6478
> Apr 22 04:01:04 linux kernel: EIP:    0010:[prune_dcache+24/296]    Not
> tainted
> Apr 22 04:01:04 linux kernel: eax: c027c93c   ebx: c71d63f8   ecx: c71d6040
> edx: e71d6478
> Apr 22 04:01:04 linux kernel: esi: c71d62e0   edi: 00000000   ebp: 00007e35

These look _very_ much like single bit memory errors.
Please run memtest86 overnight, it will probably show your memory is bad.

Hugh

