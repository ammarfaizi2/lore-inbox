Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUBATlI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 14:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265094AbUBATlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 14:41:08 -0500
Received: from fmr04.intel.com ([143.183.121.6]:39587 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263568AbUBATlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 14:41:05 -0500
Subject: Re: ACPI breakage in 2.6.2-rc3 (and before)
From: Len Brown <len.brown@intel.com>
To: trelane@digitasaru.net
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0020AEAEA@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0020AEAEA@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1075664452.2394.5.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Feb 2004 14:40:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph,
Please try this patch
http://bugzilla.kernel.org/attachment.cgi?id=1965&action=view

from this bug report:
http://bugzilla.kernel.org/show_bug.cgi?id=1766

It should be in the next mm patch, and if it causes no regression will
be pushed to 2.6.2.

thanks,
-Len

On Sun, 2004-02-01 at 15:19, Joseph Pingenot wrote:
> From Linus Torvalds on Friday, 30 January, 2004:
> >The bulk of this is an ACPI update, but there's USB, ia-64, i2c, XFS
> and
> >PCI hotplug updates here too.
> >Please don't send in anything but critical fixes until after the
> final
> >2.6.2 release.
> 
> Hmm.  I just tried 2.6.2-rc3 (after having tried 2.6.1 after having
>   tried 2.6.2-rc2-mm1), and I note that ACPI can get my battery
>   status in 2.6.1, but *not* in 2.6.2-rc2-mm1 or in 2.6.2-rc3.
>   It notes that there is a battery in one of the two bays, and
>   that it's on battery or AC power, but nothing more; all status
>   readouts say that the battery's drained.
> 
> System is a Dell Inspiron 8600.
> 
> Thanks!
> 
> 
> -Joseph
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

