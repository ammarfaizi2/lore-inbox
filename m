Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265027AbSJPP2k>; Wed, 16 Oct 2002 11:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265033AbSJPP2j>; Wed, 16 Oct 2002 11:28:39 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:33157 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP
	id <S265027AbSJPP2j>; Wed, 16 Oct 2002 11:28:39 -0400
Message-Id: <200210161534.g9GFY0508740@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: linux-kernel
To: Joseph Wenninger <jowenn@kde.org>
cc: linux-kernel@vger.kernel.org, robn@verdi.et.tudelft.nl
Subject: Re: usb CF reader and 2.4.19 
In-Reply-To: Message from Joseph Wenninger <jowenn@kde.org> 
   of "16 Oct 2002 11:22:04 +0200." <1034760128.1306.4.camel@jowennmobile> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Wed, 16 Oct 2002 17:34:00 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Joseph,

You don't mention what USB device you are using with your compact flash.
I don't have any problems with a "SanDisk Imagemate, SDDR-31" USB
CF reader: works flawlessly.

I'm using a up-to-date Red Hat 7.3 system with Red Hat kernel 2.4.18-10.
Maybe the driver(s) for your USB and/or cardreader are buggy.

	greetings,
	Rob van Nieuwkerk

PS: before chosing the SDDR-31 I did some extensive web-research on the
    USB/CF readers available with Linux.  I chose the SDDR-31 (which
    can be a bit hard to get nowadays) because it seemed the device
    with the least (Linux) problems.

> Is there anything I can do to flush all usb / usb storage buffers to my
> compact flash ? 
> 
> At the moment I have to rmmod usb-storage && rmmod usb-uhci && modprobe
> usb-uhci && modprobe usb-storage to ensure all data is written
> correctly, otherwise the directory structure isn't saved even after an
> unmount.
> 
> Is there an application, function call, ioctl, .... which I can use,
> instead of the above mentioned inconvenient way ?
> 
> Kind regards
> Joseph Wenninger
