Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291401AbSBXVnK>; Sun, 24 Feb 2002 16:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291397AbSBXVnB>; Sun, 24 Feb 2002 16:43:01 -0500
Received: from lsanca1-ar27-4-63-184-089.lsanca1.vz.dsl.gtei.net ([4.63.184.89]:10112
	"EHLO barbarella.hawaga.org.uk") by vger.kernel.org with ESMTP
	id <S291401AbSBXVmp>; Sun, 24 Feb 2002 16:42:45 -0500
Date: Sun, 24 Feb 2002 13:42:34 -0800 (PST)
From: Ben Clifford <benc@hawaga.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.5-dj1 - problem with /dev/input/mice
In-Reply-To: <20020224222708.A1814@ucw.cz>
Message-ID: <Pine.LNX.4.33.0202241338490.11220-100000@barbarella.hawaga.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 24 Feb 2002, Vojtech Pavlik wrote:

> That's interesting. It almost looks like if the Xserver messed with the
> mouse hardware somehow, which I hope it can't.

> Does 'dmesg' say anything relevant?

I don't think so.

All that appears is an mtrr message about alignment, that I think I has
appeared for several kernel versions.

> I can help you find the cause - if you enable I8042_DEBUG_IO in
> drivers/input/serio/i8042.h, you'll see all the data coming in and out
> to the keyboard/aux controller.

Compiling now...

- -- 
Ben Clifford     benc@hawaga.org.uk     GPG: 30F06950
Job Required in Los Angeles - Will do most things unix or IP for money.
http://www.hawaga.org.uk/resume/resume001.pdf
Live Ben-cam: http://barbarella.hawaga.org.uk/benc-cgi/watchers.cgi
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8eV5OsYXoezDwaVARAsvZAJsGbZrxboqXmRmipPM0cScR+StzuACfVE5P
cwlgu22wLd09O8onA1iv/Dw=
=rnUz
-----END PGP SIGNATURE-----

