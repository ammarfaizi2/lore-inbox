Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTKBMeT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 07:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbTKBMeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 07:34:18 -0500
Received: from cmt-webdesign-gbr.de ([217.160.130.145]:4835 "EHLO
	p15103836.pureserver.info") by vger.kernel.org with ESMTP
	id S261681AbTKBMeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 07:34:17 -0500
From: Christoph Lehnberger <debian@internetists.de>
Reply-To: debian@internetists.de
Organization: internetists.de
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: [2.4.23-pre9] Compilation Error
Date: Sun, 2 Nov 2003 13:34:21 +0100
User-Agent: KMail/1.5.4
References: <200311011242.01886.debian@internetists.de> <20031101155807.GC530@alpha.home.local>
In-Reply-To: <20031101155807.GC530@alpha.home.local>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311021334.21187.debian@internetists.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 1. November 2003 16:58 schrieben Sie:
> Hello,
>
> On Sat, Nov 01, 2003 at 12:42:01PM +0100, Christoph Lehnberger wrote:
> > cc -D__KERNEL__ -I/usr/src/linux-2.4.22/include -Wall -Wstrict-prototypes
> > -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer
> > -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix
> > include -DKBUILD_BASENAME=inode  -c -o inode.o inode.c
> > inode.c:968: error: redefinition of `iget4'
> > /usr/src/linux-2.4.22/include/linux/fs.h:1415: error: `iget4' previously
> > defined here
>
> Did the 2.4.23-pre9 patch apply cleanly there ? I didn't get such errors.
> BTW, what compiler are you using, and could you post your config file once
> you have checked that the patch is ok ?
>
> Willy

Hello,

after repatching the kernel-tree now it works.....

Thanks a lot

Christoph Lehnberger

