Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265209AbSJWT6k>; Wed, 23 Oct 2002 15:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265210AbSJWT6k>; Wed, 23 Oct 2002 15:58:40 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:16369 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S265209AbSJWT6j>; Wed, 23 Oct 2002 15:58:39 -0400
Date: Wed, 23 Oct 2002 16:04:50 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Steven Cole <elenstev@mesatop.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.5.44-[mm3, ac2] time to tar zxf kernel tarball compared forvarious fs.
Message-ID: <20021023160450.E3750@redhat.com>
References: <1035402133.13140.251.camel@spc9.esa.lanl.gov> <3DB6FF24.9B50A7C0@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DB6FF24.9B50A7C0@digeo.com>; from akpm@digeo.com on Wed, Oct 23, 2002 at 12:57:24PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 12:57:24PM -0700, Andrew Morton wrote:
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

Is the ext2/3 allocation heuristic fix in yet?  That might swing things 
around again too.

		-ben
-- 
"Do you seek knowledge in time travel?"
