Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286993AbSAGUcV>; Mon, 7 Jan 2002 15:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286841AbSAGUcI>; Mon, 7 Jan 2002 15:32:08 -0500
Received: from daytona.gci.com ([205.140.80.57]:27657 "EHLO daytona.gci.com")
	by vger.kernel.org with ESMTP id <S286993AbSAGUbj>;
	Mon, 7 Jan 2002 15:31:39 -0500
Message-ID: <BF9651D8732ED311A61D00105A9CA31506DB462C@berkeley.gci.com>
From: Leif Sawyer <lsawyer@gci.com>
To: esr@thyrsus.com, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: RE: CML2-2.0.0 is available -- major release announcement
Date: Mon, 7 Jan 2002 11:31:25 -0900 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond [esr@thyrsus.com] writes:
> Subject: CML2-2.0.3 is available

Just some feedback on 2.0.3 running against 2.5.2-pre9 on my i686.


installed, ran as 
	make autoprobe config


picked up my processor/mobo/options, rtc, network, video, sound correctly.

picked up ISA/PCI/AGP right.

Picked USB HCI's as modular (building all) from VIA motherboard.
	(Don't really need the OHCI built here)

picked up file systems, framebuffer, network rules, block devices right.

picked up SCSI, Input, game ports and serial ports correctly.

Missed HOTPLUG (based on USB, and configure_help - this may just be cleanup
			in the help text to remove references to USB if
hotplug
			is not needed/required)

Missed APM support (is enabled in running kernel)

Missed my parallel port.
Missed SCSI_Generic
Missed my floppy drive!
Missed Unix Domain Sockets!
Missed Packet Socket (based on running kernel)
Missed PS/2 mouse



Other than those above, it seems pretty good.

thanks!
Leif
