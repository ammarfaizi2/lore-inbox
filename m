Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbUARST7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 13:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbUARST7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 13:19:59 -0500
Received: from fmr03.intel.com ([143.183.121.5]:16870 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S262714AbUARST6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 13:19:58 -0500
Subject: Re: ACPI: problem on ASUS PR-DLS533
From: Len Brown <len.brown@intel.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Andrew Walrond <andrew@walrond.org>, andreas@xss.co.at,
       Luming Yu <luming.yu@intel.com>, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0020ADE84@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0020ADE84@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1074449979.2387.41.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 18 Jan 2004 13:19:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, bugzilla 1662 (1127, 1741) appears to be a BIOS bug -- _BBN returns
0.  I believe that this is not a Linux regression, but would break any
version of Linux/ACPI shipped to date.

I've no idea how Windows would cope with this -- unless they're using a
workaround outside the ACPI spec.  It appears that the failing systems
all have serverworks chip-sets -- so there may be a chip-set dependent
issue we don't know about.

Thanks for making sure that you're running the latest BIOS.

I do think we should contact Asus to request them to fix it.  However,
my experience is that vendors are very good about fixing bugs that are
found whey they're validating their new systems, but much less
responsive for systems that have already shipped -- more so as the
systems age.  This is why it is important that passing some Linux distro
validation suite become a prerequisite for OEMs to start shipping
systems.

I do think we should investigate how to make Linux more robust in the
face of this issue.  Lets work it here:
http://bugzilla.kernel.org/show_bug.cgi?id=1662

thanks,
-Len


