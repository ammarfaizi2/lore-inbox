Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317007AbSFKLpY>; Tue, 11 Jun 2002 07:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317008AbSFKLpX>; Tue, 11 Jun 2002 07:45:23 -0400
Received: from [195.20.224.249] ([195.20.224.249]:43781 "EHLO samoa.sitewaerts")
	by vger.kernel.org with ESMTP id <S317007AbSFKLpX>;
	Tue, 11 Jun 2002 07:45:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Felix Seeger <seeger@sitewaerts.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with ACPI or framebuffer (no output while startup)
Date: Tue, 11 Jun 2002 13:45:23 +0200
User-Agent: KMail/1.4.1
In-Reply-To: <200206111124.09320.seeger@sitewaerts.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206111345.23419.seeger@sitewaerts.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok it is ACPI.
I disabled Framebuffer and is was the same effect.

have fun
Felix


Am Dienstag, 11. Juni 2002 11:24 schrieb Felix Seeger:
> Hi
>
> I'm running 2.4.18-pre9
> I disabled APM, because I ACPI won't work with enabled APM.
> Maybe this is normal.
>
> Laptop: Sony vaio pcg-qr10
>
> I boot with frame buffer and vga=normal (fb doesn't work, no tux...)
> And now:
>
> tbxface-0099 [01] ACPI_load_tables : ACPI Tables successfully loaded
> Parsing Methods :...................
> 154 Control Methods found and parsed (479 nodes total)
> ACPI Namespave successfully loaded at root c02fd500
> ACPI: Core Subsystem version [20011018]
> evxfevnt-0081 [02] Acpi_enable : Transition to ACPI mode successful
> Executing device _INI methods: ............. (13 points)
>
> After that the output stops but the systems starts up, onyl the output...
>
> What is my problem ACPI or Frame Buffer. I've have VESA 2.0 and vga
> configured.
>
> Do I need special vag= options ?
> All options from the manual don't work, lilo takes only the default lilo
> options. (my lilo supports hex 0x things if you trust the manpage)
>
>
> thanks
> have fun
> Felix
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

