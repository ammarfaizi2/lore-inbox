Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965226AbWHOS7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbWHOS7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965230AbWHOS7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:59:09 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:13840 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S965227AbWHOS6r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:58:47 -0400
Date: Tue, 15 Aug 2006 15:40:19 +0000
From: Pavel Machek <pavel@suse.cz>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH 1/9] extents for ext4
Message-ID: <20060815154019.GD4032@ucw.cz>
References: <1155172827.3161.80.camel@localhost.localdomain> <20060809233940.50162afb.akpm@osdl.org> <m37j1hlyzv.fsf@bzzz.home.net> <20060811135737.1abfa0f6.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060811135737.1abfa0f6.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  AM> - The existing comments could benefit from some rework by a
> >  AM> native English speaker.
> > 
> > could someone assist here, please?
> 
> See if this helps.
> Patch applies on top of all ext4 patches from
> http://ext2.sourceforge.net/48bitext3/patches/latest/.

> --- linux-2618-rc4-ext4.orig/include/linux/ext4_fs_extents.h
> +++ linux-2618-rc4-ext4/include/linux/ext4_fs_extents.h
> @@ -22,29 +22,29 @@
>  #include <linux/ext4_fs.h>
>  
>  /*
> - * with AGRESSIVE_TEST defined capacity of index/leaf blocks
> - * become very little, so index split, in-depth growing and
> - * other hard changes happens much more often
> - * this is for debug purposes only
> + * With AGRESSIVE_TEST defined, the capacity of index/leaf blocks
> + * becomes very small, so index split, in-depth growing and
> + * other hard changes happen much more often.
> + * This is for debug purposes only.
>   */
>  #define AGRESSIVE_TEST_

Using _ for disabling is unusual/nasty. Can't we simply #undef it?
-- 
Thanks for all the (sleeping) penguins.
