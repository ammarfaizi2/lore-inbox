Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSHRMtE>; Sun, 18 Aug 2002 08:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSHRMtE>; Sun, 18 Aug 2002 08:49:04 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:22912 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314634AbSHRMtE>;
	Sun, 18 Aug 2002 08:49:04 -0400
Date: Sun, 18 Aug 2002 14:52:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Oliver Feiler <kiza@gmxpro.net>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Subject: Re: 2.4.19, USB_HID only works compiled in, not as module
Message-ID: <20020818145247.B263@ucw.cz>
References: <fa.egf7e0v.kk5a2@ifi.uio.no> <60bc.3d4d4347.5dd06@trespassersw.daria.co.uk> <200208041746.56274.kiza@gmxpro.net> <200208050751.40894.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200208050751.40894.bhards@bigpond.net.au>; from bhards@bigpond.net.au on Mon, Aug 05, 2002 at 07:51:34AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2002 at 07:51:34AM +1000, Brad Hards wrote:

> Hash: SHA1
> 
> On Mon, 5 Aug 2002 01:46, Oliver Feiler wrote:
> > Hm, seems so. The relevant options I used are:
> >
> > CONFIG_INPUT=y
> > # CONFIG_INPUT_KEYBDEV is not set
> > CONFIG_INPUT_MOUSEDEV=m
> > CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> > CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> > CONFIG_INPUT_JOYDEV=y
> > CONFIG_INPUT_EVDEV=m
> >
> > CONFIG_USB=y
> > CONFIG_USB_DEVICEFS=y
> > CONFIG_USB_UHCI=y
> > CONFIG_USB_HID=m
> > CONFIG_USB_HIDINPUT=y
> What other USB options do you have turned on?
> 
> What modules do you have loaded?
> 
> Vojtech: We need that /proc support for input
> to help with problems like this. Any chance of merging
> it in 2.4.20-pre?

I'll try.

-- 
Vojtech Pavlik
SuSE Labs
