Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbTEMQZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTEMQZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:25:08 -0400
Received: from MailBox.iNES.RO ([80.86.96.21]:51649 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id S261544AbTEMQZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:25:06 -0400
Date: Tue, 13 May 2003 19:37:46 +0300 (EEST)
From: Andrei Ivanov <andrei.ivanov@ines.ro>
X-X-Sender: shadow@webdev.ines.ro
To: Stian Jordet <liste@jordet.nu>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 712] New: USB device not accepting new address.
In-Reply-To: <1052842466.20418.0.camel@chevrolet.hybel>
Message-ID: <Pine.LNX.4.50L0.0305131936010.4725-100000@webdev.ines.ro>
References: <24740000.1052833661@[10.10.2.4]> <1052842466.20418.0.camel@chevrolet.hybel>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (MailBox.iNES.RO)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The messages are almost, if not identical to what I get, and my USB mouse
works only if I replug it. I tried it with or without ACPI, with or
without local apic, and it didn't work. Last time it worked was in
2.5.68-mm3... 

See: http://marc.theaimsgroup.com/?l=linux-kernel&m=105221493201587&w=2

On Tue, 13 May 2003, Stian Jordet wrote:

> > unplugging, and replugging the camera does this...
> > 
> > hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
> > hub 1-0:0: new USB device on port 2, assigned address 4
> > usb 1-2: USB device not accepting new address=4 (error=-110)
> > hub 1-0:0: new USB device on port 2, assigned address 5
> > usb 1-2: USB device not accepting new address=5 (error=-110)
> > 
> > This worked up until very recently. (Maybe even in 2.5.69)
> 
> ACPI enabled? If so, I bet it works without acpi. If not, I'm sorry
> about the noise.
> 
> Best regards,
> Stian
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
