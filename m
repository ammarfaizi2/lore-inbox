Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272102AbRHVTZY>; Wed, 22 Aug 2001 15:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272098AbRHVTZO>; Wed, 22 Aug 2001 15:25:14 -0400
Received: from smtp8.xs4all.nl ([194.109.127.134]:5602 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S272100AbRHVTZC>;
	Wed, 22 Aug 2001 15:25:02 -0400
From: thunder7@xs4all.nl
Date: Wed, 22 Aug 2001 21:25:05 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: (lkml)Re: Linux 2.4.8-ac9
Message-ID: <20010822212505.A2732@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <20010822124856.A5395@lightning.swansea.linux.org.uk> <3B84014C.6DFEA362@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B84014C.6DFEA362@delusion.de>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2001 at 09:00:28PM +0200, Udo A. Steinberg wrote:
> Alan Cox wrote:
> > 2.4.8-ac9
> > o       Possible usb -110 error fix                     (me)
> 
> It's still broken.
> 
usb.c: registered new driver hub
uhci.c: USB UHCI at I/O 0xa000, IRQ 19
usb.c: new USB bus registered, assigned bus number 1
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=1 (error=-110)
uhci.c: USB UHCI at I/O 0xa400, IRQ 19
usb.c: new USB bus registered, assigned bus number 2
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address=1 (error=-110)
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.

Yup, I see that too. This is an Abit VP6 SMP Intel box.

Jurriaan
