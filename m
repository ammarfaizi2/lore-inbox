Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbWEaS3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbWEaS3V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 14:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbWEaS3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 14:29:15 -0400
Received: from rrcs-24-227-247-130.sw.biz.rr.com ([24.227.247.130]:3543 "EHLO
	linux.local") by vger.kernel.org with ESMTP id S965081AbWEaS1e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 14:27:34 -0400
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH 0/7][RFC] Ammasso 1100 iWARP Driver
Date: Wed, 31 May 2006 13:27:33 -0500
To: rdreier@cisco.com, mshefty@ichips.intel.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org
Message-Id: <20060531182733.3652.54755.stgit@stevo-desktop>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patchset implements the iWARP provider driver for the Ammasso
1100 RNIC.  It is dependent on the "iWARP Core Support" patch set.  We're
submitting it for review with the goal for inclusion in the 2.6.19 kernel.
This code has gone through several reviews in the openib-general list.
Now we are submitting it for external review by the linux community.

This StGIT patchset is cloned from Roland Dreier's infiniband.git
for-2.6.18 branch.  The patchset consists of 7 patches:

        1 - Kconfig and Makefile
        2 - Low-level device interface and native stack support
        3 - Work request definitions
        4 - Provider interface
        5 - Memory management
        6 - User mode message queue implementation      
        7 - Verbs queue implementation

Signed-off-by: Tom Tucker <tom@opengridcomputing.com>
Signed-off-by: Steve Wise <swise@opengridcomputing.com>
