Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265212AbSJWTvX>; Wed, 23 Oct 2002 15:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265213AbSJWTvX>; Wed, 23 Oct 2002 15:51:23 -0400
Received: from packet.digeo.com ([12.110.80.53]:40170 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265212AbSJWTvW>;
	Wed, 23 Oct 2002 15:51:22 -0400
Message-ID: <3DB6FF24.9B50A7C0@digeo.com>
Date: Wed, 23 Oct 2002 12:57:24 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.5.44-[mm3, ac2] time to tar zxf kernel tarball compared forvarious 
 fs.
References: <1035402133.13140.251.camel@spc9.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Oct 2002 19:57:25.0134 (UTC) FILETIME=[684A32E0:01C27ACE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> 
> ext3
> tar zxf linux-2.5.44.tar.gz     2.5.44-mm3      2.5.44-ac2
> user                            4.42            4.39
> system                          4.09            4.05
> elapsed                         00:53.17        00:34.05
> % CPU                           16              24

The smaller fifo_batch setting hurts when there are competing
reads and writes on the same disk.

> reiserfs
> xfs
> jfs

ext2?
