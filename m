Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965175AbVIAO7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbVIAO7I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965176AbVIAO7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:59:08 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:51721 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965175AbVIAO7G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:59:06 -0400
Date: Thu, 1 Sep 2005 16:59:02 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       alan@redhat.com
Subject: Re: 2.6.13-mm1
Message-ID: <20050901145902.GB3745@stusta.de>
References: <20050901035542.1c621af6.akpm@osdl.org> <6970000.1125584568@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6970000.1125584568@[10.10.2.4]>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 07:22:53AM -0700, Martin J. Bligh wrote:
>...
> Lots of this:
> 
> In file included from fs/xfs/linux-2.6/xfs_linux.h:57,
>                  from fs/xfs/xfs.h:35,
>                  from fs/xfs/xfs_rtalloc.c:37:
> fs/xfs/xfs_arch.h:55:21: warning: "__LITTLE_ENDIAN" is not defined
> In file included from fs/xfs/xfs_rtalloc.c:50:
> fs/xfs/xfs_bmap_btree.h:65:21: warning: "__LITTLE_ENDIAN" is not defined
>   CC      fs/xfs/xfs_acl.o
> In file included from fs/xfs/linux-2.6/xfs_linux.h:57,
>                  from fs/xfs/xfs.h:35,
>                  from fs/xfs/xfs_acl.c:33:
> fs/xfs/xfs_arch.h:55:21: warning: "__LITTLE_ENDIAN" is not defined
> 
> Can't see anything obvious to cause that.
>...

They are there since we added -Wundef to the CFLAGS several -mm kernels 
ago.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

