Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262903AbSJWHuz>; Wed, 23 Oct 2002 03:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262904AbSJWHuz>; Wed, 23 Oct 2002 03:50:55 -0400
Received: from a213-84-34-179.xs4all.nl ([213.84.34.179]:65408 "EHLO
	defiant.binary-magic.com") by vger.kernel.org with ESMTP
	id <S262903AbSJWHuy> convert rfc822-to-8bit; Wed, 23 Oct 2002 03:50:54 -0400
From: Take Vos <Take.Vos@binary-magic.com>
Organization: Binary Magic
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: PROBLEM: PS/2 keyboard and mouse not available/working/weird
Date: Wed, 23 Oct 2002 09:43:19 +0200
User-Agent: KMail/1.4.7
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200210221603.54816.Take.Vos@binary-magic.com> <20021022163453.A22665@ucw.cz>
In-Reply-To: <20021022163453.A22665@ucw.cz>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200210230943.25549.Take.Vos@binary-magic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

On Tuesday 22 October 2002 16:34, Vojtech Pavlik wrote:
> On Tue, Oct 22, 2002 at 04:03:49PM +0200, Take Vos wrote:
> > I just upgraded to 2.5.44 from 2.5.43.
> > In 2.5.43 I had a small PS/2 mouse problem, as it din't see my wart but
> > only my scratch pad.
> Known bug, still trying to find out why this happens. Any chance your
> notebook has an IBM touchpad?
I have no idea. (I did try and enable the IBM touchpad in the kernel config, 
but It didn't see it.)

> > The last time I booted in 2.5.44 the keyboard was found after about 20
> > keystrokes but was useless as it produced weird escape sequences instead
> > of normal characters, this was without XFree (to check if it had
> > something to do with that).
> Can you try with #define DEBUG in i8042.c?
I tried, but it gave to much output, and it only logged the events in syslog, 
as the boot messages where already gone from the buffer.

I did some more checking and found how to consitantly get the same problem:
	- Booting cold, everything works ok (except ofcource my wart mouse)
	- Booting warm (reboot), keyboard failes.

I checked if it was because of interaction with the USB mouse, but I tried it 
with the mouse in both USB ports and without the USB mouse, but could not 
found any interaction.

Hope I have helped you with this,
	Take
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9tlMbMMlizP1UqoURArT1AJ0ekWQBvClzU1hI4LrPSsCtSLUpoQCg6KvA
yq9JrGwNNXFrMlpep9ztFtc=
=irq3
-----END PGP SIGNATURE-----

