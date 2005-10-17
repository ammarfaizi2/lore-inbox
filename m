Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbVJQRl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbVJQRl6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 13:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbVJQRl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 13:41:58 -0400
Received: from fmr17.intel.com ([134.134.136.16]:45748 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750917AbVJQRl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 13:41:58 -0400
Subject: Re: [ACPI] Re: [patch 0/2] acpiphp: hotplug adapters with bridges
	on them
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Paul Ionescu <i_p_a_u_l@yahoo.com>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <pan.2005.10.13.11.29.11.335682@yahoo.com>
References: <1128707145.11020.9.camel@whizzy>
	 <pan.2005.10.13.11.29.11.335682@yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 17 Oct 2005 10:41:46 -0700
Message-Id: <1129570906.28798.5.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
X-OriginalArrivalTime: 17 Oct 2005 17:41:47.0606 (UTC) FILETIME=[0C357760:01C5D342]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-13 at 14:29 +0300, Paul Ionescu wrote:
> On Fri, 07 Oct 2005 10:45:45 -0700, Kristen Accardi wrote:
> 
> > These 2 patches will allow adapters with p2p bridges on them to be
> > successfully hotplugged using the acpiphp driver.  Currently, if you
> > attempt to hotplug an adapter with a p2p bridge on it, the operation will
> > fail because resources are not allocated to it properly.  These patches
> > have had very limited testing as I only have one machine and one type of
> > adapter to test this with.  I tested this with 2.6.14-rc2, but the patch
> > applies fine to rc3 as well.
> 
> Is this patch supposed to allow me to hot-plug/hot-eject my laptop in its
> docking station ?


Hi Paul,
Actually, I did this patch as part of the work I'm doing to enable
docking station support.  It is necessary for docking station, however,
it isn't the only thing that is needed to get docking station to work.
The docking station patch is in progress still - and will hopefully be
ready for testing soon.

Kristen

> I have an IBM T41 and a docking station with extra IDE/PCI/PCMCIA bus-es on it.
> I've tried for a long time to make them work hot, but till now, I could
> not make them work.
> I can only use the docking station if I boot in it.
> 
> Thanks,
> Paul
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Power Architecture Resource Center: Free content, downloads, discussions,
> and more. http://solutions.newsforge.com/ibmarch.tmpl
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
