Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSFOWlI>; Sat, 15 Jun 2002 18:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSFOWlH>; Sat, 15 Jun 2002 18:41:07 -0400
Received: from moutvdom00.kundenserver.de ([195.20.224.149]:50264 "EHLO
	moutvdom00.kundenserver.de") by vger.kernel.org with ESMTP
	id <S315708AbSFOWlF>; Sat, 15 Jun 2002 18:41:05 -0400
Message-Id: <5.0.2.1.2.20020616003031.02a06330@pop.puretec.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Sun, 16 Jun 2002 00:40:50 +0200
To: Douglas Gilbert <dougg@torque.net>, Andries.Brouwer@cwi.nl
From: Sancho Dauskardt <sancho@dauskardt.de>
Subject: Re: /proc/scsi/map
Cc: garloff@suse.de, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net,
        linux1394-devel@lists.sourceforge.net
In-Reply-To: <3D0BBF4B.42E355A6@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>In lk 2.5 we are hoping that driverfs will give us an
>"information bridge" between scsi pseudo devices
>and other driver subsystems such as ide, usb and iee1394.
>Mike Sullivan's persistent naming patch (that I mentioned
>in my previous post on this thread) adds driverfs capability
>into the scsi subsystem. Driverfs capability is already
>in the ide and usb subsystems.
Driverfs will hopefully solve the problem, of "oh there's a SCSI device. 
how is it connected ?".

But to date, SCSI doesn't know about the GUID's, right ?
And without this, we won't get a uniform way of creating stable names for 
hot-plugable devices...

- sda

