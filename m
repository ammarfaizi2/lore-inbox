Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277039AbRJKXKx>; Thu, 11 Oct 2001 19:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277041AbRJKXKd>; Thu, 11 Oct 2001 19:10:33 -0400
Received: from nsd.netnomics.com ([216.71.84.35]:18757 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S277039AbRJKXKc>; Thu, 11 Oct 2001 19:10:32 -0400
Date: Thu, 11 Oct 2001 18:10:43 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Christian Ullrich <chris@chrullrich.de>
cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Vincent Sweeney <v.sweeney@dexterus.com>, arvest@orphansonfire.com,
        linux-kernel@vger.kernel.org
Subject: Re: Partitioning problems in 2.4.11
In-Reply-To: <20011012010310.A1255@christian.chrullrich.de>
Message-ID: <Pine.LNX.3.96.1011011180912.5934I-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001, Christian Ullrich wrote:
[...]
> zone(0): 4096 pages.
> zone(1): 225280 pages.
> zone(2): 32748 pages.
[...]
> Memory: 1029868k/1048496k available (678k kernel code, 18240k reserved, 164k data, 168k init, 130992k highmem)
> Dentry-cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
> Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
> Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
> Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)

To tangent, do we really need a mount cache that big, even on a highmem
machine?

	Jeff




