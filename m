Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVEWS4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVEWS4w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 14:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVEWS4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 14:56:52 -0400
Received: from alog0436.analogic.com ([208.224.222.212]:17065 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261911AbVEWS4t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 14:56:49 -0400
Date: Mon, 23 May 2005 14:56:15 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: =?ISO-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Screen regen buffer at 0x00b8000
In-Reply-To: <20050523182856.GC20318@vega.lgb.hu>
Message-ID: <Pine.LNX.4.61.0505231455440.25390@chaos.analogic.com>
References: <Pine.LNX.4.61.0505200944060.5921@chaos.analogic.com>
 <Pine.LNX.4.58.0505201259560.2206@ppc970.osdl.org>
 <Pine.LNX.4.61.0505201612360.6833@chaos.analogic.com> <20050523182856.GC20318@vega.lgb.hu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1879706418-1256369067-1116874575=:25390"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1879706418-1256369067-1116874575=:25390
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 23 May 2005, [ISO-8859-2] G=E1bor L=E9n=E1rt wrote:

> Hello,
>
> On Fri, May 20, 2005 at 04:17:43PM -0400, Richard B. Johnson wrote:
>> Well I started out opening /dev/vcs, lseeking to 64, and writing
>> a string. This "sort of" worked, but screen attributes got messed
>> up so the "blue" screen attribute 0x17 ended up eventually being
>> black.
>
> /dev/vcsa !=3D /dev/vcs !!!!
>
> There are two different devices, as far as I remember, one is only for
> the characters itself on the console, and one includes attributes as well=
 ...
>
> FYI Documentation/devices.txt:
>
> 0 =3D /dev/vcs          Current vc text contents
>                  1 =3D /dev/vcs1         tty1 text contents
> [...]
>                128 =3D /dev/vcsa         Current vc text/attribute conten=
ts
>                129 =3D /dev/vcsa1        tty1 text/attribute contents
>
> - G=E1bor
>

Thanks, I'll check this out.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5554.17 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
--1879706418-1256369067-1116874575=:25390--
