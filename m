Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263872AbTKAP6N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 10:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbTKAP6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 10:58:13 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:41233 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S263872AbTKAP6L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 10:58:11 -0500
Date: Sat, 1 Nov 2003 16:58:07 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Christoph Lehnberger <debian@internetists.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.23-pre9] Compilation Error
Message-ID: <20031101155807.GC530@alpha.home.local>
References: <200311011242.01886.debian@internetists.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311011242.01886.debian@internetists.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Nov 01, 2003 at 12:42:01PM +0100, Christoph Lehnberger wrote:
 
> cc -D__KERNEL__ -I/usr/src/linux-2.4.22/include -Wall -Wstrict-prototypes 
> -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer 
> -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix 
> include -DKBUILD_BASENAME=inode  -c -o inode.o inode.c
> inode.c:968: error: redefinition of `iget4'
> /usr/src/linux-2.4.22/include/linux/fs.h:1415: error: `iget4' previously 
> defined here

Did the 2.4.23-pre9 patch apply cleanly there ? I didn't get such errors.
BTW, what compiler are you using, and could you post your config file once
you have checked that the patch is ok ?

Willy

