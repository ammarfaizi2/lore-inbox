Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262750AbUKRMSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbUKRMSv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 07:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbUKRMSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 07:18:51 -0500
Received: from alog0221.analogic.com ([208.224.220.236]:36736 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262750AbUKRMSs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 07:18:48 -0500
Date: Thu, 18 Nov 2004 07:13:30 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: Sharma Sushant <sushant@cs.unm.edu>, linux-kernel@vger.kernel.org
Subject: Re: max agruments in system_calls
In-Reply-To: <Pine.LNX.4.53.0411181127170.26614@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0411180710170.4477@chaos.analogic.com>
References: <Pine.LNX.4.60.0411171608250.30215@chawla.cs.unm.edu>
 <Pine.LNX.4.61.0411171839430.1111@chaos.analogic.com>
 <Pine.LNX.4.53.0411181127170.26614@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1678434306-1384073508-1100780010=:4477"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1678434306-1384073508-1100780010=:4477
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 18 Nov 2004, Jan Engelhardt wrote:

>> Huh? You KNOW that you don't have more than 7 registers available
>> on ix86 so you KNOW that you either need a pointer to a struct (one
>> parameter) or it won't work.
>>
>> FYI:
>> =09eax =3D function code
>> =09ebx =3D first parameter
>> =09ecx =3D second parameter
>> =09edx =3D third parameter
>> =09esi =3D fourth parameter
>> =09edi =3D fifth parameter
>> =09ebp =3D sixth parameter
>
> And if you use varargs?
>
>
>
Not relevant. You can't pass your arguments on the stack with
any efficiency (you become Windows) because the user-stack is
just data in the kernel. One would have to copy from the user
stack which is about as inefficient as possible.

> Jan Engelhardt
> --=20
> Gesellschaft f=FF=FFr Wissenschaftliche Datenverarbeitung
> Am Fassberg, 37077 G=FF=FFttingen, www.gwdg.de
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
--1678434306-1384073508-1100780010=:4477--
