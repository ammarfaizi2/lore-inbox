Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291269AbSBMAF0>; Tue, 12 Feb 2002 19:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291267AbSBMAFJ>; Tue, 12 Feb 2002 19:05:09 -0500
Received: from [63.231.122.81] ([63.231.122.81]:38740 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S291269AbSBMAE4>;
	Tue, 12 Feb 2002 19:04:56 -0500
Date: Tue, 12 Feb 2002 17:03:13 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ext2 synchronous mount speedup
Message-ID: <20020212170313.V9826@lynx.turbolabs.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C69A174.B092D044@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C69A174.B092D044@zip.com.au>; from akpm@zip.com.au on Tue, Feb 12, 2002 at 03:12:52PM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 12, 2002  15:12 -0800, Andrew Morton wrote:
> --- linux-2.4.18-pre9/include/linux/ext2_fs_i.h	Mon Sep 17 13:16:30 2001
> +++ linux-akpm/include/linux/ext2_fs_i.h	Tue Feb 12 14:00:11 2002
> @@ -25,7 +25,6 @@ struct ext2_inode_info {
>  	__u32	i_faddr;
>  	__u8	i_frag_no;
>  	__u8	i_frag_size;
> -	__u16	i_osync;
>  	__u32	i_file_acl;
>  	__u32	i_dir_acl;
>  	__u32	i_dtime;

We should probably leave this in there as a placeholder (with a different
name), just for alignment sake.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

