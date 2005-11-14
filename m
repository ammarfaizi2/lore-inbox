Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbVKNQbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVKNQbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 11:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVKNQbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 11:31:24 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:32212 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751066AbVKNQbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 11:31:24 -0500
Date: Mon, 14 Nov 2005 17:32:04 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Jason Dravet <dravet@hotmail.com>
cc: 7eggert@gmx.de, adaplas@gmail.com, samuel.thibault@ens-lyon.org,
       torvalds@osdl.org, akpm@osdl.org, davej@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vgacon: Workaround for resize bug in some chipsets
In-Reply-To: <BAY103-F21A2AF88D83C3CE3CAEE19DF5A0@phx.gbl>
Message-ID: <Pine.LNX.4.58.0511141725040.3411@be1.lrz>
References: <BAY103-F21A2AF88D83C3CE3CAEE19DF5A0@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2005, Jason Dravet wrote:
> >From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>

> >I asume your VGA indicates that it'll divide it's scanline counter by 2.
> >Please add a printk("vgacon: mode=%2.2x\n", mode) before line 512 and 
> >report
> >the value. A real fix will depend on this value. In the meantime, removing
> >the lines 512 and 513 from the original file should be a temporary fix.
> 
> Here is the result from the printk you requested:
> vgacon: mode=a3
> 
> I commented out lines 512 and 513 and the problem remains.

It seems I was wrong. I will have to think about it later. In the 
meantime, you might also want to use the no-scroll (IIRC) kernel 
parameter. (Disclaimer: I just started rading this file.)

-- 
Funny quotes:
1. Save the whales. Collect the whole set.
