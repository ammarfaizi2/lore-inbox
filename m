Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267967AbUJCQqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267967AbUJCQqy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 12:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268000AbUJCQqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 12:46:53 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:62625 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267967AbUJCQqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 12:46:52 -0400
Message-ID: <9e47339104100309468e6a64f@mail.gmail.com>
Date: Sun, 3 Oct 2004 12:46:51 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Dave Airlie <airlied@linux.ie>
Subject: Re: Merging DRM and fbdev
Cc: dri-devel@lists.sf.net, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410030824280.2325@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e47339104100220553c57624a@mail.gmail.com>
	 <Pine.LNX.4.58.0410030824280.2325@skynet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Oct 2004 08:26:54 +0100 (IST), Dave Airlie <airlied@linux.ie> wrote:
> I also want to prepare some patches for the kernel for the previous work
> you've done ...

Did you get around to making ffb compile?
Have all of the drivers been given minimal testing? I've done radeon and r128. 
Is the general consensus that the core model is the way to go for 2.6?

Once drm-core makes it into the kernel I can do another patch to
remove the inter_module_get calls between drm and agp. With those gone
inter_module can be removed from the kernel.

But there does appear to be one other user of inter_module_...
MTD driver for "M-Systems Disk-On-Chip Millennium Plus"
mtd/devices/doc2001plus.c
mtd/chips/cfi_cmdset_0001.c

> 
> Dave.
> 



-- 
Jon Smirl
jonsmirl@gmail.com
