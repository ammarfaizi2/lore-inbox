Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262288AbUKDQsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbUKDQsi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 11:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbUKDQse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 11:48:34 -0500
Received: from main.gmane.org ([80.91.229.2]:4534 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262288AbUKDQsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 11:48:32 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Linux-2.6.9 won't allow a write to a NTFS file-system.
Date: Thu, 4 Nov 2004 17:48:03 +0100
Message-ID: <MPG.1bf47baa1b621da0989706@news.gmane.org>
References: <Pine.LNX.4.61.0411041054370.4818@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host186-250.pool8248.interbusiness.it
User-Agent: MicroPlanet-Gravity/2.70.2067
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:
> 
> Hello anybody maintaining NTFS,
> 
> I can't write to a NTFS file-system.
> 
> /proc/mounts shows it's mounted RW:
> /dev/sdd1 /mnt ntfs rw,uid=0,gid=0,fmask=0177,dmask=077,nls=utf8,errors=continue,mft_zone_multiplier=1 0 0
> 
> .config shows RW support.
> 
> CONFIG_NTFS_FS=m
> # CONFIG_NTFS_DEBUG is not set
> CONFIG_NTFS_RW=y
> 
> Errno is 1 (Operation not permitted), even though root.

What are trying to write? AFAIK, the (new) NTFS module only 
allows one kind of writing: overwriting an existing file, as 
long as its size doesn't change.

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

