Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267541AbSLLWT6>; Thu, 12 Dec 2002 17:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267542AbSLLWT6>; Thu, 12 Dec 2002 17:19:58 -0500
Received: from a213-84-34-179.xs4all.nl ([213.84.34.179]:64641 "EHLO
	defiant.binary-magic.com") by vger.kernel.org with ESMTP
	id <S267541AbSLLWT5>; Thu, 12 Dec 2002 17:19:57 -0500
From: Take Vos <Take.Vos@binary-magic.com>
Organization: Binary Magic
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: PROBLEM: PS/2 keyboard and mouse not available/working/weird
Date: Thu, 12 Dec 2002 20:36:14 +0100
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200210221603.54816.Take.Vos@binary-magic.com> <20021022163453.A22665@ucw.cz>
In-Reply-To: <20021022163453.A22665@ucw.cz>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200212122036.18595.Take.Vos@binary-magic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 22 October 2002 16:34, Vojtech Pavlik wrote:
> On Tue, Oct 22, 2002 at 04:03:49PM +0200, Take Vos wrote:
> > In 2.5.44 both my PS/2 mice are not available, neither is my keyboard,
> > although after sufficient keystrokes, sometimes 5, sometimes more, the
> > keyboard is found, this is with Xfree.
I am now using 2.5.51 and I still have the problem when I reboot from a 2.5.51 
kernel to a 2.5.51 or 2.4.19 kernel both my internal keyboard and mouse (DELL 
Inspiron 8100) are not working anymore. The strange thing is the keyboard 
does work in grub.

relevant dmesg output:
	device class 'input': registering
	register interface 'mouse' with class 'input'
	mice: PS/2 mouse device common for all mice
	register interface 'joystick' with class 'input'
	register interface 'event' with class 'input'
	input: PS/2 Synaptics TouchPad on isa0060/serio1
	serio: i8042 AUX port at 0x60,0x64 irq 12
	input: AT Set 2 keyboard on isa0060/serio0
	serio: i8042 KBD port at 0x60,0x64 irq 1

thanks,
	Take Vos
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9+OUxMMlizP1UqoURAoXPAKCht3Z/XEo6MIya2gziT6KZ/neDwACfaesk
4ZrzpPHtU280RLRbghmyMnc=
=gTTt
-----END PGP SIGNATURE-----

