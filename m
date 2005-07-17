Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVGQVvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVGQVvM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 17:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVGQVvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 17:51:12 -0400
Received: from totor.bouissou.net ([82.67.27.165]:50594 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261313AbVGQVvK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 17:51:10 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: VIA KT400 + Kernel 2.6.12 + IO-APIC + uhci_hcd = IRQ trouble
Date: Sun, 17 Jul 2005 23:51:06 +0200
User-Agent: KMail/1.7.2
Cc: bjorn.helgaas@hp.com,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507171606320.30920-100000@netrider.rowland.org> <200507172320.26156@totor.bouissou.net>
In-Reply-To: <200507172320.26156@totor.bouissou.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200507172351.06569@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Dimanche 17 Juillet 2005 23:20, Michel Bouissou a écrit :
>
> I just tried an USB flashdisk that "used to work good with 2.4" and that I
> hadn't tried yet in 2.6. It's identified as "high speed" and ehci would
> like to manage it, but it seems I'm out of luck in some other aspect:
>
> totor kernel: usb 4-4: new high speed USB device using ehci_hcd and address
> 25 totor kernel: usb 4-4: device not accepting address 25, error -71
> totor kernel: usb 4-4: new high speed USB device using ehci_hcd and address
> 35 totor kernel: usb 4-4: device not accepting address 35, error -71
[...]
> ...ad nauseam until I unplug the key...
[...]
> Doesn't like the front panel socket ? Let me try another USB socket... Just
> close to my mouse...
>
> totor kernel: usb 4-2: new high speed USB device using ehci_hcd and address
> 16 totor kernel: SCSI subsystem initialized
> totor kernel: Initializing USB Mass Storage driver...

By the way, the front socket that dislikes the USB 2.0 flashdisk (ehci) feels 
perfectly happy if I plug and USB 1.1 flashdisk (uhci)... Feels good also if 
I plug my Digital Camera there... And I've plugged it there thousands of 
times.

Some posts I googled about this kind of errors tend to indicate this would be 
an IRQ mess ;-))

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E
