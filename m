Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbUKHAI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbUKHAI0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 19:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUKHAIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 19:08:25 -0500
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:4077 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261715AbUKHAIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 19:08:23 -0500
Message-ID: <418EB8EB.30405@kolivas.org>
Date: Mon, 08 Nov 2004 11:08:11 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gregoire Favre <Gregoire.Favre@freesurf.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why my computer freeze completely with xawtv ?
References: <20041107224621.GB5360@magma.epfl.ch> <418EB58A.7080309@kolivas.org> <20041108000229.GC5360@magma.epfl.ch>
In-Reply-To: <20041108000229.GC5360@magma.epfl.ch>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4D39C74F6DD1CACFEBC6DA16"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4D39C74F6DD1CACFEBC6DA16
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Gregoire Favre wrote:
> On Mon, Nov 08, 2004 at 10:53:46AM +1100, Con Kolivas wrote:
> 
> Hello again :-)
> 
> 
>>Gregoire Favre wrote:
>>
>>>I use DVB with VDR, but I can do the crash all the time without VDR, all
>>>I have to do is to have xawtv running and having a process that write
>>>fast enough data to an HD (I tested xfs, reiserfs, ext2 and ext3 with
>>>same result). If I don't have xawtv running I can't make crashing my
>>>system which is rock stable :-)
>>
>>Is xawtv running as root or with real time privileges? That could do it.
> 
> 
> Normally I start xawtv this way:
> xawtv -c /dev/v4l/video0 -geometry 770x580-0-0 -xvport 61 & as a normal
> user, but I don't know what real time privileges are ?
> I haven't modified in any way xawtv :
> -rwxr-xr-x  1 root root 243K Oct 12 09:36 /usr/bin/xawtv

What does 'top' show as the PRI for xawtv?

Con

--------------enig4D39C74F6DD1CACFEBC6DA16
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBjrjrZUg7+tp6mRURAs6cAKCNCO/3qup5OdL7cCKHDaQnWM9cyACghrMz
Fa2M3lbLuM1Wcb7wm8d36is=
=ljqN
-----END PGP SIGNATURE-----

--------------enig4D39C74F6DD1CACFEBC6DA16--
