Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030412AbVKIDC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030412AbVKIDC1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 22:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030413AbVKIDC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 22:02:27 -0500
Received: from pop-sarus.atl.sa.earthlink.net ([207.69.195.72]:21238 "EHLO
	pop-sarus.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1030412AbVKIDC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 22:02:26 -0500
From: John Mock <kd6pag@qsl.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14: advansys & zd1201 on PowerMac 8500/G3 [and VAIO laptop]
Message-Id: <E1EZgDy-0002zI-K4@penngrove.fdns.net>
Date: Tue, 08 Nov 2005 19:02:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Summary of previous post: 'advansys' driver started working on PowerMac 
8500/G3 with 2.6.14 but ZD1201 wireless USB dongle seems to hang.]

> PowerMac 8500 is an old fragile beast. Especially with a G3 processor
> hooked on it. The venerable Apple Bandit PCI bridge can have some
> "issues" every now and then with trivial things like ... cache coherency
> (ugh !). It tends to hit things like USB pretty badly. I can't guarantee
> for sure that's the cause of your problem, but it's possible...

I'm now skeptical that the problem is specific to the PowerMac 8500/G3,
as i've seen the ZD1201 wireless driver hang more than once after a similar
amount of elapsed time on a Sony VAIO R505 laptop.  So it might not be a 
PPC issue, Ben.

I'm now involving in trying to regress this thing, to see what might
have made the Advansys driver start working and when the ZD1201 driver
started hanging.  (I might find out about the MESH complaints in the
process.)  I think i've seen the 2.6.13 ZD1201 driver hang on the G3 and
still need to see if that also happens on my i386 laptop.  It can take
hours for this to happen, so chasing this down may take awhile.

				-- JM
