Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318243AbSHDVxD>; Sun, 4 Aug 2002 17:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318248AbSHDVxD>; Sun, 4 Aug 2002 17:53:03 -0400
Received: from mta03bw.bigpond.com ([139.134.6.86]:18371 "EHLO
	mta03bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S318243AbSHDVxB>; Sun, 4 Aug 2002 17:53:01 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Oliver Feiler <kiza@gmxpro.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19, USB_HID only works compiled in, not as module
Date: Mon, 5 Aug 2002 07:51:34 +1000
User-Agent: KMail/1.4.5
References: <fa.egf7e0v.kk5a2@ifi.uio.no> <60bc.3d4d4347.5dd06@trespassersw.daria.co.uk> <200208041746.56274.kiza@gmxpro.net>
In-Reply-To: <200208041746.56274.kiza@gmxpro.net>
Cc: vojtech@suse.cz
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200208050751.40894.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 5 Aug 2002 01:46, Oliver Feiler wrote:
> Hm, seems so. The relevant options I used are:
>
> CONFIG_INPUT=y
> # CONFIG_INPUT_KEYBDEV is not set
> CONFIG_INPUT_MOUSEDEV=m
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=y
> CONFIG_INPUT_EVDEV=m
>
> CONFIG_USB=y
> CONFIG_USB_DEVICEFS=y
> CONFIG_USB_UHCI=y
> CONFIG_USB_HID=m
> CONFIG_USB_HIDINPUT=y
What other USB options do you have turned on?

What modules do you have loaded?

Vojtech: We need that /proc support for input
to help with problems like this. Any chance of merging
it in 2.4.20-pre?

Brad

- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9TaHrW6pHgIdAuOMRAkkCAJ0TzvchKInmffKrFU38KUk9k9wD/ACbBKN6
MLPKbd8Gj5ld/XFFrdfEkZU=
=i/LO
-----END PGP SIGNATURE-----

