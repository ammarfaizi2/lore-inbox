Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWHPBH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWHPBH5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 21:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWHPBH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 21:07:57 -0400
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:63386 "EHLO
	topsns2.toshiba-tops.co.jp") by vger.kernel.org with ESMTP
	id S1750739AbWHPBH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 21:07:56 -0400
Date: Wed, 16 Aug 2006 10:07:50 +0900 (JST)
Message-Id: <20060816.100750.08077480.nemoto@toshiba-tops.co.jp>
To: ebiederm@xmission.com
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com,
       mm-commits@vger.kernel.org
Subject: Re: -
 simplify-update_times-avoid-jiffies-jiffies_64-aliasing-problem.patch
 removed from -mm tree
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <m1veot99ua.fsf@ebiederm.dsl.xmission.com>
References: <200608141803.k7EI3Plc024729@shell0.pdx.osdl.net>
	<m1veot99ua.fsf@ebiederm.dsl.xmission.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 11:39:57 -0600, ebiederm@xmission.com (Eric W. Biederman) wrote:
> >      simplify-update_times-avoid-jiffies-jiffies_64-aliasing-problem.patch
> >
> > This patch was dropped because it had testing failures
> 
> Thanks.  I didn't see a thread on linux-kernel for this so I
> just wanted to report that this patch killed my boot when the
> serial driver initialized, and at some other point as well when
> I did not compile in the serial driver.
> 
> Just in case an additional data point was needed.

I posted a patch to fix this failure.  Please try with it.  Thanks.

http://lkml.org/lkml/2006/8/15/135

I'll cook a new patch including this fix and AVR32 do_timer fix.

---
Atsushi Nemoto
