Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129952AbRBOUuC>; Thu, 15 Feb 2001 15:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129907AbRBOUtw>; Thu, 15 Feb 2001 15:49:52 -0500
Received: from quattro.sventech.com ([205.252.248.110]:35598 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S130085AbRBOUts>; Thu, 15 Feb 2001 15:49:48 -0500
Date: Thu, 15 Feb 2001 15:49:47 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: drizzt.dourden@iname.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [drizzt.dourden@iname.com: USB mass storage and USB message]
Message-ID: <20010215154946.M23514@sventech.com>
In-Reply-To: <20010215214330.B2094@menzoberrazan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <20010215214330.B2094@menzoberrazan>; from drizzt.dourden@iname.com on Thu, Feb 15, 2001 at 09:43:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2001, drizzt.dourden@iname.com <drizzt.dourden@iname.com> wrote:
>  I'm using the usb-uhci core with the 8200e storage drivers. I don't why
>  the kernel logs the next message:
>  
>  uhci.c: root-hub INT complete: port1: 495 port2: 58a data: 4
>  uhci.c: root-hub INT complete: port1: 495 port2: 58a data: 4
>  uhci.c: root-hub INT complete: port1: 495 port2: 58a data: 4
>  uhci.c: root-hub INT complete: port1: 495 port2: 58a data: 4
>  uhci.c: root-hub INT complete: port1: 495 port2: 58a data: 4
>  uhci.c: root-hub INT complete: port1: 495 port2: 58a data: 4
>  (well a lot of them)

If it says, uhci.c, then it would be uhci.o. If it says usb-uhci.c, then
it's usb-uhci.o. Your statement conflicts with the log you pasted. Which
one is it?

>  The kernel is 2.4.1, the hardware a Celeron 566 with a VIA chipset, with the
>  next cat /proc/pci
>  
>  This doesn't hapeng with the uhci module.
>  
>  I was testing  the cd writer with cdrecord at x1 speed( well, at least it can
>  finish th simulation, because with the pre series, it can finished).

Did you get an oops? Is the khubd process zombied?

JE

