Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVBUQfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVBUQfS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 11:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVBUQfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 11:35:18 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:62100 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S262028AbVBUQfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 11:35:03 -0500
Message-ID: <421A0DDE.7020904@arcor.de>
Date: Mon, 21 Feb 2005 17:35:42 +0100
From: Prakash Punnoor <prakashp@arcor.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050121)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Doug McLain <nostar@comcast.net>,
       PALFFY Daniel <dpalffy-lists@rainstorm.org>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: sata_sil data corruption
References: <Pine.LNX.4.58.0412281319001.5054@rainstorm.org> <421778E4.8060705@pobox.com> <Pine.LNX.4.58.0502211219250.23186@rainstorm.org> <4219A3AD.1000002@comcast.net> <421A0990.7070506@pobox.com> <4219C543.8030903@comcast.net> <20050221162923.GA29621@havoc.gtf.org>
In-Reply-To: <20050221162923.GA29621@havoc.gtf.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB17363451E1CF7B16261F8E3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB17363451E1CF7B16261F8E3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jeff Garzik schrieb:
> On Mon, Feb 21, 2005 at 11:25:55AM +0000, Doug McLain wrote:
>
>>Jeff Garzik wrote:
>>
>>>Doug McLain wrote:
>>>
>>>
>>>>The sata_sil driver is without a doubt, totally hosed.  I, along with
>>>
>>>
>>>"without a doubt" being defined, of course, as "it works for a lot of
>>>people."
>>>
>>>   Jeff
>>>
>>>
>>>
>>>
>>
>>Thats like saying "turn up the radio" when your car makes a funny noise,
>>or "if a tree falls in the woods and nobody is there to hear it, does it
>>make a sound?"
>>
>>It's tempting and comforting to pick the good ones as an example, and
>>some bugs are hard enough to find, let alone fix.  In the end though, if
>>one is broke, it's still broke, isn't it?
>
>
> In this case, the bug _reports_ are hard to find.
>
> Each case with sata_sil is either solved with a BIOS update, a
> blacklist entry, or new cables.  Just read through bugzilla.kernel.org.

I personally think the driver is OK (works for me like a charm with my Samsung
drive), but as I reported a few times, SiI will corrupt data if ext-p2p
discard time setting in bios is set to too low values.

So, Jeff, don't you think adding a quirk to the kernel would prevent such
reports. (I am damn sure, this reports are cause of the setting I am talking
about.) Perhaps you could ask SiI how to do this in the kernel...

--
Prakash Punnoor

formerly known as Prakash K. Cheemplavam

--------------enigB17363451E1CF7B16261F8E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCGg3exU2n/+9+t5gRAtooAJ44lVsBiRvUnNpbL5fiwo2EAssR9gCeJyGW
+hEDSFayQ6LahOsRi6Kd24Q=
=gaM1
-----END PGP SIGNATURE-----

--------------enigB17363451E1CF7B16261F8E3--
