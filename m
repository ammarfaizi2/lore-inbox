Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbTHYK1U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 06:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbTHYK1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 06:27:20 -0400
Received: from D70ba.pppool.de ([80.184.112.186]:56235 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S261608AbTHYK1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 06:27:16 -0400
Subject: Re: How to use an USB<->serial adapter?
From: Daniel Egger <degger@fhm.edu>
To: Boszormenyi Zoltan <zboszor@freemail.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F49AB95.7090105@freemail.hu>
References: <3F44BEA2.8010108@freemail.hu> <1061507883.8723.45.camel@sonja>
	 <3F49AB95.7090105@freemail.hu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CEgygm6LM4St0LiJs3T9"
Message-Id: <1061806775.741.19.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 25 Aug 2003 12:19:36 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CEgygm6LM4St0LiJs3T9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mon, 2003-08-25 um 08.24 schrieb Boszormenyi Zoltan:

> What product is this? Mine is a Wiretek UN8BE, based on Prolific 2303.

Mine is from STLAB.

Bus 002 Device 003: ID 7b06:0323
  Language IDs: none (invalid length string descriptor 63; len=3D7)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB              10.01
  bDeviceClass            0 Interface
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x7b06
  idProduct          0x0323
  bcdDevice            2.02
  iManufacturer           0
  iProduct                0
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize         10
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
  Language IDs: none (invalid length string descriptor 63; len=3D7)

Hrm, lsusb seems to have an endianess problem, the vendorid is garbled.

> In the shop they said this one cannot be used as a null-link but works
> with external serial devices, e.g. modems. I have yet to verify this
> statement myself.

Doesn't really make sense to me. RS232 is specified electrically, the
adapter doesn't know which kind of device it is talking to. I'm using
mine to connect to a TTL-RS232 adapter which sits on a DSL-router, so
it's like a "null-link".

> I tried to query the USB serial line's current parameters.
> Is there any other utilities that can do this for me?

Why do you need this, don't you know what you set it to? :)
There are ioctls for it and probably a terminal program will know how to
read and write it.

--=20
Servus,
       Daniel

--=-CEgygm6LM4St0LiJs3T9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/SeK3chlzsq9KoIYRAt9yAJ4orDvNATg+P9ctG28w9OJWGBZCRwCfXlz3
fokgYbMxFZpKJp/KfVwij+4=
=PqXl
-----END PGP SIGNATURE-----

--=-CEgygm6LM4St0LiJs3T9--

