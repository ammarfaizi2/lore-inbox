Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbTIBXbS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 19:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTIBXbS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 19:31:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:61842 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261278AbTIBXbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 19:31:17 -0400
Date: Tue, 2 Sep 2003 16:28:32 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Michael Frank <mhf@linuxmail.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test4: Tested the Power Management Update
In-Reply-To: <200308311027.08779.mhf@linuxmail.org>
Message-ID: <Pine.LNX.4.33.0309021625310.9537-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 3) NEW: ACPI alarm function has new problem:
> 
> echo > /proc/acpi/alarm often (not always) causes:

Heh. You can see my first attempts at kernel code there. I haven't tested
it in ages, and could probably use a cleaning up. I'll look into this.

> 4) UNCHANGED: Alarm wakeup from S3 powers up and hangs.

Noted. Will try it also. 

> 5) MAJOR UNCHANGED: (ACPI routed) PCI interrupt links still stay dead 
> on S3 resume as their state was lost upon powerdown of the router and 
> on resume USB, Network and PCMCIA/Yenta are dead.
> 
> I had posted a patch earlier to set all links again in ACPI prior to 
> resuming devices, Russell said it was discussed at OLS, what will be 
> done about it?

Sorry, I completely forgot about this. Would you please send me the patch 
again? It's ok if it's old and doesn't apply. We'll get it worked out and 
fixed. 

> 6) MINOR UNCHANGED: As to the mouse, i8042 does not resume, so I 
> config i8042 as a module and reload it on resume. However, current 
> drivers/input/serio/Kconfig makes this impossible, which I whined 
> about a few times already ;)

I presume by your later message you got this worked out ok? 

Thanks for testing,


	Pat

