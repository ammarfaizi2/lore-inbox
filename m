Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316616AbSEUUp1>; Tue, 21 May 2002 16:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316619AbSEUUpY>; Tue, 21 May 2002 16:45:24 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:24213 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S316616AbSEUUou>; Tue, 21 May 2002 16:44:50 -0400
Message-Id: <5.1.0.14.2.20020521133408.068d2ef8@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 21 May 2002 13:43:41 -0700
To: Greg KH <greg@kroah.com>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: What to do with all of the USB UHCI drivers in the kernel ?
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20020521195925.GA2623@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > So basically I vote for usb-uhci. However some things will have to be
> > fixed. We (Bluetooth folks) have couple
> > of devices that refuse to work with usb-uhci (I didn't test the latest
> > usb-uhci though).
>
>Sorry for the confusion, but both usb-uhci.c and uhci.c will be deleted 
>anyway :)
I thought that usb-uhci-hcd and uhci-hcd are direct derivatives of usb-uhci 
and uhci
(ie just minor API changes). And therefor perform exactly the same.

>I am more interested in usb-uhci-hcd.c and uhci-hcd.c drivers, which both
>showed up in 2.5.16.  Yes they are based on the previous usb-uhci.c and
>uhci.c drivers respectivly, but they are a bit different (they use the
>hcd core code which reduces the size of the driver.)
I see. Ok. I'll try 2.5.17 on one of my machines with UHCI controller.

>You also might want to check out uhci.c again in 2.4.19-pre.  It has had
>a lot of previous bugs fixed and works _much_ better for me than before.
Ok.

Thanks
Max

