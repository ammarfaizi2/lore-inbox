Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWBGCND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWBGCND (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 21:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932441AbWBGCND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 21:13:03 -0500
Received: from pproxy.gmail.com ([64.233.166.177]:9566 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932440AbWBGCNB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 21:13:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Bl1cSkBYe/4PQia2CYGE/AgRIfpNi82YbGOvjxdu1khbkTeLlLmd+BZHt1cJLHhgWsPcMtlszexRExCuOuX4uP9pZURTR9/5PtwPcCNyx0oCJiRtqKcZEEracwdn51JuyrNs4y4AXob8T+idQh3om5dyPdJ1iBF7XtkBMxi9B70=
Message-ID: <964857280602061812m748d19bew5ef0777e24359029@mail.gmail.com>
Date: Tue, 7 Feb 2006 00:12:58 -0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <2@pervalidus.net>
To: Greg KH <greg@kroah.com>
Subject: Re: What causes "USB disconnect" ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <964857280602061706n72a9ebbeo9a1930f2b0993e0b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0602062122480.5326@dyndns.pervalidus.net>
	 <20060207002749.GA6774@kroah.com>
	 <964857280602061706n72a9ebbeo9a1930f2b0993e0b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/06, Frédéric L. W. Meunier wrote:
> When it happened, his lights turned off. I pressed a button, but
> nothing happened. Then, I ignored it and it returned after the minutes
> you see from the log.

It happened again. This, after an uptime of 3 days and a few hours.

Feb  6 23:59:00 pervalidus kernel: usb 1-2: USB disconnect, address 5
Feb  6 23:59:39 pervalidus kernel: usb 1-2: new low speed USB device
using uhci_hcd and address 6
Feb  6 23:59:40 pervalidus kernel: usb 1-2: configuration #1 chosen
from 1 choice
Feb  6 23:59:44 pervalidus kernel: input: Logitech Inc. WingMan
RumblePad as /class/input/input5
Feb  6 23:59:44 pervalidus kernel: input: USB HID v1.10 Joystick
[Logitech Inc. WingMan RumblePad] on usb-0000:00:10.0-2
Feb  6 23:59:44 pervalidus kernel: usb 1-2: USB disconnect, address 6
Feb  6 23:59:47 pervalidus kernel: usb 1-2: new low speed USB device
using uhci_hcd and address 7
Feb  6 23:59:47 pervalidus kernel: usb 1-2: configuration #1 chosen
from 1 choice
Feb  6 23:59:57 pervalidus kernel:
/usr/local/src/kernel/linux-2.6.16/drivers/usb/input/hid-core.c:
timeout initializing reports
Feb  6 23:59:57 pervalidus kernel: input: Logitech Inc. WingMan
RumblePad as /class/input/input6
Feb  6 23:59:57 pervalidus kernel: input: USB HID v1.10 Joystick
[Logitech Inc. WingMan RumblePad] on usb-0000:00:10.0-2

I changed it to other 2 ports and only see a

Feb  7 00:09:10 pervalidus kernel: usb 1-2: USB disconnect, address 7

Any way to know if this is the device's fault ?
