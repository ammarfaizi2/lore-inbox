Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSHLGkE>; Mon, 12 Aug 2002 02:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSHLGkE>; Mon, 12 Aug 2002 02:40:04 -0400
Received: from mta05ps.bigpond.com ([144.135.25.137]:29165 "EHLO
	mta05ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S315222AbSHLGkD>; Mon, 12 Aug 2002 02:40:03 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Carlos Laviola <carlos@laviola.org>, linux-kernel@vger.kernel.org
Subject: Re: Change in USB (HID?) from 2.4.18 to 2.4.19 breaks support for my Joystick
Date: Mon, 12 Aug 2002 16:38:38 +1000
User-Agent: KMail/1.4.5
References: <20020812063950.GA1247@laviola.org>
In-Reply-To: <20020812063950.GA1247@laviola.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200208121638.38570.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 12 Aug 2002 16:39, Carlos Laviola wrote:
> Hi,
>
> I've recently bought a generic Playstation + Nintendo 64 joystick
> adapter that connects to USB ports.  This joystick works fine on 2.4.18
> with the following modules only: usbcore, input, hid & usb-uhci.  On
> 2.4.19, all of the mentioned modules load like in 2.4.18, but I get a
> "no such device" when I try to test the joystick with jstest.  To be
> sure, I went to 2.4.20-pre1-ac1, and the joystick doesn't work with it
> too.
Did you copy the .config from your previous kernel to the new one, and NOT run 
"make oldconfig"?

If so, consider yourself repremanded, and turn on the CONFIG_USB_HIDINPUT 
option.

Brad
- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9V1fuW6pHgIdAuOMRAlvyAJoC49A/pXur5L0GqpJD5yZLQKIuTACdELQB
Glf3iJ/BXXXI8upkK+wCWpg=
=pWqJ
-----END PGP SIGNATURE-----

