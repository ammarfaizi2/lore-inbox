Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWHYM6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWHYM6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 08:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWHYM6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 08:58:21 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:52171 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750813AbWHYM6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 08:58:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17646.62439.526277.862006@cargo.ozlabs.ibm.com>
Date: Fri, 25 Aug 2006 22:58:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: schwidefsky@de.ibm.com
Cc: Helge Hafting <helge.hafting@aitel.hist.no>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] dubious process system time.
In-Reply-To: <1156501768.1640.19.camel@localhost>
References: <20060824121825.GA4425@skybase>
	<p731wr6fh54.fsf@verdi.suse.de>
	<1156426103.28464.29.camel@localhost>
	<200608241718.29406.ak@suse.de>
	<1156435363.28464.33.camel@localhost>
	<44EECCF9.7080902@aitel.hist.no>
	<1156501768.1640.19.camel@localhost>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky writes:

> The main question still is if it is correct to add softirq/hardirq time
> to the system time of a process. If the answer turns out to be yes, then
> it might be a clever idea to account softirq time to the softirqd. That
> still leaves the question what to do with hardirq time ..
> My take still is that softirq/hardirq time does not belong to the system
> time of any process.

I agree.

Paul.
