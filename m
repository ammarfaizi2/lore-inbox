Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311367AbSCMUwx>; Wed, 13 Mar 2002 15:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311363AbSCMUwn>; Wed, 13 Mar 2002 15:52:43 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:50344 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S311368AbSCMUw0>;
	Wed, 13 Mar 2002 15:52:26 -0500
Date: Wed, 13 Mar 2002 21:52:14 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200203132052.VAA08581@harpo.it.uu.se>
To: davej@suse.de, fryman@cc.gatech.edu
Subject: Re: IO-APIC -- lockup on machine if enabled
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002 15:10:24 +0100, Dave Jones wrote:
> > i have a new laptop (Dell Latitude C610) running 2.4.18-rc4.  when i built the
> > new kernel, i thought i would amuse myself by turning on IO-APIC.
>
> Known problem.
>
> > any suggestions?
>
> "Don't do that"  8-)
> 2.5 (and possibly 2.4-ac) has the early-dmi code which disables this
> option if it detects its running on a Dell laptop.

2.5.6 has the original version of the patch kit, which includes the
workarounds for Dell laptops but doesn't include the newer blacklist
rules for the Thinkpad T20 and the MSI-6163.

2.4.19-pre3 has the relevant core changes, but lacks the actual DMI
rules and local APIC workarounds. I believe the -ac versions also
only include the core changes.

/Mikael

p.s. The update for 2.4.19-pre3 and the full kit for 2.4.18 are
at <http://www.csd.uu.se/~mikpe/linux/patches/2.4/> as usual.
