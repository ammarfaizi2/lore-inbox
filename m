Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVBRHJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVBRHJe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 02:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVBRHJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 02:09:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:8366 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261301AbVBRHJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 02:09:32 -0500
Subject: Current bk on ppc32: kernel text corruption
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 18:09:14 +1100
Message-Id: <1108710554.5587.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, we may not be over with memory corruption bugs yet. ppc64 now seem
stable running LTP overnight, but my laptop has a page of kernel .text
replaced with zero's as soon as I launch X (and just X, no need to launc
the whole desktop environment).

I suspect remap_pfn_range() but I haven't checked yet.

Ben.


