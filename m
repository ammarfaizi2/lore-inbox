Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUGZLDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUGZLDe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 07:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265154AbUGZLDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 07:03:33 -0400
Received: from mail002.syd.optusnet.com.au ([211.29.132.32]:27053 "EHLO
	mail002.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265029AbUGZLDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 07:03:30 -0400
Message-ID: <4104E4ED.7030901@kolivas.org>
Date: Mon, 26 Jul 2004 21:03:09 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Autotune swappiness01
References: <cone.1090801520.852584.20693.502@pc.kolivas.org> <200407261234.29565.rjwysocki@sisk.pl> <4104DD27.6050907@kolivas.org> <200407261254.01186.rjwysocki@sisk.pl>
In-Reply-To: <200407261254.01186.rjwysocki@sisk.pl>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC87F10653CF22663249A8AD6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC87F10653CF22663249A8AD6
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

R. J. Wysocki wrote:
> On Monday 26 of July 2004 12:29, Con Kolivas wrote:
> 
>>R. J. Wysocki wrote:
>>
>>>On Monday 26 of July 2004 11:31, Con Kolivas wrote:
>>>
>>>>R. J. Wysocki wrote:
>>>>
>>>>>On Monday 26 of July 2004 03:09, Con Kolivas wrote:
>>>>>
>>>>>>Con Kolivas writes:
>>>>>>
>>>>>>>Andrew Morton writes:
>>>>>>>
>>>>>>>>Seriously, we've seen placebo effects before...
>>>>>>>
>>>>>>>I am in full agreement there... It's easy to see that applications do
>>>>>>>not swap out overnight; but i'm having difficulty trying to find a way
>>>>>>>to demonstrate the other part. I guess timing the "linking the kernel
>>>>>>>with full debug" on a low memory box is measurable.
>>>>>>
>>>>>>I should have said - finding a swappiness that ensures not swapping out
>>>>>>applications with updatedb, then using that same swappiness value to do
>>>>>>the linking test.
>>>>>
>>>>>Please excuse me, but is that viable at all?  IMHO, it's just like
>>>>>trying to tune a radio including volume with only one knob.  I don't
>>>>>say it won't work, but the probability that it will is rather small, it
>>>>>seems ...
>>>>
>>>>Well that's what we want. I cant remember other desktop operating
>>>>systems setting a root only control between night and day, or between
>>>>copying ISOs and running applications or...
>>>
>>>I agree, but isn't it related to the fact that other desktop OSes usually
>>>don't run anything like updatedb nightly?
>>>
>>>Perhaps we need a bit more sophisticated swap algorithm than other OSes
>>>do. For example, couldn't we add an additional parameter to control the
>>>swapping "behavior", apart from the swappiness?  Something like adding
>>>the second knob in my radio example?  Just thinking,
>>
>>I think one knob is one knob too many already.
> 
> 
> Can you please tell me why do you think so?

If you wanna discuss pedantics...

In my ideal, nonsensical, impossible to obtain world we have an 
autoregulating operating system that doesn't need any knobs.

Con

--------------enigC87F10653CF22663249A8AD6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBBOTtZUg7+tp6mRURAjFNAJ93ZfmbUVDWek0jRtWiPftpqyoOgACfa1bA
KwlyNJl+4SY9W6S8DogDJ8c=
=28mo
-----END PGP SIGNATURE-----

--------------enigC87F10653CF22663249A8AD6--
