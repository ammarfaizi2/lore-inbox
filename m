Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266253AbUFYW2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266253AbUFYW2j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 18:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUFYW2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 18:28:38 -0400
Received: from mail4-141.ewetel.de ([212.6.122.141]:55265 "EHLO
	mail4.ewetel.de") by vger.kernel.org with ESMTP id S266253AbUFYW2b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 18:28:31 -0400
To: David van Hoose <david.vanhoose@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Collapse ext2 and 3 please
In-Reply-To: <2b45V-6tl-39@gated-at.bofh.it>
References: <2aZfF-3es-5@gated-at.bofh.it> <2b45V-6tl-39@gated-at.bofh.it>
Date: Sat, 26 Jun 2004 00:28:26 +0200
Message-Id: <E1BdzBK-00007z-Ga@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2004 21:00:23 +0200, you wrote in linux.kernel:

> It says ext2. Based on other messages, I look at /sbin/mkinitrd.
> It looks to me that RedHat/Fedora are pretty dumb making stupid 
> assumptions about the fs type instead of looking at the filesystem types 
> that root has setup in fstab.

Well, if the initrd (which is a ramdisk with a filesystem on it) is ext2,
you need ext2 in the kernel. It has nothing to do with the root filesystem
type, really. Journalling on an initrd makes no sense, so ext2 is
actually a sensible choice there.

-- 
Ciao,
Pascal
