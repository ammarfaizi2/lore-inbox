Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267266AbSKPLTP>; Sat, 16 Nov 2002 06:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267268AbSKPLTP>; Sat, 16 Nov 2002 06:19:15 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:57111
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267266AbSKPLTP>; Sat, 16 Nov 2002 06:19:15 -0500
Date: Sat, 16 Nov 2002 06:29:26 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Greg Kroah-Hartmann <greg@kroah.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH][2.5] USB core/config.c triggers slab bugcheck
In-Reply-To: <Pine.LNX.4.44.0211160452010.1810-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0211160627160.1810-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Nov 2002, Zwane Mwaikambo wrote:

> Greg does this look ok? My system boots now;
> 
> drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.0
> drivers/usb/core/hcd-pci.c: uhci-hcd @ 00:07.2, Intel Corp. 82371AB/EB/MB PIIX4 USB
> drivers/usb/core/hcd-pci.c: irq 10, io base 0000e000
> drivers/usb/core/hcd.c: new USB bus registered, assigned bus number 1
> drivers/usb/core/hub.c: USB hub found at 0
> drivers/usb/core/hub.c: 2 ports detected

Tested ok, OV511 works for me now with this patch only.

drivers/usb/core/hub.c: new USB device 00:07.2-1, assigned address 2
drivers/usb/media/ov511.c: USB OV511+ video device found
drivers/usb/media/ov511.c: model: Creative Labs WebCam 3
drivers/usb/media/ov511.c: Sensor is an OV7620
drivers/usb/media/ov511.c: Device registered on minor 0

	Zwane
-- 
function.linuxpower.ca

