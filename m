Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWFGUGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWFGUGt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 16:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWFGUGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 16:06:49 -0400
Received: from rrcs-24-227-247-179.sw.biz.rr.com ([24.227.247.179]:23211 "EHLO
	linux.local") by vger.kernel.org with ESMTP id S1751259AbWFGUGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 16:06:47 -0400
From: Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH v2 0/7][RFC] Ammasso 1100 iWARP Driver
Date: Wed, 07 Jun 2006 15:06:46 -0500
To: rdreier@cisco.com, mshefty@ichips.intel.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       openib-general@openib.org
Message-Id: <20060607200646.9259.24588.stgit@stevo-desktop>
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

        1 - Low-level device interface and native stack support
        2 - Work request definitions
        3 - Provider interface
        4 - Memory management
        5 - User mode message queue implementation      
        6 - Verbs queue implementation
        7 - Kconfig and Makefile

I believe I've addressed all the round 1 review comments.  Details of
the changes are tracked in each patch comment.

Signed-off-by: Tom Tucker <tom@opengridcomputing.com>
Signed-off-by: Steve Wise <swise@opengridcomputing.com>
