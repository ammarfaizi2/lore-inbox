Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267190AbUHSS0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267190AbUHSS0l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 14:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267197AbUHSS0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 14:26:41 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:39376 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267190AbUHSS0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 14:26:34 -0400
From: jmerkey@comcast.net
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: kallsyms 2.6.8 address ordering
Date: Thu, 19 Aug 2004 18:26:31 +0000
Message-Id: <081920041826.25654.4124F0D700037D32000064362200734748970A059D0A0306@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Jul 16 2004)
X-Authenticated-Sender: am1lcmtleUBjb21jYXN0Lm5ldA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes.

What would be required?   Source code disclosure to a reviewer.  MDB is platform independent.  and patches in an alternate debugger interface in kdb_main.  In includes **NONE** of SGI's source code or Linux kernel source in the MDB core.  There is an open source section of the debugger with **ALL** modifications to kdb core files disclosed with the debugger modules.  The fact is, I don't even need kdb, but inlcuded it in a mode where folks who wanted to switch between the two debuggers could do so, since a lot of folks wanted to.  I do use the serial interface in kdb, which is the only portion.  I wrote MANOS with this debugger, and all the low level GDT, IDT, etc. hardware stuff is my own, is vastly superior to what's in kdb.   

DRDOS owns the MDB debugger for Linux now and I maintain it for them -- that's it.  I am certain DRDOS would provide any counter-claims with **FACTS** to assertions we are using any of the kdb code improperly.

Jeff


> On Thu, Aug 19, 2004 at 06:10:25PM +0000, jmerkey@comcast.net wrote:
> > kallsyms in 2.6.8 is presenting module symbol tables with out of order
> > addresses in 2.6.X.  This makes maintaining a commercial kernel debugger
> > for Linux 2.6 kernels nighmareish.
> 
> Can you prove this debugger doesn't violate SGI's copyrights on KDB?
