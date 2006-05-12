Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWELQkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWELQkL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 12:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWELQkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 12:40:11 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:14768 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S932152AbWELQkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 12:40:09 -0400
Date: Fri, 12 May 2006 09:33:42 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200605121633.k4CGXgvq027279@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/11] perfmon2 patch for review: introduction
Cc: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following series of patches includes the generic perfmon2
subsystem and the support for i386, x86_64, and powerpc. The perfmon2
subsystem also works on MIPS and all Itanium processors. The Itanium support
is not posted because it does not easily accomodate the 100k message
limit of lkml. The powerpc support is still very preliminary.

The patches are relative to 2.6.17-rc4.

I have already posted on the list about this subsystem. I am submitting 
today to get reviews and make progress towards getting the subsystem
merged into the mainline kernel.

The patches are split up between common and arch-specific. Each part
is further decomposed into new files and modified files.

Thanks.
