Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWI3Iny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWI3Iny (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWI3Inx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:43:53 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:20279 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751153AbWI3Inw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:43:52 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 0 of 4] x86-64: Calgary IOMMU updates
Message-Id: <patchbomb.1159605808@rhun.haifa.ibm.com>
Date: Sat, 30 Sep 2006 11:43:28 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: ak@suse.de
Cc: jdmason@kudzu.us, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       muli@il.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

[resending with proper CC's].

Please apply this Calgary patchset. It fixes one bug
(https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=203971, should
go to -stable as well) and makes several other updates all of which
are safe for 2.6.19. Each patch has a detailed description.

Thanks,
Muli

2 files changed, 25 insertions(+), 13 deletions(-)
MAINTAINERS                      |    2 +-
arch/x86_64/kernel/pci-calgary.c |   36 ++++++++++++++++++++++++------------

