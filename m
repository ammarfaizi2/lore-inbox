Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWHKJaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWHKJaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 05:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWHKJ34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 05:29:56 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:49039 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751068AbWHKJ3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 05:29:51 -0400
Date: Fri, 11 Aug 2006 02:15:08 -0700
Message-Id: <200608110915.k7B9F7fQ023251@zach-dev.vmware.com>
Subject: [PATCH 0/9] i386 MMU paravirtualization patches
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux MM <linux-mm@kvack.org>, ":"@vmware.com,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 11 Aug 2006 09:29:49.0596 (UTC) FILETIME=[B13415C0:01C6BD28]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches provide the infrastructure for paravirtualized MMU operations
while at the same time cleaning up and optimizing the pagetable accessors for
i386.  They should be largely uncontroversial and are well tested.  There are
still some performance gains to be had for paravirtualization, but it is more
important to get the native code base that will enable them checked in first.

Zach
