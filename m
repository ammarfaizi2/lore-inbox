Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265863AbUFDQS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265863AbUFDQS6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 12:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUFDQS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 12:18:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:34271 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265871AbUFDQRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 12:17:42 -0400
Subject: Re: 2.6.7-rc2: no more AGP?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
Cc: Michel <daenzer@debian.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040604174818.03a4f795@jack.colino.net>
References: <20040604174818.03a4f795@jack.colino.net>
Content-Type: text/plain
Message-Id: <1086365839.12665.0.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 04 Jun 2004 11:17:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-04 at 10:48, Colin Leroy wrote:
> Hi,
> 
> just a lousy bugreport... I noticed that agpgart doesn't work anymore on
> 2.6.7-rc2. Xorg reports that AGP isn't supported, and dmesg doesn't show
> the
> agpgart: Putting AGP V2 device at 0000:00:0b.0 into 4x mode
> agpgart: Putting AGP V2 device at 0000:00:10.0 into 4x mode
> 
> It only shows
> Linux agpgart interface v0.100 (c) Dave Jones
> agpgart: Detected Apple UniNorth 2 chipset
> agpgart: Maximum main memory to use for agp memory: 565M
> agpgart: configuring for size idx: 4
> agpgart: AGP aperture is 16M @ 0x0

Right, something seems broken. I'm also having problems with USB
sleep & wakeup and with cpufreq. Argh, I've been away from ppc32 for
too long !

I'll try to spare some time this week-end. It might be too late for
2.6.7 though =P

Ben.


