Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbUKOGBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbUKOGBs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 01:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbUKOGBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 01:01:48 -0500
Received: from perdition1.echo-on.net ([204.138.111.140]:25836 "EHLO
	mail.echo-on.net") by vger.kernel.org with ESMTP id S261471AbUKOGBK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 01:01:10 -0500
Date: Sun, 14 Nov 2004 21:17:00 -0500 (EST)
From: Terry Kyriacopoulos <terryk@echo-on.net>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Cc: gadio@netvision.net.il, andre@linux-ide.org
Subject: [BUG ALERT] Re: [PATCH] ide-scsi: DMA alignment bug fixed
In-Reply-To: <Pine.LNX.4.56.0411050042250.88@vk.local>
Message-ID: <Pine.LNX.4.56.0411142112080.273@fast.tk.local>
References: <Pine.LNX.4.56.0411050042250.88@vk.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please be advised that the code posted on November 5 that enables DMA
for non-aligned buffers has a design bug that can cause data corruption
in certain situations.

A corrected version of the patches, along with a detailed description
of the bug, can be obtained at:

http://home.echo-on.net/~terryk/ide-scsi-dmapatch.tgz

This contains patches for kernels 2.2.26, 2.4.19, 2.4.27, 2.6.9.
