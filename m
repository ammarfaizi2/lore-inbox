Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264573AbUDVRMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264573AbUDVRMy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 13:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264574AbUDVRMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 13:12:54 -0400
Received: from fmr11.intel.com ([192.55.52.31]:43434 "EHLO
	fmsfmr004.fm.intel.com") by vger.kernel.org with ESMTP
	id S264573AbUDVRMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 13:12:52 -0400
Subject: Re: ACPI S3
From: Len Brown <len.brown@intel.com>
To: Anders Karlsson <anders@trudheim.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F9756@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F9756@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1082653950.16325.344.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Apr 2004 13:12:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-22 at 07:46, Anders Karlsson wrote:
> Hi,
> 
> Got a little problem with ACPI on a Thinkpad X31. I am running kernel
> 2.6.5 on it, and am experimenting with suspending it (to state S3).
> 
> It suspends alright, but switches on the backlight. That is not quite so
> useful. Is there anything I can do to switch that backlight of through
> ACPI?
> 
> The sleep script switches off the displays in X (works, tried and
> tested) but once ACPI drops into sleep state, the backlight comes back
> on. :-/
> 
> I am game for testing patches etc.

This is handled differently on different systems.
Probably best to file a bug to make sure we don't miss your kind of
system.

thanks,
-Len
-----
How to file a bug against ACPI:

http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
pick a Component, "Other" is okay if not choice is not clear.

Please attach the output from acpidmp, available in /usr/sbin/, or in
pmtools:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/


