Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287106AbSAUPAa>; Mon, 21 Jan 2002 10:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287109AbSAUPAU>; Mon, 21 Jan 2002 10:00:20 -0500
Received: from dial-10-200-apx-01.btvt.together.net ([209.91.3.200]:52409 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S287106AbSAUPAP>; Mon, 21 Jan 2002 10:00:15 -0500
Date: Mon, 21 Jan 2002 09:59:06 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: <wstearns@sparrow.websense.net>
Reply-To: William Stearns <wstearns@pobox.com>
To: Denis RICHARD <dri@sxb.bsf.alcatel.fr>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>,
        Yves LUDWIG <Yves.Ludwig@sxb.bsf.alcatel.fr>,
        Pierre PEIFFER <Pierre.Peiffer@sxb.bsf.alcatel.fr>,
        Denis RICHARD <Denis.Richard@sxb.bsf.alcatel.fr>,
        Philippe MARTEAU <Philippe.Marteau@sxb.bsf.alcatel.fr>
Subject: Re: New version of e2compress patch (0.4.42) for LINUX 2.4.16.
In-Reply-To: <3C4C2A6D.1431CE41@sxb.bsf.alcatel.fr>
Message-ID: <Pine.LNX.4.33.0201210957570.11477-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, Denis,

On Mon, 21 Jan 2002, Denis RICHARD wrote:

> A new version of the e2compress patch (0.4.42) for kernel 2.4.16 is available.
> 
> Changes from 0.4.41 to 0.4.42 :
> ===============================
>  - Delete the i_blocks field decrementation (Thanks to Peter Wächtler).
>  - Clear dirty bit of buffers not in compressed area, after compression.
>  - Unlock pages before sync of inode, after compression.
>  - Change parameters (OSYNC_METADATA|OSYNC_DATA) of generic_osync_inode()
>    calls to write data inode.
>  - Ext2_readpage() returns an error code.
>  - Allocation of working area even when readonly mount.
>  - Clear dirty bit of buffers after uncompress in ext2_readpage.
>  - Unlock page after free buffers in error case in ext2_readpage.
> 
>   If someone is interested by this version of the patch,
> Let me know, I will mail it.
> 
>   Feel free to contat me if you have some questions.
> 
>   Have fun.

	Would you be willing to place it on a web or ftp server and post 
the URL here?
	Cheers,
	- Bill

---------------------------------------------------------------------------
        "Do you smell something burning or is it me?"
        -- Joan of Arc
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts, 
and ipfwadm2ipchains are at:                http://www.pobox.com/~wstearns
LinuxMonth; articles for Linux Enthusiasts! http://www.linuxmonth.com
--------------------------------------------------------------------------

