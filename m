Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266507AbUGPGzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266507AbUGPGzP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 02:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266508AbUGPGzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 02:55:05 -0400
Received: from dirac.phys.uwm.edu ([129.89.57.19]:4503 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S266495AbUGPGy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 02:54:57 -0400
Date: Fri, 16 Jul 2004 01:54:55 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Peter Maas <fedora@rooker.dyndns.org>,
       Jurgen Kramer <gtm.kramer@inter.nl.net>,
       Claudio Martins <ctpm@ist.utl.pt>
Subject: RE: 3ware 9500S Drivers (mm kernel)
In-Reply-To: <Pine.GSO.4.21.0407091720210.18072-100000@dirac.phys.uwm.edu>
Message-ID: <Pine.GSO.4.21.0407160151170.22617-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I am also working with Bruce Allen (smartmontools developer) to make
> > > the 3w-9xxx driver work with smartmontools.  This shouldn't require
> > > any driver changes.

<SNIP>

> I've now checked code into CVS for this, so smartmontools now can be used
> with 3ware/AMCC 9000 series controllers (3w-9xxx driver). Many thanks to
> Adam Radford for his help with this.

<SNIP>

> If you don't have the /dev/twa? devices on your system, please run the
> tw_cli or 3dmd tools once: this will automatically create the /dev/twa?
> nodes.

Minor update: for smartmontools to use the 3ware character device
interface it is no longer necessary to create /dev/tw[ae]? nodes 'by
hand'.  Smartmontools now does this dynamically, if needed.  Thanks again
to Adam Radford.

Bruce

