Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVAPPkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVAPPkR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 10:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVAPPkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 10:40:17 -0500
Received: from lakermmtao06.cox.net ([68.230.240.33]:30346 "EHLO
	lakermmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261258AbVAPPkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 10:40:13 -0500
From: Steve Snyder <swsnyder@insightbb.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Testing optimize-for-size suitability?
Date: Sun, 16 Jan 2005 10:40:12 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501161040.12907.swsnyder@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a benchmark or set of benchmarks that would allow me to test the 
suitability of the CONFIG_CC_OPTIMIZE_FOR_SIZE kernel config option?

It seems to me that the benefit of this option is very dependant on the 
amount of CPU cache installed, with the compiler code generation being a 
secondary factor.  The use, or not, of CONFIG_CC_OPTIMIZE_FOR_SIZE is 
basically an act of faith without knowing how it impacts my particular 
environment.

I've got a Pentium4 CPU with 512KB of L2 cache, and I'm using GCC v3.3.3.  
How can I determine whether or not CONFIG_CC_OPTIMIZE_FOR_SIZE should be 
used for my system?

Thanks.

