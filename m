Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbTLRHzi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 02:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbTLRHzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 02:55:38 -0500
Received: from fmr03.intel.com ([143.183.121.5]:36552 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S263060AbTLRHzd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 02:55:33 -0500
Subject: Re: Linux 2.6.0 (ACPI)
From: Len Brown <len.brown@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE001B57534@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE001B57534@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1071734123.2497.66.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 18 Dec 2003 02:55:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix/should-fix-7.txt

We have 88 open bugs against ACPI (out of 216 total).  They fall into
two broad categories -- boot/configuration (eg. interrupt issues); and
run-time features (eg. acpi events -- power-down, fan control etc). 
#1038 mentioned here has sort of grown out of control into "anything at
all wrong with anybody's IBM T40", so I'm not sure it will ever be
completely closed;-)

I agree with Andy Grover's comments in this file that fixing the bugs
one by one in the current design is the highest priority; and I think
that strategy is showing positive results.

>   fixes appear in Andrew Morton's "-mm" tree, at
> 
>         ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/
> 

Now that you're back, we should probably pull the current 2.6.0 ACPI
patch into the mm tree, since 2.6 without it is now somewhat behind
2.4.23.

I understand that consolidated plain patches are preferred for the mm
tree.  I assume that the actual pull into the release tree can still be
done using bk so that we can preserve the individual csets and their
comments?

> Some active subsystem mailing lists
>   are:

>         linux-acpi@intel.com

acpi-devel@lists.sourceforge.net is preferred -- it includes the Intel
alias above plus the rest of planet ACPI.

thanks,
-Len


