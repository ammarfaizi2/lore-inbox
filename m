Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750951AbVJ2Am7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbVJ2Am7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 20:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbVJ2Am6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 20:42:58 -0400
Received: from fmr23.intel.com ([143.183.121.15]:52712 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750950AbVJ2Am6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 20:42:58 -0400
Message-Id: <200510290042.j9T0gsg28096@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Felix Oxley'" <lkml@oxley.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: kernel performance update - 2.6.14
Date: Fri, 28 Oct 2005 17:42:54 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcXcH8zG9iiU4/mcRCKe8CHIcAKfGwAABgvA
In-Reply-To: <4362C255.30600@oxley.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix Oxley wrote on Friday, October 28, 2005 5:29 PM
> Something went horribly wrong with this test between 2.6.13 and 
> 2.6.13-git2 (it has never recovered):
> 
> System: 4P Itanium
> Test:Result Group 1
> Metric: VolcanoMark
> Result:      -3%         -10%
> Kernel: 2.6.13 vs 2.6.13-git2
> 
> Does anybody know the cause of this?

Search the archive, it was discussed here:
http://marc.theaimsgroup.com/?l=linux-ia64&m=112683124124723&w=2


It is not because of changes in 2.6.13-git2. It would've shown on
2.6.13-rc1 when default hz rate was switched to 250.  I happened
to audit the system at that time and made the hz switch (from 1000
to 250 and the problem showed up.

More discussion here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=112854723926854&w=2


- Ken

