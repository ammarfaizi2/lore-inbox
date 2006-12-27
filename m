Return-Path: <linux-kernel-owner+w=401wt.eu-S1753674AbWL0IwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbWL0IwP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 03:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753635AbWL0IwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 03:52:14 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:26311 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632AbWL0IwN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 03:52:13 -0500
Message-ID: <45923432.9040607@chelsio.com>
Date: Wed, 27 Dec 2006 00:52:02 -0800
From: Divy Le Ray <divy@chelsio.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: Divy Le Ray <None@chelsio.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, swise@opengridcomputing.com
Subject: Re: [PATCH 1/10] cxgb3 - main header files
References: <20061220124125.6286.17148.stgit@localhost.localdomain> <45918CA4.3020601@garzik.org>
In-Reply-To: <45918CA4.3020601@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Dec 2006 08:52:04.0651 (UTC) FILETIME=[483267B0:01C72994]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff,

You can grab the monolithic patch at this URL:
http://service.chelsio.com/kernel.org/cxgb3.patch.bz2

This patch adds support for the latest 1G/10G Chelsio adapter, T3.
It is required by the T3 RDMA driver Steve Wise submitted.

Here is a brief description of its content:

 drivers/net/cxgb3/adapter.h,
 drivers/net/cxgb3/common.h,
 drivers/net/cxgb3/cxgb3_ioctl.h,
 drivers/net/cxgb3/firmware_exports.h:
     main header files

 drivers/net/cxgb3/cxgb3_main.c
     main source file

 drivers/net/cxgb3/t3_hw.c
     HW access routines

 drivers/net/cxgb3/sge.c,
 drivers/net/cxgb3/sge_defs.h
     scatter/gather engine

 drivers/net/cxgb3/ael1002.c,
 drivers/net/cxgb3/mc5.c,
 drivers/net/cxgb3/vsc8211.c,
 drivers/net/cxgb3/xgmac.c
     on board memory, MAC and PHY management

 drivers/net/cxgb3/cxgb3_ctl_defs.h,
 drivers/net/cxgb3/cxgb3_defs.h,
 drivers/net/cxgb3/cxgb3_offload.h,
 drivers/net/cxgb3/l2t.h, 
 drivers/net/cxgb3/t3_cpl.h,
 drivers/net/cxgb3/t3cdev.h
     offload operations header files

 drivers/net/cxgb3/cxgb3_offload.c,
 drivers/net/cxgb3/l2t.c
     offload capabilities

 drivers/net/cxgb3/regs.h
     register definitions

 drivers/net/Kconfig
 drivers/net/Makefile
 drivers/net/cxgb3/Makefile
 drivers/net/cxgb3/version.h
     build files and versioning

Signed-off-by: Divy Le Ray <divy@chelsio.com>
---
