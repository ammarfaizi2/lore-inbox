Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbTKLT2y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 14:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264271AbTKLT2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 14:28:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:27043 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264260AbTKLT2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 14:28:53 -0500
Date: Wed, 12 Nov 2003 11:28:49 -0800
From: Chris Wright <chrisw@osdl.org>
To: Brian Litzinger <brian@top.worldcontrol.com>, linux-kernel@vger.kernel.org
Subject: Re: Toshiba P25-S507 laptop and freezes with 2.6.0-test9
Message-ID: <20031112112849.A12974@osdlab.pdx.osdl.net>
References: <20031112182711.GA5454@top.worldcontrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20031112182711.GA5454@top.worldcontrol.com>; from brian@worldcontrol.com on Wed, Nov 12, 2003 at 10:27:11AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* brian@worldcontrol.com (brian@worldcontrol.com) wrote:
> 
> My Toshiba P25-S507 P4 2.8 running vanilla 2.6.0-test9 occasionally
> freezes.  The freezes occur during events such as closing or opening
> the lid or removing/inserting the power adapter and sometimes during
> halt.

These are ACPI events (at least lid and power adaptor).  So, are you
compiling in ACPI support?  If so does it still happen with acpi=off
kernel command line option?  Do you still have keyboard when it freezes?
If so, alt-sysrq-p or alt-sysrq-t show anything useful?  And, finally,
you aren't using an nVidia binary only module for that GeForce are you?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
