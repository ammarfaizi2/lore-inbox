Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbTK3Ipy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 03:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTK3Ipy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 03:45:54 -0500
Received: from fmr03.intel.com ([143.183.121.5]:29909 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262072AbTK3Ipx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 03:45:53 -0500
Subject: Re: Problem Report 2.4.23 ACPI and ASUS TRL-DLS
From: Len Brown <len.brown@intel.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE00184CE53@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE00184CE53@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1070181948.2663.6.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 30 Nov 2003 03:45:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-11-29 at 12:10, Stephan von Krawczynski wrote:
> Hello,
> 
> I just found out that enabling ACPI (kernel 2.4.23) on an ASUS TRL-DLS
> board
> leads to a failing boot, caused by not configuring the onboard scsi
> aic
> interfaces. In fact they are simply gone from the pci list (no
> kidding).
> Disabling ACPI leads to a perfectly working box with:

Did earlier 2.4 or 2.6 kernels with ACPI configured work properly on
this box?

Does the failing kernel do any better if you tell it to boot with
"pci=noacpi" or "noapic"?

thanks,
-Len


