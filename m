Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVBGORo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVBGORo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbVBGORo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:17:44 -0500
Received: from lucidpixels.com ([66.45.37.187]:53142 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S261421AbVBGORk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:17:40 -0500
Date: Mon, 7 Feb 2005 09:17:38 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: Xavier Bestel <xavier.bestel@free.fr>
cc: linux-os@analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Re: Reading Bad DVD Under 2.6.10 freezes the box.
In-Reply-To: <1107783980.6191.154.camel@gonzales>
Message-ID: <Pine.LNX.4.62.0502070914230.8764@p500>
References: <Pine.LNX.4.62.0502070728520.1743@p500> 
 <Pine.LNX.4.61.0502070757580.21063@chaos.analogic.com> <1107783980.6191.154.camel@gonzales>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463747160-2090657961-1107785858=:8764"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463747160-2090657961-1107785858=:8764
Content-Type: TEXT/PLAIN; charset=utf-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Yeah, I can try 2.4.29 later tonight; also, the DVD is not scratched, just=
=20
formatted with Joilet/ISO instead of UDF (which is what should be used on=
=20
DVDs).

However, dd if=3D/dev/hdh of=3Dfile.img
          Even with bs=3D1 for 1 byte at a time, there seems to be no way t=
o
          get the data off, however...

          With the dd, last time I tried it, it just fails.
          When I use cp to try and copy the file, it freezes the machine.

This is all under 2.6.10 with a Toshiba 16X DVD-ROM (I can get model=20
number later.)


On Mon, 7 Feb 2005, Xavier Bestel wrote:

> Le lundi 07 f=C3=A9vrier 2005 =C3=A0 08:05 -0500, linux-os a =C3=A9crit :
>
>>> Main Question >> Why does Linux 'freeze up' when W2K gives a BadCRC err=
or msg
>>> (never freezes)?
>>
>> Of course it should not. However, there were many incomplete changes
>> made in 2.6.nn and some may involve problems with locking, etc.
>
> I don't remember a version of the kernel gracefully handling scratched
> CD/DVD.
>
> =09Xav
>
>
---1463747160-2090657961-1107785858=:8764--
