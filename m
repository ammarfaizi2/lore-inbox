Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUDOTvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 15:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbUDOTvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 15:51:05 -0400
Received: from fmr10.intel.com ([192.55.52.30]:44456 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S263117AbUDOTvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 15:51:01 -0400
Subject: RE: IO-APIC on nforce2 [PATCH]
From: Len Brown <len.brown@intel.com>
To: Allen Martin <AMartin@nvidia.com>
Cc: ross@datscreative.com.au,
       Christian =?ISO-8859-1?Q?Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>,
       Linux-Nforce-Bugs <Linux-Nforce-Bugs@exchange.nvidia.com>,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FB9D@mail-sc-6-bk.nvidia.com>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FB9D@mail-sc-6-bk.nvidia.com>
Content-Type: text/plain
Organization: 
Message-Id: <1082058625.24423.161.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 15 Apr 2004 15:50:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-15 at 14:33, Allen Martin wrote:

> It was a bug in our original nForce reference BIOS that we gave out to vendors.  Since then we fixed the reference BIOS, but since it was after products shipped, most of the motherboard vendors won't pick up the change unless they get complaints from customers.
> 
> We've fixed it for our reference BIOS for future products though.

Great!

Knowing this makes the path clear.
As we expected, an automatic workaround based on chip-set would
fail because some BIOS's are fixed and some are not.
So we either leave the workaround as manual bootparam
or try to enumerate all BIOS versions with the bug
in dmi_scan.  I'm content to do the former.  If distros
have trouble supporting nforce2 systems, they may want to add
to the later.

thanks,
-Len

ps.
I'm also excited to see a linux-nforce-bugs@exchange.nvidia.com alias
on your note.  Perhaps you can explain how we should use it.  Should
this alias be included on discussions of the more important issue --
the system hang that seems to be related to HALT in idle/C1?


