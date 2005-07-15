Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263182AbVGODFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbVGODFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 23:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbVGODFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 23:05:19 -0400
Received: from fmr20.intel.com ([134.134.136.19]:49592 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S263182AbVGODFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 23:05:17 -0400
From: "Yu, Luming" <luming.yu@intel.com>
Reply-To: luming.yu@intel.com
To: Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: 2.6.13-rc3 ACPI regression and hang on x86-64
Date: Fri, 15 Jul 2005 11:04:46 +0800
User-Agent: KMail/1.6.1
Cc: len.brown@intel.com, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <200507141036.j6EAaveO029891@harpo.it.uu.se>
In-Reply-To: <200507141036.j6EAaveO029891@harpo.it.uu.se>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200507151104.46790.luming.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 July 2005 18:36, Mikael Pettersson wrote:
> On my x86-64 laptop (Targa Visionary 811: Athlon64 + VIA chipset,
> Arima OEM:d HW also sold by eMachines and others), ACPI is broken
> and hangs the x86-64 2.6.13-rc3 kernel.
>
> During boot, ACPI reduces the screen's brightness (it's always
> done this in the x86-64 kernels but not the i386 ones), so I
> have to press a specific key combination (Fn+F8) to increase the
> brightness. This worked up to and including the 2.6.13-rc2 kernel,
> but with 2.6.13-rc3 it causes an error message:
>
> acpi_ec-0217 [04] acpi_ec_leave_burst_mo: ------->status fail
This message is a warning.

>
> on the console, and then the machine is hung hard.
If you didn't press that key,   the machine still hung?

>
> With the i386 kernel, both this key combination and the other one
> for reducing the brightness work as expected.
>
