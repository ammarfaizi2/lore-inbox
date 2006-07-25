Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbWGYQ47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbWGYQ47 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 12:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWGYQ47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 12:56:59 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:25242 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932477AbWGYQ46
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 12:56:58 -0400
Content-Type: multipart/mixed; boundary="===============0051714070=="
MIME-Version: 1.0
Subject: [PATCH 0 of 7] x86-64: Calgary IOMMU updates
Message-Id: <patchbomb.1153846590@rhun.haifa.ibm.com>
Date: Tue, 25 Jul 2006 19:56:30 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: ak@suse.de
Cc: jdmason@us.ibm.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       muli@il.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--===============0051714070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Andi,

This patchset contains a few Calgary bug fixes (mostly in the error
handling) and a few harmless associated cleanups (e.g., rearranging
structures for better alignment). It would be good to get these,
especially the bug fixes, into 2.6.18.

Thanks,
Muli\

--===============0051714070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

4 files changed, 52 insertions(+), 50 deletions(-)
arch/x86_64/kernel/pci-calgary.c |   85 +++++++++++++++++++++-----------------
arch/x86_64/kernel/tce.c         |   10 ----
include/asm-x86_64/calgary.h     |    6 +-
include/asm-x86_64/tce.h         |    1 

--===============0051714070==--
