Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267509AbSLLWNz>; Thu, 12 Dec 2002 17:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267518AbSLLWNz>; Thu, 12 Dec 2002 17:13:55 -0500
Received: from a213-84-34-179.xs4all.nl ([213.84.34.179]:51585 "EHLO
	defiant.binary-magic.com") by vger.kernel.org with ESMTP
	id <S267509AbSLLWNx>; Thu, 12 Dec 2002 17:13:53 -0500
From: Take Vos <Take.Vos@binary-magic.com>
Organization: Binary Magic
To: Vojtech Pavlik <vojtech@suse.cz>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: PROBLEM: PS/2 mouse wart does not work, while scratch pad does.
Date: Thu, 12 Dec 2002 20:30:03 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
References: <200210221046.46700.Take.Vos@binary-magic.com> <5001.1035330391@passion.cambridge.redhat.com> <20021023104222.B28139@ucw.cz>
In-Reply-To: <20021023104222.B28139@ucw.cz>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200212122030.16167.Take.Vos@binary-magic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 23 October 2002 10:42, Vojtech Pavlik wrote:
> On Wed, Oct 23, 2002 at 12:46:31AM +0100, David Woodhouse wrote:
> > Take.Vos@binary-magic.com said:
> > > hardware:DELL Inspiron 8100
> > >
> > >  The internal scratch pad works, but the internal wart mouse doesn't,
> > > in the  BIOS it is set to use both devices for input. This is tested
> > > with both  Xfree86 and running cat on /dev/input/mice and /dev/input/
> > > mouse0 and  /dev/input/event0.
> >
> > Probing for various other PS/2 extensions appears to confuse the thing
> > such that the clitmouse no longer works. If we probe for it first and
> > then abort the other probes, it seems happier...
I just tried 2.5.51, but I still have the same problem, scratch pad works, but 
internal wart mouse doesn't.

Here is the current dmesg output:
	device class 'input': registering
	register interface 'mouse' with class 'input'
	mice: PS/2 mouse device common for all mice
	register interface 'joystick' with class 'input'
	register interface 'event' with class 'input'
	input: PS/2 Synaptics TouchPad on isa0060/serio1
	serio: i8042 AUX port at 0x60,0x64 irq 12
	input: AT Set 2 keyboard on isa0060/serio0
	serio: i8042 KBD port at 0x60,0x64 irq 1

Thank you,
	Take Vos
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9+OPGMMlizP1UqoURAgbUAKCK4JZhpd+nybjJZw2QpXf2wt9lvgCfSzdZ
l7/EHd3rzWVi3bs+iWrUkOY=
=8zyA
-----END PGP SIGNATURE-----

