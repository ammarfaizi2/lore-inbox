Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130592AbQKTUNK>; Mon, 20 Nov 2000 15:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130589AbQKTUND>; Mon, 20 Nov 2000 15:13:03 -0500
Received: from mail.zmailer.org ([194.252.70.162]:32524 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129831AbQKTUMc>;
	Mon, 20 Nov 2000 15:12:32 -0500
Date: Mon, 20 Nov 2000 21:42:16 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Ben Collins <bcollins@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in large files ext2 in 2.4.0-test11 ?
Message-ID: <20001120214216.S28963@mea-ext.zmailer.org>
In-Reply-To: <D69EF5976ED@vcnet.vc.cvut.cz> <20001120141641.Y619@visi.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001120141641.Y619@visi.net>; from bcollins@debian.org on Mon, Nov 20, 2000 at 02:16:41PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2000 at 02:16:41PM -0500, Ben Collins wrote:
> > > Do programs compiled against a glibc with LFS (2.4.x kernel) support, and
> > > using that LFS support, work on kernel 2.2.x machines?
> > 
> > Yes. Even glibc (2.2) compiled against kernel without LFS support has LFS
> > interface. Of course limited to 2GB files only.
> 
> On some platforms...
> 
> E.g. I can already access > 2gig files on my ultrasparc :)

	And I can do so on Alpha, which has forever had 64-bit file sizes
	also at the kernel side.

	All glibc since 2.1 have user-visible interfaces of 64-bit
	file-sizes, but the glibc/kernel interface depends on what
	kernel headers have been used when compiling glibc.

	Just for comparison, RedHat delivers glibc compiled with
	2.3.nn/2.4.0 headers -> newer interfaces are supported.

> Ben
> /  Ben Collins  --  ...on that fantastic voyage...  --  Debian GNU/Linux   \
> `  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
