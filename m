Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262761AbVGKVfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262761AbVGKVfH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 17:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbVGKVew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 17:34:52 -0400
Received: from totor.bouissou.net ([82.67.27.165]:7859 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S262761AbVGKVef
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 17:34:35 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [SOLVED ??] Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Mon, 11 Jul 2005 23:34:30 +0200
User-Agent: KMail/1.7.2
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507111713320.14116-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0507111713320.14116-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507112334.30680@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Lundi 11 Juillet 2005 23:21, Alan Stern a écrit :
> Don't jump to hasty conclusions.  Problems like this are often caused by
> unrelated things that you wouldn't suspect at first.

I know... Been working with computers for... Uh... 25 years ?

> Getting something to work once doesn't mean the problem has been fixed.

That's so sadly right ;-)

> And you can be fooled by coincidences.  (I would be surprised if that event
> above was really caused by plugging in the scanner, unless your UHCI
> hardware is broken.) 

I don't believe the hardware is broken, as it's been running for more than 2 
years 100% stable with a 24/7/365 uptime. And with me plugging and unplugging 
USB devices...

Never had a single problem of the kind with any 2.4.x kernel. Get those 
problems only with 2.6.x kernels, and, in 2.6.12, only when UP IO-APIC is 
enabled (which ran perfectly good in 2.4).

So the problem is circled to 2.6 kernel, uhci_hcd and UP IO-APIC.

> One thing you might try, time-consuming though it will be, is to remove or
> disable as much hardware as possible from your system.  If you can
> reliably determine that the problem occurs only when one particular piece
> of hardware is enabled, then you'll know how to proceed.

I can hardly remove my VIA chipset from the mobo, and the USB thing is in the 
VIA thing ;-))

And I'm afraid I won't have the time to play that much with hardware, besides 
the fact that this is supposed to be a server which usually has uptimes over 
90 days rather than reboot-for-testing-the-damn-kernel-once-again ;-))

But I'm pretty sure this is no hardware problem, unless 2.6 considers "bad 
hardware" what 2.4 used to consider "nice hardware"...

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
