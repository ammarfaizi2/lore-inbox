Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293477AbSBYTrB>; Mon, 25 Feb 2002 14:47:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293444AbSBYTqy>; Mon, 25 Feb 2002 14:46:54 -0500
Received: from smtp3.hushmail.com ([64.40.111.33]:35848 "HELO
	smtp3.hushmail.com") by vger.kernel.org with SMTP
	id <S293477AbSBYTqk>; Mon, 25 Feb 2002 14:46:40 -0500
Message-Id: <200202251943.g1PJhh231456@mailserver4.hushmail.com>
From: mailerror@hushmail.com
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: linux-kernel@vger.kernel.org, mailerror@hushmail.com
Subject: Re: Re: loop under 2.2.20 - relative block support?
Date: Mon, 25 Feb 2002 11:43:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 25 Feb 2002 20:41:25 +0200, Jari Ruusu <jari.ruusu@pp.inet.fi> wrote:
>mailerror@hushmail.com wrote:
>> On Sat, 23 Feb 2002 21:47:56 +0200, Jari Ruusu <jari.ruusu@pp.inet.fi> wrote:
>> >Kerneli patches use block size dependant IV computation (also called "time
>> >bomb" IV). Shit hits the fan when you move files to a device with different
>> >block size. Search linux-crypto archives for more information.
>>
>> Aha. So if I moved the loopback file onto a partition with the same blocksize
>> again, it would all be fine?
>
>If you can move original (unmodified) loop file to same block size, same
>kernel version, then yes. If you mounted it rw, then your "time bomb"
>exploded on your face.
>

Okay, my files are fine then, since the files were burned on cd right after I
created them.

Is this still a problem with the 2.4 loop device? In your patch for 2.4.16
I noticed that the IV calculation is independent from the underlying block
size. That alone would be enough to make me switch over from 2.2 ;-)

thanks a lot..
mailerror

Hush provide the worlds most secure, easy to use online applications - which solution is right for you?
HushMail Secure Email http://www.hushmail.com/
HushDrive Secure Online Storage http://www.hushmail.com/hushdrive/
Hush Business - security for your Business http://www.hush.com/
Hush Enterprise - Secure Solutions for your Enterprise http://www.hush.com/

-----BEGIN PGP SIGNATURE-----
Version: Hush 2.1
Note: This signature can be verified at https://www.hushtools.com

wl4EARECAB4FAjx6lMEXHG1haWxlcnJvckBodXNobWFpbC5jb20ACgkQb539PwJB5JNC
zQCdFCCDIQTekRvch+NwN2Z2mU4SOmIAoK5Z9j5SMGaxOLPUPnWw9N6zxR/J
=BmUy
-----END PGP SIGNATURE-----

