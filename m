Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVC3Fzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVC3Fzk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 00:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVC3Fzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 00:55:40 -0500
Received: from fmr18.intel.com ([134.134.136.17]:47550 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261557AbVC3Fyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 00:54:35 -0500
From: "Yu, Luming" <luming.yu@intel.com>
Reply-To: luming.yu@intel.com
Organization: Intel
To: acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] 2.6.12-rc1-mm[1-3]: ACPI battery monitor does not work
Date: Wed, 30 Mar 2005 13:53:25 +0800
User-Agent: KMail/1.6.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>
References: <200503291156.19112.rjw@sisk.pl>
In-Reply-To: <200503291156.19112.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="gb18030"
Content-Transfer-Encoding: 7bit
Message-Id: <200503301353.25492.luming.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 March 2005 17:56, Rafael J. Wysocki wrote:
> Hi,
>
> There is a problem on my box (Asus L5D, x86-64 kernel) with the ACPI
> battery driver in the 2.6.12-rc1-mm[1-3] kernels.  Namely, the battery
> monitor that I use (the kpowersave applet from SUSE 9.2) is no longer able
> to report the battery status (ie how much % it is loaded).  It can only
> check if the AC power is connected (if it is connected, kpowersave behaves
> as though there was no battery in the box, and if it is not connected,
> kpowersave always shows that the battery is 1% loaded).
>
> Also, there are big latencies on loading and accessing the battery module,
> but the module loads successfully and there's nothing suspicious in dmesg.
>
> Please let me know if you need any additional information.
>
> Greets,
> Rafael

Could you just revert ec-mode patch, then retest? 
-- 
Thanks,
Luming
