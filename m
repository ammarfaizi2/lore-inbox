Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267121AbTBDErd>; Mon, 3 Feb 2003 23:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267122AbTBDErd>; Mon, 3 Feb 2003 23:47:33 -0500
Received: from ns.xdr.com ([209.48.37.1]:11689 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id <S267121AbTBDErc>;
	Mon, 3 Feb 2003 23:47:32 -0500
Date: Mon, 3 Feb 2003 20:57:14 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200302040457.h144vEt31894@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Block device invalidate cached blocks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a block device driver for linux.

Linux caches the blocks read from my block device, which is fine. I've
mounted a read-only filesystem on the block device. But sometimes on
the back end the file system will change. Is there a way I can cause the
kernel to just flush all its cached blocks? Or even better invalidate
just the few blocks that have changed?

Thanks--
Dave

