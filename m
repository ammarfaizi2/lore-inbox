Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293071AbSCJPhv>; Sun, 10 Mar 2002 10:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293073AbSCJPhl>; Sun, 10 Mar 2002 10:37:41 -0500
Received: from [212.18.235.99] ([212.18.235.99]:26374 "EHLO street-vision.com")
	by vger.kernel.org with ESMTP id <S293071AbSCJPh3>;
	Sun, 10 Mar 2002 10:37:29 -0500
From: Justin Cormack <kernel@street-vision.com>
Message-Id: <200203101537.g2AFbQU01620@street-vision.com>
Subject: Re: ACPI hangs on boot with K7SEM MoBo and Adaptec SCSI card
To: pekon@informatics.muni.cz (Petr Konecny)
Date: Sun, 10 Mar 2002 15:37:25 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <qww3czaldc2.fsf@decibel.fi.muni.cz> from "Petr Konecny" at Mar 09, 2002 02:49:49 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed yesterday that there is something wrong with acpi on this
board, which I had running. However it didnt list an irq for the serial
when acpi was enabled, and running with a serial console it hung when
acpi tunred on (with no messages to the serial console, unhelpfully). The
same is probably happening with the scsi card. Havent looked into why.

You can get temperatures with lm_sensors. I think the module is it87 if I
remember correctly.

> 
> Hi,
> 
> I just got ECS K7SEM motherboard. ACPI power saving is enabled in BIOS
> and works in linux (at least halt turns the box off). However when I
> plug in Adaptec SCSI (2940AU) the machine hangs during boot after
> loading ACPI core subsystem. The last message is:
> ACPI: core subsystem version [20011018]
> 
> I have 2.4.19-pre2-ac3 with both ACPI and APM compiled in.  I am booting
> with apm=off (otherwise acpi does not load).
> 
> It's not really critical, since apm works too. I just thought I would
> have access to all the acpi goodies like temperature of the CPU.
> 
>                                                 Take care, Petr
> -- 
> No chinese, no fortune.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

