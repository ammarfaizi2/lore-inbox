Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbUB0HhW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 02:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbUB0HhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 02:37:21 -0500
Received: from inventor.gentoo.org ([216.223.235.2]:640 "EHLO meep.gentoo.org")
	by vger.kernel.org with ESMTP id S261737AbUB0HhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 02:37:20 -0500
Subject: ieee1394 sbp2 broken since 2.6.0-test11
From: Daniel Robbins <drobbins@gentoo.org>
To: bcollins@debian.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Gentoo Technologies, Inc.
Message-Id: <1077867528.12590.79.camel@wave.gentoo.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 00:38:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben,

I've been having to use the ieee1394 driver from 2.6.0-test10 in order
to burn CDs reliably. With 2.6.0-test11 and beyond, I experience
intermittent login failures and then reconnect failures to my firewire
CD burners. With 2.6.3, even when the login or reconnect goes OK, the
system can hard-lock while burning. The CD burners are using Oxford 911
chips, firmware 3.6 and 3.8. I've tested using a variety of firewire PCI
cards and mainboards, both SMP (uniprocessor hyper-threading) and UP,
and a couple of different CD drives.

On the linux1394.org site, the Oxford 911 chip has a "works great"
rating, but it does not indicate what kernel(s) provide this "great"
functionality -- maybe this information could be added to the site?

What concerns me is that the ieee1394 drivers seem to be becoming less
and less reliable and compatible with every 2.6 kernel release. The
changes being made to the drivers may be fixing issues for some users,
but they are also breaking things for other (previously happy) firewire
users. 

It appears that more QA is needed to make sure that one person's fix
doesn't become someone else's "b0rk," as seems to be happening now.
Without organized testing on a wider range of hardware, new driver
releases will probably just be differently compatible rather than more
compatible.

I do not have time to assist with ieee1394 development, but will gladly
send you a variety of firewire parts so that you are able to test the
ieee1394 drivers on a wider range of hardware, with the goal of having
driver compatibility issues identified and fixed before they can impact
Linux users. I will also gladly assist with QA as needed. But ideally,
it's probably best if a ieee1394 developer is doing QA, since then when
problems are found they can be immediately debugged and fixed. LKML "my
firewire is busted" threads are a time-consuming and semi-unproductive
ordeal for everyone involved, I think.

I am very interested in Linux having excellent firewire support. I think
firewire is great. If you or any other capable developer wants to take
the time to test on a wider variety of hardware to help ensure that the
mainline ieee1394 driver is as solid and compatible as humanly possible,
I'll send the hardware.

Please (someone?) take me up on this offer.

Sincerly,

Daniel

