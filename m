Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292055AbSBAVJO>; Fri, 1 Feb 2002 16:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292049AbSBAVJG>; Fri, 1 Feb 2002 16:09:06 -0500
Received: from zok.sgi.com ([204.94.215.101]:36256 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S292045AbSBAVIk>;
	Fri, 1 Feb 2002 16:08:40 -0500
Subject: Re: O_DIRECT fails in some kernel and FS
From: Steve Lord <lord@sgi.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Ricardo Galli <gallir@uib.es>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C5AFE2D.95A3C02E@zip.com.au>
In-Reply-To: <E16WkQj-0005By-00@antoli.uib.es> 
	<3C5AFE2D.95A3C02E@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 01 Feb 2002 15:05:38 -0600
Message-Id: <1012597538.26363.443.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-02-01 at 14:44, Andrew Morton wrote:
> Ricardo Galli wrote:
> > 
> > After some comments from Oliver Diedrich (editor of heise.de), which told me
> > he couldn't make O_DIRECT work on 2.4.17, I tried with different versions and
> > file systems:
> > 
> > This is the result:
> > 
> > 2.4.14 - Ext[23] - redhat7.2 glibs: OK (at least the bytes are written)
> > 2.4.17 - ReiserFS - Debian Sid    : FAILS (0 bytes file, write returns -1)
> > 2.4.17 - Ext2 - Debian Woody      : OK (bytes written)
> > 2.4.17 - Ext3 - Debian Woody      : FAILS (0 bytes file, write returns -1)
> > 
> > Oliver Diedrich also told he could make work O_DIRECT with ext3 and 2.4.17.
> > 
> > Is this normal? Does it really work on 2.4.14? Or it doesn't but the kernel
> > doesn't avoid caching?
> > 
> 
> ext2 is the only filesystem which has O_DIRECT support.

And XFS ;-)

Steve


