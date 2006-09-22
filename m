Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWIVLvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWIVLvG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 07:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWIVLvG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 07:51:06 -0400
Received: from ozlabs.org ([203.10.76.45]:17900 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932298AbWIVLvD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 07:51:03 -0400
Subject: [PATCH 0/7] Using %gs for per-cpu areas on x86
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: virtualization <virtualization@lists.osdl.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 21:51:00 +1000
Message-Id: <1158925861.26261.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, here it is.  Benchmarks still coming.  This is against Andi's
2.6.18-rc7-git3 tree, and replaces the patches between (and not
including) i386-pda-asm-offsets and i386-early-fault.

One patch is identical, one is mildly modified, the rest are
re-implemented but inspired by Jeremy's PDA work.

Thanks,
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

