Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267537AbUJBU0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267537AbUJBU0n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 16:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUJBU0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 16:26:43 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:28356 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S267537AbUJBU01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 16:26:27 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm1 [immediate crash on AMD64]
Date: Sat, 2 Oct 2004 22:28:53 +0200
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@muc.de>
References: <2KNUn-2Wp-3@gated-at.bofh.it> <2KXKe-1yN-33@gated-at.bofh.it> <m3655szyud.fsf@averell.firstfloor.org>
In-Reply-To: <m3655szyud.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410022228.53558.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 of October 2004 21:47, Andi Kleen wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
> > ACPI: IRQ9 SCI: Edge set to Level Trigger.
> > Unable to handle kernel NULL pointer dereference at 0000000000000018 RIP:
> > <ffffffff8056bdf7>{setup_local_APIC+23}
> > PML4 0
> > Oops: 0000 [1]
> > CPU 0
> > Modules linked in:
> > Pid: 1, comm: swapper Tainted: G   M  2.6.9-rc3-mm1
> > RIP: 0010:[<ffffffff8056bdf7>] <ffffffff8056bdf7>{setup_local_APIC+23}
> 
> I would revert x86-64-clustered-apic-support.patch 

You are right, it helps here. :-)

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
