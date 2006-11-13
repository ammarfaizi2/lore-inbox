Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754505AbWKMLgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505AbWKMLgl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 06:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbWKMLgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 06:36:41 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:52954 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1754505AbWKMLgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 06:36:40 -0500
Date: Mon, 13 Nov 2006 12:36:23 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ivan Ukhov <uvsoft@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: /dev before the root filesystem is mounted
In-Reply-To: <a5de567c0611130252m52de5071vc25589bfd89b9c27@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0611131234140.28210@yvahk01.tjqt.qr>
References: <a5de567c0611130252m52de5071vc25589bfd89b9c27@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I want the kernel (2.4) to display (just using printk) all available
> devices with full path (/dev/...) before the root filesystem is
> mounted.

Case 1: You do not use an initrd/initramfs:
  / is empty, /dev does not exist.

Case 2: You do use an initrd/initramfs
  You populated /dev during creation of the initrd/initramfs image OR
  your init script inside the initrd/initramfs mknods the nodes when run.


	-`J'
-- 
