Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTK1SMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 13:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTK1SMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 13:12:15 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:34211 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263185AbTK1SMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 13:12:14 -0500
Date: Fri, 28 Nov 2003 12:59:51 -0500
From: Ben Collins <bcollins@debian.org>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test11: sbp2 trouble
Message-ID: <20031128175950.GC1844@phunnypharm.org>
References: <1070036586.8571.15.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1070036586.8571.15.camel@paragon.slim>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 28, 2003 at 05:23:06PM +0100, Jurgen Kramer wrote:
> I am experiencing sbp2 problems With the current test11. Somehow
> it keeps telling me that it has problems logging in to one of my
> external sbp2 devices.
> 
> ieee1394: sbp2: Error logging into SBP-2 device - login timed-out
> 
> This is even after I do a power cycle on the failing device.
> 
> I have two IEEE1394 interface in my system. One is a onboard VIA
> controller the other one is on a Audigy2 card.
> 
> ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
> ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[20]  MMIO=[feaff800-feafffff]  Max
> Packet=[2048]
> ohci1394_1: OHCI-1394 1.1 (PCI): IRQ=[20]  MMIO=[feaff000-feaff7ff]  Max
> Packet=[2048]
> 
> The SBP2 module only seems to be able to log in to the device connected
> to the Audigy2 firewire controller. The kernel is compiled with SMP
> enabled.

Can you do a ps and show me what the two knodemgrd's look like?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
