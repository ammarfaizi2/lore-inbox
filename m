Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSBYQLv>; Mon, 25 Feb 2002 11:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293414AbSBYQLl>; Mon, 25 Feb 2002 11:11:41 -0500
Received: from smtp3.hushmail.com ([64.40.111.33]:40460 "HELO
	smtp3.hushmail.com") by vger.kernel.org with SMTP
	id <S293337AbSBYQLY>; Mon, 25 Feb 2002 11:11:24 -0500
Message-Id: <200202251608.g1PG8QH83933@mailserver4.hushmail.com>
From: mailerror@hushmail.com
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: loop under 2.2.20 - relative block support?
Date: Mon, 25 Feb 2002 08:08:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sat, 23 Feb 2002 21:47:56 +0200, Jari Ruusu <jari.ruusu@pp.inet.fi> wrote:
>mailerror@hushmail.com wrote:
>> What exactly is the status of the loopback device in 2.2.20 with regards
>> to relative block support? Is it *really* supported?
>>
>Kerneli patches use block size dependant IV computation (also called "time
>bomb" IV). Shit hits the fan when you move files to a device with different
>block size. Search linux-crypto archives for more information.

Aha. So if I moved the loopback file onto a partition with the same blocksize
again, it would all be fine?

mailerror

Hush provide the worlds most secure, easy to use online applications - which solution is right for you?
HushMail Secure Email http://www.hushmail.com/
HushDrive Secure Online Storage http://www.hushmail.com/hushdrive/
Hush Business - security for your Business http://www.hush.com/
Hush Enterprise - Secure Solutions for your Enterprise http://www.hush.com/

-----BEGIN PGP SIGNATURE-----
Version: Hush 2.1
Note: This signature can be verified at https://www.hushtools.com

wl4EARECAB4FAjx6YkwXHG1haWxlcnJvckBodXNobWFpbC5jb20ACgkQb539PwJB5JOc
YACdHtDNGubq9SaNZYV/KaInmQMpJf8AoJEIc/weLqdnL3HhhyTpRRTJgqV9
=iQaH
-----END PGP SIGNATURE-----

