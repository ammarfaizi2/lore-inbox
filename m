Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314396AbSHGW0X>; Wed, 7 Aug 2002 18:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314403AbSHGW0X>; Wed, 7 Aug 2002 18:26:23 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:53205 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S314396AbSHGW0W>; Wed, 7 Aug 2002 18:26:22 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Oliver Feiler <kiza@gmx.net>, Greg KH <greg@kroah.com>
Subject: Re: 2.4.19, USB_HID only works compiled in, not as module
Date: Thu, 8 Aug 2002 08:24:49 +1000
User-Agent: KMail/1.4.5
Cc: Tyler Longren <tyler@captainjack.com>, LKML <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz
References: <20020805003427.7e7fc9f4.tyler@captainjack.com> <200208060702.29360.bhards@bigpond.net.au> <200208071250.44353.kiza@gmx.net>
In-Reply-To: <200208071250.44353.kiza@gmx.net>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200208080824.49553.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 7 Aug 2002 20:50, Oliver Feiler wrote:
> Hello all,
>
> I have another addition to this thread. I found the same problem happening
> to my analog joystick. It's connected with a SBLive gameport. Compiling the
> driver into the kernel (or using 2.4.18 with the driver as module) gives:
<snip>
> So maybe the hid mouse problem is not withing the USB code, but somewhere
> else?
Maybe input layer changes.

Can you send the CONFIG_USB and CONFIG_INPUT entries for a working
case and a non-working case?

- -- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9UZ4xW6pHgIdAuOMRAgFOAKCSI1qYFnkmZCsMvI5aitWBEd0TnwCbBXnv
gDvtFhjclPF3DwGllA6L7zQ=
=3taw
-----END PGP SIGNATURE-----

