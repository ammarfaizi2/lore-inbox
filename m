Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267580AbSLFI7o>; Fri, 6 Dec 2002 03:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267582AbSLFI7o>; Fri, 6 Dec 2002 03:59:44 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:40205 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267580AbSLFI7n>; Fri, 6 Dec 2002 03:59:43 -0500
Message-Id: <200212030640.gB36dhp09194@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unable to boot a raw kernel image :??
Date: Tue, 3 Dec 2002 09:29:32 -0200
X-Mailer: KMail [version 1.3.2]
References: <20021129132126.GA102@DervishD>
In-Reply-To: <20021129132126.GA102@DervishD>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 November 2002 11:21, DervishD wrote:
>     Hi all :))
>
>     A time ago I was able to generate bootable Linux CD's just by
> dd'ing a floppy containing a raw kernel image:
>
>     dd if=/dev/fd0 of=eltorito
>
>     After that, mkisofsing, toasting and booting. But now, depending
> on the machine,                                            ^^^^^^^^^
  ^^^^^^^^^^^^^^
Boot CD support is BIOS-dependent AFAIK. Maybe on those machines BIOS
floppy emulation from CD is broken?
OTOH if you can boot, say, 2.2 but not 2.4, that's a counterproof
for my theory.

> I have 'invalid compressed format' errors, or even
> ye olde register dump when the image was damaged :(
>
>     Booting directly from the floppy works, but booting with that
> same image from a CD does not :(( I now I can use LILO, or better
> yet, Syslinux or isolinux, but I'm just curious why I cannot boot raw
> image-based CD's anymore.
--
vda
