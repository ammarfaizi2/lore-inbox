Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbVCDA1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbVCDA1Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbVCDAGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:06:39 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:53494 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262721AbVCCXV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:21:57 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][0/26] InfiniBand merge
In-Reply-To: 
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:26 -0800
Message-Id: <2005331520.b7ycIGGfSwBBRSED@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:26.0957 (UTC) FILETIME=[954D5FD0:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another series of patches that applies on top of the fixes I
posted yesterday.  This series syncs the kernel with everything ready
for merging from the OpenIB subversion tree.

Most of these patches add more support for "mem-free" mode to mthca.
This allows PCI Express HCAs to operate by storing context in the host
system's memory rather than in dedicated memory attached to the HCA.
With this series of patches, mem-free mode is usable -- in fact, this
series of patches is being posted from a system whose only network
connection is IP-over-IB running on a mem-free HCA.

Thanks,
  Roland

