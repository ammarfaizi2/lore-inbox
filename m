Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTLRIMM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 03:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTLRIMM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 03:12:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:43216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262805AbTLRIMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 03:12:09 -0500
Date: Thu, 18 Dec 2003 00:12:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0 (ACPI)
Message-Id: <20031218001243.112ae96d.akpm@osdl.org>
In-Reply-To: <1071734123.2497.66.camel@dhcppc4>
References: <BF1FE1855350A0479097B3A0D2A80EE001B57534@hdsmsx402.hd.intel.com>
	<1071734123.2497.66.camel@dhcppc4>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown <len.brown@intel.com> wrote:
>
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix/should-fix-7.txt
> 
> We have 88 open bugs against ACPI (out of 216 total).

Poor Len ;)

> They fall into
> two broad categories -- boot/configuration (eg. interrupt issues); and
> run-time features (eg. acpi events -- power-down, fan control etc). 
> #1038 mentioned here has sort of grown out of control into "anything at
> all wrong with anybody's IBM T40", so I'm not sure it will ever be
> completely closed;-)
> 
> I agree with Andy Grover's comments in this file that fixing the bugs
> one by one in the current design is the highest priority; and I think
> that strategy is showing positive results.

Great.

> >   fixes appear in Andrew Morton's "-mm" tree, at
> > 
> >         ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/
> > 
> 
> Now that you're back, we should probably pull the current 2.6.0 ACPI
> patch into the mm tree, since 2.6 without it is now somewhat behind
> 2.4.23.
> 
> I understand that consolidated plain patches are preferred for the mm
> tree.

They're easiest for me, but a bitkeeper pull is OK too.

>  I assume that the actual pull into the release tree can still be
> done using bk so that we can preserve the individual csets and their
> comments?

Well..  If you have isolated patches which are confirmed to fix the problem
then there is no benefit in staging these changes in -mm: just merge them
up.   It depends upon your confidence level, really.


