Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267123AbUBRXW3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267158AbUBRXWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:22:04 -0500
Received: from sccrmhc11.comcast.net ([204.127.202.55]:18627 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267123AbUBRXVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:21:25 -0500
Message-ID: <20040218152042.st14wg8ggg4444gg@carlthompson.net>
X-Priority: 3 (Normal)
Date: Wed, 18 Feb 2004 15:20:42 -0800
From: Carl Thompson <cet@carlthompson.net>
To: Vlasenko Denis <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: hard lock using combination of devices
References: <20040216214111.jxqg4owg44wwwc84@carlthompson.net>
	<20040217223319.GB666@elf.ucw.cz>
	<20040217163228.qz5ogcw4ggc0w8cg@carlthompson.net>
	<200402190013.55033.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200402190013.55033.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=_2fotcblzotog";
	protocol="application/pgp-signature"; micalg="pgp-sha1"
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
X-Originating-IP: 205.158.175.194
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format and has been PGP signed.

--=_2fotcblzotog
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Quoting Vlasenko Denis <vda@port.imtp.ilyichevsk.odessa.ua>:

> ...

> How can Linux folks fix bugs if kernel contains a binary-only part?

As I said, I have the same problem with native Linux drivers too.  When 
I'm not
testing I do prefer to use DriverLoader and Windows drivers because it is more
robust and less buggy than the Linux drivers.  (Wow, I never thought I'd be
saying that!)

>> >>   1:      26061          XT-PIC  i8042
>> >>   2:          0          XT-PIC  cascade
>> >>   8:          1          XT-PIC  rtc
>> >>   9:       2020          XT-PIC  acpi
>> >>  10:    2187181          XT-PIC  yenta, driverloader
>> >>  11:        111          XT-PIC  ALI 5451
>> >>  12:    2399118          XT-PIC  i8042
>> >>  14:     169829          XT-PIC  ide0
>> >>  15:          1          XT-PIC  ide1
>> >> NMI:          0
>> >> LOC:   41036749
>> >> ERR:     275764
>
> You seem to have lots of ERRs too, ~1 each 2 secs.
> That's bad, maybe flakey interrupt controller?
> BIOS writers paying dirty with SMM?

Hmmm... Didn't notice that.  Is there anything that can be done about it?

> I had such problems with 11g card and 'latest' BIOS for
> my old mainboard. Older BIOS was ok.

There are no BIOS downloads available for my notebook, unfortunately.

What 11g card and driver are you using?

> --
> vda

Thanks,
Carl Thompson




--=_2fotcblzotog
Content-Type: application/pgp-signature
Content-Description: PGP Digital Signature
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQBAM/NK6IVDCG8k9vsRAqgEAJ9JRmxKBFHleh/pk0+wEEEzAOgQAQCffYpt
MNcU45XCgXuSrMpqW4iYrYQ=
=YrAZ
-----END PGP SIGNATURE-----

--=_2fotcblzotog--

