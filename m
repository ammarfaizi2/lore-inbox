Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266049AbUBQGL6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 01:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266037AbUBQGL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 01:11:57 -0500
Received: from fmr03.intel.com ([143.183.121.5]:48296 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S266051AbUBQGKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 01:10:10 -0500
Subject: Re: 2.6.2: ACPI -VS- PPPoE / aDSL
From: Len Brown <len.brown@intel.com>
To: leonard <leonard@internetdown.org>
Cc: linux-kernel@vger.kernel.org, root@dune2.info
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0023E8B87@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0023E8B87@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1076998200.2510.19.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 17 Feb 2004 01:10:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-09 at 20:35, leonard wrote:
> Hello everyone,
> 
> With Linux kernel last 'stable' version 2.6.2,
> i had to compile withOUT ACPI to get my PPPoE/aDSL working :/
> 
> ACPI works great by itself, but does not let my pppoe driver
> (the roaring penguin) do its job properly.
> Note I did not try with the new kernel-space pppoe driver.
> 
> It was the same way between ACPI and DHCP in kernel 2.6.0-TEST9
> 
> Just letting you know, I'm sure far from being alone with this
> issue, but didn't find any messages talking about it in the archives.
> 
> Take care ACPI developpers ;)
> Guillaume
> 
> P.S. Please CC any unlikely answer to `root AT_ dune2 D0T_ info`
> that way I'm sure not to skip it :)

Leonard,
please try booting with pci=noacpi -- if that causes the box to work,
then you have an ACPI interrupt configuration problem.  If it doesn't,
try booting with "acpi=off" to confirm that it functions properly with
ACPI completely out of the picture.

also, the acpi developers are actually at
acpi-devel@lists.sourceforge.net.

thanks,
-Len


