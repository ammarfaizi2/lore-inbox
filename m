Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288967AbSCKTQi>; Mon, 11 Mar 2002 14:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288969AbSCKTQf>; Mon, 11 Mar 2002 14:16:35 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:8721 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id <S288967AbSCKTQW>;
	Mon, 11 Mar 2002 14:16:22 -0500
Message-Id: <200203112032.g2BKWgL30536@clueserver.org>
Content-Type: text/plain; charset=US-ASCII
From: Alan <alan@clueserver.org>
Reply-To: alan@clueserver.org
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Subject: Re: Kernel oops with 2.4.18
Date: Mon, 11 Mar 2002 09:55:54 -0800
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, <asun@cobaltnet.com>
In-Reply-To: <Pine.LNX.4.44.0203010850240.26745-100000@netfinity.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.44.0203010850240.26745-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 February 2002 22:59, Zwane Mwaikambo wrote:
> On Thu, 28 Feb 2002, Alan wrote:
> > >>EIP; c01344c8 <grow_buffers+38/f0>   <=====
> >
> > Trace; c0132767 <getblk+27/40>
> > Trace; c0132988 <bread+18/80>
> > Trace; c01e3c0d <scsi_release_command+7d/90>
> > Trace; c016f1f6 <hfs_buffer_get+26/80>
> > Trace; c016dd9a <hfs_mdb_get+aa/400>
> > Trace; c01e5e01 <ioctl_internal_command+151/160>
> > Trace; c016f0a5 <hfs_read_super+65/190>
> > Trace; c0135636 <get_sb_bdev+206/270>
> > Trace; c0122738 <handle_mm_fault+58/c0>
> > Trace; c0135a28 <do_kern_mount+b8/140>
> > Trace; c0145173 <do_add_mount+23/d0>
> > Trace; c01123c0 <do_page_fault+0/4cb>
> > Trace; c0106ffc <error_code+34/3c>
> > Trace; c014541b <do_mount+15b/180>
> > Trace; c014526c <copy_mount_options+4c/a0>
> > Trace; c01454bc <sys_mount+7c/c0>
> > Trace; c0106f0b <system_call+33/38>
> > Code;  c01344c8 <grow_buffers+38/f0>
>
> Looks like another didnt_consider_other_blocksizes bug (nb. you're
> using a CDROM which has a block size of 2048). Maintainer CC'd

Was there a patch for this problem yet?  I have not been keeping up with the 
pile of patches and/or the kernel list.

Thanks!
