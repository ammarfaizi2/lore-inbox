Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422729AbWJPQ2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422729AbWJPQ2I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 12:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422730AbWJPQ2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 12:28:08 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:11465 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1422729AbWJPQ2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 12:28:05 -0400
Message-Id: <20061016162709.369579000@szeredi.hu>
User-Agent: quilt/0.45-1
Date: Mon, 16 Oct 2006 18:27:09 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [patch 00/12] fuse update
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This patch series syncs the kernel code with the upcoming fuse-2.6.0
release.

Patches 1-6 are bug fixes and should go into 2.6.19.

Patch 1 fixes a system hang on SMP.  Though triggered very rarely,
this is a serious condition, so I plan submitting this patch to
-stable also.

Patches 7-8 are small updates.

Patches 9-11 add better support for block device based filesystems
(such as ntfs-3g).

Thanks,
Miklos

--
