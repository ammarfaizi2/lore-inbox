Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316968AbSFKJYL>; Tue, 11 Jun 2002 05:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316970AbSFKJYK>; Tue, 11 Jun 2002 05:24:10 -0400
Received: from [195.20.224.249] ([195.20.224.249]:1040 "EHLO samoa.sitewaerts")
	by vger.kernel.org with ESMTP id <S316968AbSFKJYJ>;
	Tue, 11 Jun 2002 05:24:09 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Felix Seeger <seeger@sitewaerts.de>
Organization: <sitewaerts> GmbH
To: linux-kernel@vger.kernel.org
Subject: Problem with ACPI or framebuffer (no output while startup)
Date: Tue, 11 Jun 2002 11:24:09 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200206111124.09320.seeger@sitewaerts.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm running 2.4.18-pre9
I disabled APM, because I ACPI won't work with enabled APM.
Maybe this is normal.

Laptop: Sony vaio pcg-qr10

I boot with frame buffer and vga=normal (fb doesn't work, no tux...)
And now:

tbxface-0099 [01] ACPI_load_tables : ACPI Tables successfully loaded
Parsing Methods :...................
154 Control Methods found and parsed (479 nodes total)
ACPI Namespave successfully loaded at root c02fd500
ACPI: Core Subsystem version [20011018]
evxfevnt-0081 [02] Acpi_enable : Transition to ACPI mode successful
Executing device _INI methods: ............. (13 points)

After that the output stops but the systems starts up, onyl the output...

What is my problem ACPI or Frame Buffer. I've have VESA 2.0 and vga 
configured.

Do I need special vag= options ?
All options from the manual don't work, lilo takes only the default lilo 
options. (my lilo supports hex 0x things if you trust the manpage)


thanks
have fun
Felix
