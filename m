Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbVHLOrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbVHLOrR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbVHLOrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:47:17 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:37571 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750782AbVHLOrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:47:16 -0400
Subject: [RFC][PATCH 00/12] memory hotplug
From: Dave Hansen <haveblue@us.ibm.com>
To: linux-mm <linux-mm@kvack.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Fri, 12 Aug 2005 07:47:06 -0700
Message-Id: <1123858026.30202.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches are apply to 2.6.13-rc6, or to 2.6.13-rc5-mm1 (if
you back out the existing sparsemem-extreme.patch and apply the stuff I
posted yesterday).  Barring any serious objections, I think they're just
about ready for a run in -mm.

The following series implements memory hot-add for ppc64 and i386.
There are x86_64 and ia64 implementations that will be submitted shortly
as well.

There are some debugging patches that I use on i386 to do "fake"
hotplug, so I can share those if anybody wants to just play around with
it.

BTW, thanks to everybody who has sent code in and contributed little
bits and pieces to this.  Too numerous to name, but there were certainly
a lot more people than just me.

-- Dave

