Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbUB0Miu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 07:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262764AbUB0Miu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 07:38:50 -0500
Received: from gate.crashing.org ([63.228.1.57]:53946 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262729AbUB0Mgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 07:36:51 -0500
Subject: [PATCH] ppc64 iommu rewrite part 3/5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077884879.22232.385.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 23:28:00 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This one is probably too large for the list, sent privately
to the usual culprits, lurkers can find it at:

http://gate.crashing.org/~benh/iommu-rewrite-part3.diff

<<
Bulk of the iommu rewrite.

Lots of things renamed, sillicaps killed, stuffs moved around and
common code properly extracted from implementation specific code,
new allocator, etc... The code is overall a lot simpler, faster,
less prone to fail, and a lot more manageable.
I didn't use "bk mv", there is no need to keep the old history
attached to the new file.
>>


