Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262023AbVGVFwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbVGVFwe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 01:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbVGVFwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 01:52:33 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:30331 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262023AbVGVFwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 01:52:33 -0400
Date: Thu, 21 Jul 2005 22:52:26 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Bodo Eggert <7eggert@gmx.de>
Cc: 7eggert@gmx.de, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [1/5+1] menu -> menuconfig part 1
Message-Id: <20050721225226.4fbd64f7.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.58.0507171326470.6041@be1.lrz>
References: <Pine.LNX.4.58.0507171311400.5931@be1.lrz>
	<Pine.LNX.4.58.0507171326470.6041@be1.lrz>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jul 2005 13:29:03 +0200 (CEST) Bodo Eggert wrote:

> On Sun, 17 Jul 2005, Bodo Eggert wrote:
> 
> > These patches change some menus into menuconfig options.
> > 
> > Reworked to apply to linux-2.6.13-rc3-git3
> 
> Mostly robotic works.

Hi,

When using xconfig (not menuconfig), the drivers/MTD menu
needs some help IMO, but it's not clear where/why.

Before the patch, there was only "Memory Technology
Devices (MTD)" in the left xconfig panel.  After the patch,
under that heading there are 4 other MTD entries,
which are in the right-side panel before the patch and should
remain there.  These are:

  RAM/ROM/Flash chip drivers
  Mapping drivers for chip access
  Self-contained MTD device drivers
  NAND Flash Device support

---
~Randy
