Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbVHXSjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbVHXSjq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 14:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbVHXSjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 14:39:46 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:30726 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751370AbVHXSjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 14:39:46 -0400
Date: Wed, 24 Aug 2005 11:39:51 -0700
Message-Id: <200508241839.j7OIdp5A001866@zach-dev.vmware.com>
Subject: [PATCH 0/5] Virtualization patches, set 4
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Virtualization Mailing List <virtualization@lists.osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Chris Wright <chrisw@osdl.org>
To: Martin Bligh <mbligh@mbligh.org>
To: Pratap Subrahmanyam <pratap@vmware.com>
To: Christopher Li <chrisl@vmware.com>
To: Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 24 Aug 2005 18:40:04.0101 (UTC) FILETIME=[3DF9C350:01C5A8DB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Transparent paravirtualization patches, set 4.  This batch includes
mostly MMU hooks that can be used by the hypervisor for page allocation,
and allows the kernel to be compiled to step out of the way of the
hypervisor by making a hole in linear address space.

Patches are based off 2.6.13-rc6-mm2; I've tested i386 PAE and non-PAE
as well as um-i386.  Although these are mostly i386 specific, some of
the concepts are starting to apply to virtualization of other
architectures as well.

Zachary Amsden <zach@vmware.com>
