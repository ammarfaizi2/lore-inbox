Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161014AbVKDEHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbVKDEHT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 23:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbVKDEHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 23:07:19 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:31927 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161014AbVKDEHR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 23:07:17 -0500
Subject: RE: NTP broken with 2.6.14
From: john stultz <johnstul@us.ibm.com>
To: "Brown, Len" <len.brown@intel.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Jean-Christian de Rivaz <jc@eclis.ch>, macro@linux-mips.org,
       linux-kernel@vger.kernel.org, dean@arctic.org, zippel@linux-m68k.org
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005117C9B@hdsmsx401.amr.corp.intel.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005117C9B@hdsmsx401.amr.corp.intel.com>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 20:07:13 -0800
Message-Id: <1131077233.27168.627.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 22:44 -0500, Brown, Len wrote:
> NFORCE2 on an ACPI-enabled kernel should automatically invoke
> the acpi_skip_timer_override BIOS workaround -- as
> the NFORCE family of chip-sets have the timer interrupt
> attached to pin-0, but some of them shipped with
> a bogus BIOS over-ride telling Linux the timer is on pin-2.
> 
> This issue is quite old -- google NFORCE2 and acpi_skip_timer_override.
> IIR there are whole web-sites with NFORCE2
> workarounds provided by its dedicated fans...

Thanks for the info, Len. Although its odd that the Jean-Christian's
issue appears to show up around the time the fix you mention shows up. 

Regardless, Jean-Chistian has some sever BIOS problems, so until those
are resolved, I suggest he use the workaround (noapic) and ping us if
the issue persists once he arrives at a supportable configuration.

thanks
-john

