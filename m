Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265748AbUBBSJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 13:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265751AbUBBSJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 13:09:13 -0500
Received: from fmr03.intel.com ([143.183.121.5]:17554 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S265748AbUBBSJL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 13:09:11 -0500
Subject: Re: ACPI/battery status on Dell Inspiron 8200 broken, 2.6.2-rc3
From: Len Brown <len.brown@intel.com>
To: David Ford <david+powerix@blue-labs.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0023E8445@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0023E8445@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1075745336.2389.72.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 02 Feb 2004 13:08:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

Please try this patch
http://bugzilla.kernel.org/attachment.cgi?id=1965&action=view

and note in this bug report if it works for you.
http://bugzilla.kernel.org/show_bug.cgi?id=1766

thanks,
-Len

On Mon, 2004-02-02 at 02:29, David Ford wrote:
> Battery status got lost in either rc2 or rc3.  It worked in rc1.
> 
> powerix klaptopdaemon # cat /proc/acpi/battery/BAT0/info
> present:                 yes
> design capacity:         0 mWh
> last full capacity:      0 mWh
> battery technology:      non-rechargeable
> design voltage:          0 mV
> design capacity warning: 0 mWh
> design capacity low:     0 mWh
> capacity granularity 1:  0 mWh
> capacity granularity 2:  0 mWh
> model number:
> serial number:
> battery type:
> OEM info:
> 
> powerix klaptopdaemon # cat /proc/acpi/battery/BAT0/state
> present:                 yes
> capacity state:          ok
> charging state:          unknown
> present rate:            0 mA
> remaining capacity:      0 mAh
> present voltage:         0 mV
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

