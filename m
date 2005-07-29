Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262876AbVG2Vav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbVG2Vav (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbVG2Vaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:30:46 -0400
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:39416 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S262876AbVG2Vad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:30:33 -0400
To: "Brown, Len" <len.brown@intel.com>
cc: "Andrew Morton" <akpm@osdl.org>, "Kevin Radloff" <radsaq@gmail.com>,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] RE: Followup on 2.6.13-rc3 ACPI processor C-state regression 
In-Reply-To: Your message of "Fri, 29 Jul 2005 15:11:29 EDT."
             <F7DC2337C7631D4386A2DF6E8FB22B3004311B75@hdsmsx401.amr.corp.intel.com> 
Date: Fri, 29 Jul 2005 22:30:23 +0100
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1DycQx-00067Z-00@skye.ra.phy.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Len, Kevin confirms that the below patch fixes the above regression for
>him.  Should we merge it now?

It also works for me.  Well, I'm not 100% sure it was that patch, but
2.6.13-rc3 on my TP 600X has the C2/C3 regression:

   ACPI: CPU0 (power states: C1[C1])

And 2.6.13-rc3-mm2, which includes that patch, works fine:

   ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])

-Sanjoy
