Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVGVGL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVGVGL0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 02:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVGVGL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 02:11:26 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:64133 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S262045AbVGVGLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 02:11:24 -0400
Date: Thu, 21 Jul 2005 23:11:18 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Bodo Eggert <7eggert@gmx.de>
Cc: 7eggert@gmx.de, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [1/5+1] menu -> menuconfig part 1
Message-Id: <20050721231118.10e0afe0.rdunlap@xenotime.net>
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


The SCSI drivers menu has problems similar to the MTD drivers menu.
I.e., some items are displayed on the left panel of xconfig
when they should appear on the right panel.  E.g., these are all
on the left-side panel but should be on the right side:

  SCSI Transport Attributes
  SCSI low-level drivers
    Fusion MPT device support
    PCMCIA SCSI adapter support


Similar comments for the Sound menu.

Are you testing with menuconfig/xconfig/gconfig ?

---
~Randy
