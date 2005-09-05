Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVIENVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVIENVf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 09:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbVIENVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 09:21:35 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:36339 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932138AbVIENVe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 09:21:34 -0400
Date: Mon, 5 Sep 2005 18:49:43 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Con Kolivas <kernel@kolivas.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050905131943.GB8624@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050831165843.GA4974@in.ibm.com> <200509031801.09069.kernel@kolivas.org> <20050903090650.B26998@flint.arm.linux.org.uk> <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050905070053.GA7329@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905070053.GA7329@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 12:30:53PM +0530, Srivatsa Vaddagiri wrote:
> > Thus, for x86, we would have a dyn_tick_timer structure for the PIT,
> > APIC, ACPI PM-timer and the HPET. These structures could be put in
> 
> Does the ACPI PM-timer support generating interrupts also? Same question
> I have for HPET.

I think HPET does support generation of interrupts but not PM timer.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
