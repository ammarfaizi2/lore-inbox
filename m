Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVGLHzD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVGLHzD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 03:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVGLHzD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 03:55:03 -0400
Received: from totor.bouissou.net ([82.67.27.165]:52379 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261246AbVGLHzB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 03:55:01 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Tue, 12 Jul 2005 09:54:59 +0200
User-Agent: KMail/1.7.2
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507112142420.7520-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.0507112142420.7520-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507120954.59522@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mardi 12 Juillet 2005 03:54, Alan Stern a écrit :
> > So the problem is circled to 2.6 kernel, uhci_hcd and UP IO-APIC.
>
> Don't rule out the hardware too quickly.  2.4 and 2.6 manage the UHCI
> controllers in different ways.

I saw ;-)

> In particular, the usb-uhci driver in 2.4 does not suspend the controller
> when no devices are attached, whereas uhci-hcd in 2.6 does.  (So does the
> "alternate" uhci driver in 2.4.)  [...]

> To try and help pin things down, tomorrow (i.e., Tuesday) I'll send you a
> test patch to completely disable the UHCI controllers, leaving them awake
> and idle, not generating interrupts.  If you still get those spurious
> IRQs, they will have to come from somewhere else.  (Assuming you can
> devote server time to this sort of testing...)

I'll try my best, although I will have little time for playing with this until 
the end of this week, and will be on travel next week. But if you send me a 
test patch, I'll try my best to test it.

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
