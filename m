Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUBZWlI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbUBZWlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:41:06 -0500
Received: from fmr02.intel.com ([192.55.52.25]:41370 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S261225AbUBZWkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:40:36 -0500
Subject: Re: 2.6.3-mm4
From: Len Brown <len.brown@intel.com>
To: Matthias Hentges <mailinglisten@hentges.net>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F33F5@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F33F5@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1077835227.22405.82.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 26 Feb 2004 17:40:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not aware of an ACPI code in -mm4 that was not in -mm3, so i suspect
this issue may be specific to radeon.

cheers,
-Len

On Thu, 2004-02-26 at 13:50, Matthias Hentges wrote:
> Hello!
> 
> In -mm4 ACPI suspend to ram (echo -n mem >/sys/power/state) no longer
> suspends my centrino laptop. This used to work in -mm3.
> 
> It fails to suspend "radeonfb" (which isn't active BTW, fbcon is not
> loaded but radeonfb is compiled in).
> 
>  I have attached a photo of the suspend message.
> 
> Please note that on this laptop ACPI always used to suspend the
> machine.
> It just never wakes up :)
> 
> And that's the reason i follow the latest -mm patches. I still hope
> *some* day suspend/resume will work ;)
> 
> Thought i'd share this.
> 
> Dateils of the laptop (dmesg, lspci) can be found here:
> http://www.hentges.net/howtos/samsung_p30_hwspecs.html
> 
> HTH & HAND
> -- 
> Matthias Hentges 
> Cologne / Germany
> 
> [www.hentges.net] -> PGP welcome, HTML tolerated
> ICQ: 97 26 97 4   -> No files, no URL's
> 
> My OS: Debian SID. Geek by Nature, Linux by Choice
> 

