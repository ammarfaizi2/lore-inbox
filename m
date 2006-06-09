Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWFIH2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWFIH2Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 03:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWFIH2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 03:28:24 -0400
Received: from www.osadl.org ([213.239.205.134]:30080 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751397AbWFIH2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 03:28:23 -0400
Subject: Re: 2.6.17-rc6-rt1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: john stultz <johnstul@us.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Martin Murray <mmurray@vmware.com>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1149811066.4266.127.camel@cog.beaverton.ibm.com>
References: <20060607211455.GA6132@elte.hu>
	 <1149811066.4266.127.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 09:28:56 +0200
Message-Id: <1149838137.5257.130.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 16:57 -0700, john stultz wrote:
> This would cause gettimeofday to segfault when using a non-null 
> timezone pointer.
> 
> Many thanks to Martin Murray, who pointed out this issue and its fix.

Thanks, 

I take it that applies to -hrt too.

	tglx


