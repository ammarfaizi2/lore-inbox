Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWIOSId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWIOSId (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 14:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWIOSId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 14:08:33 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:22915 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751320AbWIOSIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 14:08:32 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200609151316_MC3-1-CB57-4BE@compuserve.com>
References: <200609151316_MC3-1-CB57-4BE@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 19:32:06 +0100
Message-Id: <1158345126.29932.122.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-15 am 13:14 -0400, ysgrifennodd Chuck Ebbert:
> In-Reply-To: <1158331071.29932.63.camel@localhost.localdomain>
> > > $ grep KPROBES arch/*/Kconf*
> > > arch/i386/Kconfig:config KPROBES
> > > arch/ia64/Kconfig:config KPROBES
> > > arch/powerpc/Kconfig:config KPROBES
> > > arch/sparc64/Kconfig:config KPROBES
> > > arch/x86_64/Kconfig:config KPROBES
> >
> > Send patches. The fact nobody has them implemented on your platform
> > isn't a reason to implement something else, quite the reverse in fact.
> 
> Yes, but the point is: until that's done you can't claim kprobes is a
> valid tracing tool for everyone.

I can however claim that kprobes is what they should be implementing not
adding new large patches for another infrastructure whose author has
already said for dynamic stuff it is based on the same things.


