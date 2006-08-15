Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbWHORkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbWHORkV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 13:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWHORkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 13:40:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55779 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030367AbWHORkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 13:40:20 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: linux-kernel@vger.kernel.org
Cc: anemo@mba.ocn.ne.jp, schwidefsky@de.ibm.com, mm-commits@vger.kernel.org
Subject: Re: - simplify-update_times-avoid-jiffies-jiffies_64-aliasing-problem.patch removed from -mm tree
References: <200608141803.k7EI3Plc024729@shell0.pdx.osdl.net>
Date: Tue, 15 Aug 2006 11:39:57 -0600
In-Reply-To: <200608141803.k7EI3Plc024729@shell0.pdx.osdl.net>
	(akpm@osdl.org's message of "Mon, 14 Aug 2006 11:03:25 -0700")
Message-ID: <m1veot99ua.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org writes:

> The patch titled
>
>      simplify update_times (avoid jiffies/jiffies_64 aliasing problem)
>
> has been removed from the -mm tree.  Its filename is
>
>      simplify-update_times-avoid-jiffies-jiffies_64-aliasing-problem.patch
>
> This patch was dropped because it had testing failures

Thanks.  I didn't see a thread on linux-kernel for this so I
just wanted to report that this patch killed my boot when the
serial driver initialized, and at some other point as well when
I did not compile in the serial driver.

Just in case an additional data point was needed.

Eric
