Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317359AbSGOGob>; Mon, 15 Jul 2002 02:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317360AbSGOGoa>; Mon, 15 Jul 2002 02:44:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:787 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317359AbSGOGo3>;
	Mon, 15 Jul 2002 02:44:29 -0400
Message-ID: <3D3271BB.DB11C1EC@zip.com.au>
Date: Sun, 14 Jul 2002 23:54:51 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steffen Persvold <sp@scali.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
References: <3D321041.2D25D649@zip.com.au> <Pine.LNX.4.33.0207150831080.29242-100000@pc-3.office.scali.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steffen Persvold wrote:
> 
> On Sun, 14 Jul 2002, Andrew Morton wrote:
> 
> > > Solaris and FreeBSD put all the effort into one filesystem trying to make
> > > it as good as possible. In Linux, it seems that nobody prooved the overall
> > > concept of the kernel.
> >
> > Apply http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.25/ext3-htree.patch
> > to your 2.5.25 tree, mount with `-o index' and enjoy watching ext3 eat
> > Solaris and FreeBSD's lunch.
> >
> > htree isn't quite ready yet and development seems a little moribund.
> > It'd be nice to get it finished off.
> >
> 
> Hi Andrew,
> 
> Will the patch ever be backported to 2.4 ?
> 

That's a 2.5 forward-port, actually.  Christopher, Daniel, Stephen
and co are working against 2.4.

It mostly works, but seems to still need a bit of debugging of corner
cases and general hardening up.

-
