Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311450AbSCNAfy>; Wed, 13 Mar 2002 19:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311451AbSCNAfp>; Wed, 13 Mar 2002 19:35:45 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:60887 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S311450AbSCNAfb>;
	Wed, 13 Mar 2002 19:35:31 -0500
Date: Wed, 13 Mar 2002 19:35:23 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Brian Gerst <bgerst@didntduck.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] struct super_block cleanup - msdos/vfat
In-Reply-To: <3C8FE8E3.2040204@didntduck.org>
Message-ID: <Pine.GSO.4.21.0203131932440.25130-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Mar 2002, Brian Gerst wrote:

> Seperates msdos_sb_info from struct super_block for msdos and vfat. 
> Umsdos is terminally broken and is not included.

We have everything needed to fix^Wrewrite umsdos and I hope to do that
this week.  Main idea of the rewrite: turn it into proper layered
filesystem (i.e. let the underlying layer have its own superblock,
inodes, etc.)...

