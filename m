Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbULPW0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbULPW0C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 17:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbULPWZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 17:25:11 -0500
Received: from pc7.prs.nunet.net ([199.249.167.77]:24327 "HELO
	patternassociates.com") by vger.kernel.org with SMTP
	id S262046AbULPWVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 17:21:22 -0500
Date: 16 Dec 2004 22:21:21 -0000
Message-ID: <20041216222121.30098.qmail@patternassociates.com>
From: "Rico Tudor" <rico-linux-kernel-2004@patternassociates.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 3TB disk hassles
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil,

I have a ~2TB ext2 FS on 3Ware RAID5, and simply dispense with
partitioning.  If you use LILO and it complains, arrange for /boot/*
and your kernel image to have low i-numbers: this will keep the blocks
numbers in a tradition range.  Done!
