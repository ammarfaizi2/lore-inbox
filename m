Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbSJVJsm>; Tue, 22 Oct 2002 05:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262400AbSJVJsm>; Tue, 22 Oct 2002 05:48:42 -0400
Received: from a213-84-34-179.xs4all.nl ([213.84.34.179]:55424 "EHLO
	defiant.binary-magic.com") by vger.kernel.org with ESMTP
	id <S262384AbSJVJsh> convert rfc822-to-8bit; Tue, 22 Oct 2002 05:48:37 -0400
From: Take Vos <Take.Vos@binary-magic.com>
Organization: Binary Magic
To: Brad Hards <bhards@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: USB mouse does not apear in /dev/input
Date: Tue, 22 Oct 2002 11:48:21 +0200
User-Agent: KMail/1.4.7
References: <200210221046.46700.Take.Vos@binary-magic.com> <200210221909.10753.bhards@bigpond.net.au>
In-Reply-To: <200210221909.10753.bhards@bigpond.net.au>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200210221148.30286.Take.Vos@binary-magic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello Brad,

> > kernel:	linux-2.5.43
> > hardware:DELL Inspiron 8100
> > mouse:	Logitech USB Optical Mouse
> > config:
> > 		CONFIG_INPUT_MOUSEDEV
> > 		CONFIG_INPUT_EVDEV
> > 		CONFIG_SERIO
> > 		CONFIG_SERIO_I8042
> > 		CONFIG_INPUT_MOUSE
> > 		CONFIG_MOUSE_PS2
> > 		CONFIG_USB
> > 		CONFIG_USB_HID
> > 		CONFIG_USB_HIDINPUT
>
> Can you show us /proc/bus/usb/devices?
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.05
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=1.5 MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=046d ProdID=c00c Rev= 6.20
S:  Manufacturer=Logitech
S:  Product=USB Mouse
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms

> And also /proc/bus/input/devices?
I: Bus=0011 Vendor=0002 Product=0001 Version=0000
N: Name="PS/2 Generic Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0 event0
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=3

I: Bus=0011 Vendor=0001 Product=0002 Version=ab02
N: Name="AT Set 2 keyboard"
P: Phys=isa0060/serio0/input0
H: Handlers=kbd event1
B: EV=120003
B: KEY=4 2000000 8061f9 fbc9d621 efdfffdf ffefffff ffffffff fffffffe
B: LED=7

- -- 
Take Vos <Take.Vos@binary-magic.com>
GnuPG: 2A5C110609995A378302A27630C962CCFD54AA85
http://binary-magic.com/~takev/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9tR7pMMlizP1UqoURAjfaAKCPkAirhn/ktnGbLsFCpcYhbj/LVwCcDxsD
qGZjZjERntKcms3L6K4guww=
=SVA6
-----END PGP SIGNATURE-----

