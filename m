Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbVKUWmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVKUWmh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbVKUWmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:42:36 -0500
Received: from silver.veritas.com ([143.127.12.111]:6545 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751218AbVKUWmf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:42:35 -0500
Date: Mon, 21 Nov 2005 20:31:34 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] mm: flotsam
Message-ID: <Pine.LNX.4.61.0511212025220.19274@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 21 Nov 2005 20:31:24.0271 (UTC) FILETIME=[8A6E8FF0:01C5EEDA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Salvage a few damp pieces from the wreckage of my previous mm batch.
Against 2.6.15-rc2, shouldn't clash with other work.

Hugh

 arch/powerpc/mm/4xx_mmu.c     |    4 ---
 arch/powerpc/mm/hugetlbpage.c |    4 ---
 arch/powerpc/mm/mem.c         |    2 -
 arch/powerpc/mm/tlb_32.c      |    6 ++++
 arch/powerpc/mm/tlb_64.c      |    4 +--
 include/asm-alpha/atomic.h    |    7 ++++-
 include/asm-sparc64/atomic.h  |    1 
 include/asm-x86_64/atomic.h   |   51 +++++++++++++++++++++++++++++++-----------
 kernel/futex.c                |   15 ------------
 mm/Kconfig                    |    6 +---
 10 files changed, 56 insertions(+), 44 deletions(-)
