Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265184AbSJWU1H>; Wed, 23 Oct 2002 16:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265189AbSJWU1H>; Wed, 23 Oct 2002 16:27:07 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:44197 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S265184AbSJWU1G>; Wed, 23 Oct 2002 16:27:06 -0400
Subject: Re: 2.5.44-[mm3, ac2] time to tar zxf kernel tarball compared
	forvarious  fs.
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <3DB6FF24.9B50A7C0@digeo.com>
References: <1035402133.13140.251.camel@spc9.esa.lanl.gov> 
	<3DB6FF24.9B50A7C0@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 23 Oct 2002 14:32:20 -0600
Message-Id: <1035405140.13083.268.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 13:57, Andrew Morton wrote:
> Steven Cole wrote:
> > 
> > ext3
> > tar zxf linux-2.5.44.tar.gz     2.5.44-mm3      2.5.44-ac2
> > user                            4.42            4.39
> > system                          4.09            4.05
> > elapsed                         00:53.17        00:34.05
> > % CPU                           16              24
> 
> The smaller fifo_batch setting hurts when there are competing
> reads and writes on the same disk.
> 
> > reiserfs
> > xfs
> > jfs
> 
> ext2?

OK, here is the ext2 data.  This was done on my /tmp partition.

For ext2, the variation between runs was as much as between 
mm3 and ac2.  This data is from the first of 4 runs as before.

Steven

ext2		
tar zxf linux-2.5.44.tar.gz	2.5.44-mm3	2.5.44-ac2
user				4.17		4.16
system				2.76		2.7
elapsed				00:08.39	00:08.05
% CPU				82		85
		
rm -rf linux-2.5.44		2.5.44-mm3	2.5.44-ac2
user				0.01		0.01
system				0.4		0.37
elapsed				00:02.31	00:01.17
% CPU				18		33

