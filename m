Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVFOCuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVFOCuN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 22:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVFOCuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 22:50:13 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:30385 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261482AbVFOCuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 22:50:09 -0400
Subject: Re: RT and kernel debugger ( 2.6.12rc6  + RT  > 48-00 )
From: Lee Revell <rlrevell@joe-job.com>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1118673083.10717.83.camel@ibiza.btsn.frna.bull.fr>
References: <1118673083.10717.83.camel@ibiza.btsn.frna.bull.fr>
Content-Type: text/plain
Date: Tue, 14 Jun 2005 21:50:49 -0400
Message-Id: <1118800250.6093.61.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 16:31 +0200, Serge Noiraud wrote:
> Hi,
> 
> 	I would like to know what kernel debugger you propose over the RT
> patch. I used to test kgdb, but since spinlock modification, it doesn't
> work anymore.
> 
> Does someone work over RT to port a kernel debugger ?

I got kdb to work a few months ago.  I might have only been using
PREEMPT_DESKTOP + irq threading + hard/softirq preemption.  All that was
needed are some trivial adjustments to get the patch to apply.

Lee

