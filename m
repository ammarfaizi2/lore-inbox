Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVGXJta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVGXJta (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 05:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262122AbVGXJt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 05:49:29 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:15080 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S261945AbVGXJt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 05:49:28 -0400
Date: Sun, 24 Jul 2005 11:50:46 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: randy_dunlap <rdunlap@xenotime.net>
cc: Bodo Eggert <7eggert@gmx.de>, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [1/5+1] menu -> menuconfig part 1
In-Reply-To: <20050721225226.4fbd64f7.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.58.0507241141060.5658@be1.lrz>
References: <Pine.LNX.4.58.0507171311400.5931@be1.lrz>
 <Pine.LNX.4.58.0507171326470.6041@be1.lrz> <20050721225226.4fbd64f7.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2005, randy_dunlap wrote:
> On Sun, 17 Jul 2005 13:29:03 +0200 (CEST) Bodo Eggert wrote:

> > > These patches change some menus into menuconfig options.

> When using xconfig (not menuconfig), the drivers/MTD menu
> needs some help IMO, but it's not clear where/why.
> 
> Before the patch, there was only "Memory Technology
> Devices (MTD)" in the left xconfig panel.  After the patch,
> under that heading there are 4 other MTD entries,
> which are in the right-side panel before the patch and should
> remain there.  These are:
> 
>   RAM/ROM/Flash chip drivers
>   Mapping drivers for chip access
>   Self-contained MTD device drivers
>   NAND Flash Device support

That's because of the xconfig way of handling menus. Off cause this should 
not happen, but I'll need something like a submenuconfig option to 
resolve that issue. It would need to be like a menu in menuconfig, and 
like a config in xconfig.


BTW: Thanks for testing.
-- 
Top 100 things you don't want the sysadmin to say:
83. Damn, and I just bought that pop...
