Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263598AbUAYCDn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 21:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUAYCDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 21:03:43 -0500
Received: from pcp03435692pcs.olathe01.ks.comcast.net ([68.86.102.188]:17318
	"EHLO mail.2thebatcave.com") by vger.kernel.org with ESMTP
	id S263598AbUAYCDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 21:03:41 -0500
Message-ID: <57099.192.168.1.12.1074996225.squirrel@mail.2thebatcave.com>
Date: Sat, 24 Jan 2004 20:03:45 -0600 (CST)
Subject: acpi - forcing only button event & powerdown on?
From: "Nick Bartos" <spam99@2thebatcave.com>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a little linux distro I made that I use for a fair amount of
routers/servers.  They use several different motherboards, and it seems to
me that in every recent release, the acpi in the kernel fixes support for
one board while breaking another.

I have tried forcing acpi on before, but I really don't like to do that as
I am thinking it would have side effects (one of the boards is on a
blacklist for acpi=ht, and when I do acpi=force it says that I am
overriding acpi=ht).

Really all I use on all of these systems is the acpi button event (for a
nice way to cleanly shutdown a headless router/server by tapping the power
button), and the acpi powerdown feature.  I would think these two features
are simple enough that forcing them on wouldn't cause any problems like
system instability, even if there were hardware issues with them (but then
I really don't know anything about acpi...).

Is there a way to force acpi on, but only for the couple of things I need
(disabling the rest if it is a good idea), so I don't get into trouble
later?

I don't care too much for the idea of making a distro where I am bypassing
kernel autodection on things (as it is most likely done a certain way for
a reason, and I am no kernel developer), but I would like to be assured
that when I upgrade these machines, the two functions I use will continue
to work.

Am I asking too much or is this doable?

