Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWHKJQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWHKJQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 05:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWHKJQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 05:16:29 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:50861 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1750881AbWHKJQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 05:16:28 -0400
Date: Fri, 11 Aug 2006 02:16:26 -0700
Message-Id: <200608110916.k7B9GQWw023318@zach-dev.vmware.com>
Subject: [PATCH 0/9] i386 MMU paravirtualization patches
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Jeremy Fitzhardinge <jeremy@goop.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux MM <linux-mm@kvack.org>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 11 Aug 2006 09:16:27.0198 (UTC) FILETIME=[D2EFDDE0:01C6BD26]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches provide the infrastructure for paravirtualized MMU operations
while at the same time cleaning up and optimizing the pagetable accessors for
i386.  They should be largely uncontroversial and are well tested.  There are
still some performance gains to be had for paravirtualization, but it is more
important to get the native code base that will enable them checked in first.

Zach
