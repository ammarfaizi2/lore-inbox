Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWIORVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWIORVd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 13:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWIORVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 13:21:32 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:8909 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932122AbWIORVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 13:21:32 -0400
Date: Fri, 15 Sep 2006 13:14:47 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure)
  0.5.108
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>, Jes Sorensen <jes@sgi.com>,
       Paul Mundt <lethal@linux-sh.org>, Karim Yaghmour <karim@opersys.com>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev <ltt-dev@shafik.org>,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Message-ID: <200609151316_MC3-1-CB57-4BE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1158331071.29932.63.camel@localhost.localdomain>

On Fri, 15 Sep 2006 15:37:51 +0100, Alan Cox wrote:

> > $ grep KPROBES arch/*/Kconf*
> > arch/i386/Kconfig:config KPROBES
> > arch/ia64/Kconfig:config KPROBES
> > arch/powerpc/Kconfig:config KPROBES
> > arch/sparc64/Kconfig:config KPROBES
> > arch/x86_64/Kconfig:config KPROBES
>
> Send patches. The fact nobody has them implemented on your platform
> isn't a reason to implement something else, quite the reverse in fact.

Yes, but the point is: until that's done you can't claim kprobes is a
valid tracing tool for everyone.

And things like net/ipv4/tcp_probe.c shouldn't be generally implemented
until every arch is supported.

-- 
Chuck
