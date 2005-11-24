Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030481AbVKXEIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbVKXEIt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 23:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030591AbVKXEIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 23:08:49 -0500
Received: from carbon.nocdirect.com ([69.73.156.63]:50818 "EHLO
	carbon.nocdirect.com") by vger.kernel.org with ESMTP
	id S1030481AbVKXEIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 23:08:49 -0500
Message-ID: <43853CC0.10203@ipom.com>
Date: Wed, 23 Nov 2005 20:08:32 -0800
From: Phil Dibowitz <phil@ipom.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
CC: Alan Stern <stern@rowland.harvard.edu>,
       usb-storage@lists.one-eyed-alien.net, Bob Copeland <me@bobcopeland.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [usb-storage] Re: [PATCH] usb-storage: Add support for Rio Karma
References: <20051123113342.GA5815@hash.localnet>	<Pine.LNX.4.44L0.0511231316410.12957-100000@iolanthe.rowland.org> <20051123183924.GA1016@apps.cwi.nl>
In-Reply-To: <20051123183924.GA1016@apps.cwi.nl>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig96760C6FFDEC53C2DE2BE66C"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - carbon.nocdirect.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - ipom.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig96760C6FFDEC53C2DE2BE66C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andries Brouwer wrote:
> On Wed, Nov 23, 2005 at 01:18:30PM -0500, Alan Stern wrote:
> 
> 
>>And do you really need US_FL_FIX_INQUIRY?  Hardly any devices do (maybe 
>>none).
> 
> 
> This one does:
> 
> /* aeb */
> UNUSUAL_DEV( 0x090c, 0x1132, 0x0000, 0xffff,
>                 "Feiya",
>                 "5-in-1 Card Reader",
>                 US_SC_DEVICE, US_PR_DEVICE, NULL,
>                 US_FL_FIX_CAPACITY ),

Can you be more specific? Matthew added some code (specifically a delay)
which should have taken care of most if not all of these a few kernel
versions ago (.12-ish?)...

Are you saying this device still doesn't work for you using the above
entry in a recent kernel?

-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"Be who you are and say what you feel, because those who mind don't
matter and those who matter don't mind."
 - Dr. Suess


--------------enig96760C6FFDEC53C2DE2BE66C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDhTzAN5XoxaHnMrsRAm2rAJ9jW5nXBTqQEaPE/I/njlQbn0+DzQCgpAAF
NmuN9NwhUvlCHEO3S0FWL6I=
=RNOm
-----END PGP SIGNATURE-----

--------------enig96760C6FFDEC53C2DE2BE66C--
