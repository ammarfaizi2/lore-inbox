Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281183AbRKOX7e>; Thu, 15 Nov 2001 18:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281188AbRKOX70>; Thu, 15 Nov 2001 18:59:26 -0500
Received: from rigel.neo.shinko.co.jp ([210.225.91.71]:18598 "EHLO
	rigel.neo.shinko.co.jp") by vger.kernel.org with ESMTP
	id <S281184AbRKOX7O>; Thu, 15 Nov 2001 18:59:14 -0500
Message-ID: <3BF456CF.B7C0FFEB@neo.shinko.co.jp>
Date: Fri, 16 Nov 2001 08:59:11 +0900
From: nakai <nakai@neo.shinko.co.jp>
X-Mailer: Mozilla 4.78 [ja] (WinNT; U)
X-Accept-Language: ja,en,pdf
MIME-Version: 1.0
To: Sven.Riedel@tu-clausthal.de
CC: kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14 Oops during boot (KT133A Problem?)
In-Reply-To: <20011115021142.A12923@moog.heim1.tu-clausthal.de> <3BF32B36.8B1375D0@neo.shinko.co.jp> <20011115042843.A383@moog.heim1.tu-clausthal.de> <3BF376BC.B184E954@neo.shinko.co.jp> <20011115112214.A10796@moog.heim1.tu-clausthal.de>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven.Riedel@tu-clausthal.de wrote:
> 
> On Thu, Nov 15, 2001 at 05:03:08PM +0900, nakai wrote:
> > > If more machine info is needed, I'd be glad to provide it.
> > Do you have any cards on PCI bus ?
>   Bus  0, device  14, function  0:
>     Unknown mass storage controller: Triones Technologies, Inc. HPT366 /
> HPT370 (rev 4).
>       IRQ 11.
>       Master Capable.  Latency=64.  Min Gnt=8.Max Lat=8.
>       I/O at 0xb400 [0xb407].
>       I/O at 0xb800 [0xb803].
>       I/O at 0xbc00 [0xbc07].
>       I/O at 0xc000 [0xc003].
>       I/O at 0xc400 [0xc4ff].
>   Bus  1, device   0, function  0:

Can you remove or disable HPT366? Or how about you using 2.4.2
kernel? I am using 2.4.2 kernel, because 2.4.10's ide-pci has
something wrong with promise IDE cards. I did not check about
HPT366 chip, but I think it would be better 2.4.2 kernel.

-- 
-=-=-=-=  SHINKO ELECTRIC INDUSTRIES CO., LTD.           =-=-=-=-
=-=-=-=-    Core Technology Research & Laboratory,       -=-=-=-=
-=-=-=-=      Infomation Technology Research Dept.       =-=-=-=-
=-=-=-=-  Name:Hisakazu Nakai          TEL:026-283-2866  -=-=-=-=
-=-=-=-=  Mail:nakai@neo.shinko.co.jp  FAX:026-283-2820  =-=-=-=-
