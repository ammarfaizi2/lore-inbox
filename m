Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278352AbRJMSh0>; Sat, 13 Oct 2001 14:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278353AbRJMShQ>; Sat, 13 Oct 2001 14:37:16 -0400
Received: from webcon.net ([216.187.106.140]:54671 "EHLO webcon.net")
	by vger.kernel.org with ESMTP id <S278352AbRJMShI>;
	Sat, 13 Oct 2001 14:37:08 -0400
Date: Sat, 13 Oct 2001 14:37:31 -0400 (EDT)
From: Ian Morgan <imorgan@webcon.net>
To: Ryan Butler <rbutler@adiis.net>
cc: Mark Hahn <hahn@physics.mcmaster.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: System won't reboot from Linux?
In-Reply-To: <1002992168.14465.2.camel@hoi-dsl-cust33.adiis.net>
Message-ID: <Pine.LNX.4.40.0110131400070.9890-100000@light.webcon.net>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Oct 2001, Ryan Butler wrote:
>
> Please have a look at the kernel thread dealing with Compaq 16xx and
> APM.
>
> This sounds like the same problem, but I'd like your thoughts on the
> thread and whether it applies to other laptops than just compaq.

Well, it did remind me about the "use real-mode to reboot" option, which I
had tried in the past, but not recently. I built up 2.4.12, and tried it
both with and without that option, as well as in combination with various
reboot= paramenters, but still no go, with or without apm.o loaded. I also
tried enabling "allow interrupts during apm calls", with no success.

Enabling output in dmi_scan.c reveals:

DMI 2.3 present.
62 structures occupying 1945 bytes.
DMI table at 0x000DC010.
BIOS Vendor: Phoenix
BIOS Version: 4.06CJ15
BIOS Release: 08/15/2001
System Vendor: sag168168.
Product Name: Apollo Pro133AX.
Version 8500V.
Serial Number .
Board Vendor: VIA.
Board Name: 694x686a.
Board Version: None.
Asset Tag: No Asset Tag.


Regards,
Ian Morgan
-- 
-------------------------------------------------------------------
 Ian E. Morgan        Vice President & C.O.O.         Webcon, Inc.
 imorgan@webcon.net         PGP: #2DA40D07          www.webcon.net
-------------------------------------------------------------------

