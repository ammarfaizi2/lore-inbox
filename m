Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQJ0SSo>; Fri, 27 Oct 2000 14:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129382AbQJ0SSf>; Fri, 27 Oct 2000 14:18:35 -0400
Received: from mail.zmailer.org ([194.252.70.162]:11525 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S129183AbQJ0SS1>;
	Fri, 27 Oct 2000 14:18:27 -0400
Date: Fri, 27 Oct 2000 21:18:16 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: jpranevich@lycos-inc.com, linux-kernel@vger.kernel.org
Subject: Re: Big file support in Linux 2.2
Message-ID: <20001027211816.M3588@mea-ext.zmailer.org>
In-Reply-To: <85256985.00556CD3.00@SMTPNotes1.ma.lycos.com> <200010271802.e9RI2ih04408@webber.adilger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200010271802.e9RI2ih04408@webber.adilger.net>; from adilger@turbolinux.com on Fri, Oct 27, 2000 at 12:02:44PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2000 at 12:02:44PM -0600, Andreas Dilger wrote:
....
> There may be other sources.  You also need to have a newer glibc (or recompile
> your own) to really support LFS.

However all software is *not* written to use LFS extended versions
of things.  Often using defines of:

        -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64

in the Makefile of said software CFLAGS is enough, but that may
still sometimes not be enough.  Specifically if the system will
then use some libraries which are not LFS compatible.

> Cheers, Andreas
> http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
