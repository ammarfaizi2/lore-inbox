Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWEaN71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWEaN71 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 09:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbWEaN70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 09:59:26 -0400
Received: from palrel10.hp.com ([156.153.255.245]:61107 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S1751578AbWEaN70 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 09:59:26 -0400
Date: Wed, 31 May 2006 06:52:25 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200605311352.k4VDqPVq028367@frankl.hpl.hp.com>
To: eranian@hpl.hp.com
Subject: [PATCH 1/11] 2.6.17-rc5 perfmon2 patch for review: introduction
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following series of patches includes the generic perfmon2
subsystem and the support for i386, x86_64, and powerpc. The perfmon2
subsystem also works on MIPS and all Itanium processors. The Itanium support
is not posted because it does not easily accomodate the 100k message
limit of lkml. The powerpc support is still very preliminary.

The patches are relative to 2.6.17-rc5.

I have already posted on the list about this subsystem. I am submitting 
today to get reviews and make progress towards getting the subsystem
merged into the mainline kernel.

The patches are split up between common and arch-specific. Each part
is further decomposed into new files and modified files.

Thanks.
