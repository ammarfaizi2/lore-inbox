Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbTECQIH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 12:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263339AbTECQIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 12:08:07 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50334
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263338AbTECQIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 12:08:06 -0400
Subject: Re: centrino
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeffrey Baker <jwbaker@acm.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030502183222.GA30189@heat>
References: <20030502183222.GA30189@heat>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051975317.24563.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 May 2003 16:21:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Power management didn't work at all because ACPI is a sick
> joke.  In 2.4 ACPI does nothing, and in 2.5.68 it can put
> the machine to sleep, but not wake it up.  APM could almost
> wake the system from sleep, but then it crashed immediately.
> ACPI incorrectly reports the state of the system fans, the
> battery, the battery charger, and the temperature sensor.
> In other words, no part of it functions correctly .  This is
> either a problem with Centrino chipset in general or Acer
> BIOS programming in particular.

For some people centrino seems to work a little better so it may
be BIOS bugs too. The usual "buy something 6 months old" rule applies
to BIOS code as well as anything else

> CPU frequency scaling didn't work in either kernel but there
> seem to be rumbles of reverse engineering going on with
> that.

Intel are still being a pain about this. Quite why they think its
a secret is beyond me. Fortunately every other CPU vendor is being a 
lot more positive.

> The wireless doesn't work in any kernel, and Intel have
> stated specifically on their web site that they have no
> plans for any future Linux driver for that device.

There are awkward issues there certainly.

> The Centrino package is altogether hostile to Linux.

Time may change that. The ATI/ALi chipset AMD laptops like the Compaq
z9xx were really Linux hostile. Now with the right stuff in place and
some things fixed (some working around their bugs, some fixing ours)
they work really well.

Centrino ultimately is a help - the laptop chipset space is
consolidating and there are less and less variations appearing. That
helps us because there is less to support. Its the same as with X and
IDE and other things nowdays - we get a lot less deeply weird hardware
to fight.

