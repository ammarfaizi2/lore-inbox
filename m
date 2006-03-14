Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752037AbWCNCCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbWCNCCt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 21:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbWCNCCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 21:02:49 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:57272 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1752037AbWCNCCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 21:02:48 -0500
Subject: xen DMA bug
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 21:02:45 -0500
Message-Id: <1142301766.13256.88.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An ALSA user has found a Xen bug where it fails to accept a 28 bit DMA
mask (pci_set_dma_mask(pci, 0x0fffffff) < 0 ||
pci_set_consistent_dma_mask(pci, 0x0fffffff) < 0) fails:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1907

Lee

