Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271395AbTG2Lue (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 07:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271402AbTG2Lue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 07:50:34 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:994 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S271395AbTG2Lud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 07:50:33 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: "Roland Dreier" <roland@topspin.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: DMA not supported with Intel ICH4 I/O controller?
Date: Tue, 29 Jul 2003 08:01:53 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGKEKNCDAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <52brvegyrf.fsf@topspin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland,

Thanks for your response!

>It sounds like your board is acting as a PCI bus master.  This is
>completely different from DMA for the IDE controller.  External PCI

That's correct, we are a PCI bus master device.

>The BIOS on the P4PE may be setting
>your device up differently from the 815E motherboard.  Your device
>might be confusing the BIOS on the P4PE so that the IRQ routing
>information (eg in ACPI tables) is screwed up.  And so on.

With respect to the IRQ routing:  If the routing was messed up, wouldn't
this mean that no IRQs would get through on that device?  We are getting
some . . .

>However, I have not heard of any generic problems with external PCI
>bus masters and the ICH4.

. . . thanks for the feedback.

Regards,
Kathy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

