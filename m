Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbUKCKst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbUKCKst (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 05:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbUKCKst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 05:48:49 -0500
Received: from smtp-out4.blueyonder.co.uk ([195.188.213.7]:10058 "EHLO
	smtp-out4.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261548AbUKCKrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 05:47:11 -0500
Message-ID: <4188B6E3.8010800@blueyonder.co.uk>
Date: Wed, 03 Nov 2004 10:45:55 +0000
From: Ross Kendall Axe <ross.axe@blueyonder.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: question on common error-handling idiom
References: <4187E920.1070302@nortelnetworks.com> <Pine.LNX.4.53.0411022154210.28980@yvahk01.tjqt.qr> <Pine.LNX.4.61.0411021607400.8977@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0411021607400.8977@chaos.analogic.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig66D075D1C8C05A9085B37196"
X-OriginalArrivalTime: 03 Nov 2004 10:46:33.0389 (UTC) FILETIME=[626CA5D0:01C4C192]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig66D075D1C8C05A9085B37196
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

linux-os wrote:

>>> There's something I've been wondering about for a while.  There is a 
>>> lot of code
>>> in linux that looks something like this:
>>>
>>> err = -ERRORCODE
>>> if (error condition)
>>>     goto out;
>>
> 
> 
> I think it's just to get around the "uninitialized variable"
> warning when the 'C' compiler doesn't know that it will
> always be initialized.
> 

gcc is smart enough to get this case right.

Ross


--------------enig66D075D1C8C05A9085B37196
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBiLbq9bR4xmappRARAhw3AKDCFyukFvZD8l2MNxzbSrg6C7b9VwCgjKmc
F/4HUAMDAGaMBO5BZnsvsHs=
=XbKd
-----END PGP SIGNATURE-----

--------------enig66D075D1C8C05A9085B37196--
