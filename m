Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267522AbUJBTrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267522AbUJBTrn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 15:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267528AbUJBTrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 15:47:43 -0400
Received: from zero.aec.at ([193.170.194.10]:21006 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S267522AbUJBTrl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 15:47:41 -0400
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm1 [immediate crash on AMD64]
References: <2KNUn-2Wp-3@gated-at.bofh.it> <2KXKe-1yN-33@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 02 Oct 2004 21:47:38 +0200
In-Reply-To: <2KXKe-1yN-33@gated-at.bofh.it> (Rafael J. Wysocki's message of
 "Sat, 02 Oct 2004 21:30:22 +0200")
Message-ID: <m3655szyud.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:
> ACPI: IRQ9 SCI: Edge set to Level Trigger.
> Unable to handle kernel NULL pointer dereference at 0000000000000018 RIP:
> <ffffffff8056bdf7>{setup_local_APIC+23}
> PML4 0
> Oops: 0000 [1]
> CPU 0
> Modules linked in:
> Pid: 1, comm: swapper Tainted: G   M  2.6.9-rc3-mm1
> RIP: 0010:[<ffffffff8056bdf7>] <ffffffff8056bdf7>{setup_local_APIC+23}

I would revert x86-64-clustered-apic-support.patch 

-Andi


