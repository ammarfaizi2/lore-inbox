Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263781AbTDUHlb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 03:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263782AbTDUHlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 03:41:31 -0400
Received: from siaag2aa.compuserve.com ([149.174.40.131]:56731 "EHLO
	siaag2aa.compuserve.com") by vger.kernel.org with ESMTP
	id S263781AbTDUHla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 03:41:30 -0400
Date: Mon, 21 Apr 2003 03:48:00 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] 2.5.68 Fix IO_APIC IRQ assignment bug
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304210351_MC3-1-3544-3713@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes, we need to bail out in assign_irq_vector when we wrap around, 
> otherwise we cause collisions when programming the IOAPIC. And we also 
> need to avoid overruning NR_IRQS structures in setup_IO_APIC_irqs.


  Do you mean the panic on running out of sources should be put
back in?



------
 Chuck
