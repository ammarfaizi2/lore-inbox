Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbQKIQR7>; Thu, 9 Nov 2000 11:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129060AbQKIQRt>; Thu, 9 Nov 2000 11:17:49 -0500
Received: from butterfly.hjsoft.com ([205.231.166.38]:56331 "EHLO
	butterfly.hjsoft.com") by vger.kernel.org with ESMTP
	id <S129055AbQKIQRm>; Thu, 9 Nov 2000 11:17:42 -0500
Date: Thu, 9 Nov 2000 11:17:27 -0500
From: "John M. Flinchbaugh" <glynis@butterfly.hjsoft.com>
To: linux-kernel@vger.kernel.org
Subject: [glynis@butterfly.hjsoft.com: test10 and cpia_usb camera]
Message-ID: <20001109111727.A1609@butterfly.hjsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

i'm happy to see my cheap little camera working again.

i have observations though:
using uhci.o, i only get black image from video camera in xawtv.

using usb-uhci.o, i get a picture, but i periodically get:
kernel: usb-uhci.c: interrupt, status <number>, frame #<number>
kernel: *_comp parameters have gone AWOL (140/189/137/169)

and xawtv scrolls messages:
rate: video is <number> frames behind.

also, the camera does not operetae the first time i plug it in, it
must first be unplugged, then reconnected.

before cpia broke a couple test kernels back, i used to use uhci.o
quite successfully, but usb-uhci.o did not work.

____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.0 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjoKzhEACgkQCGPRljI8080hhQCeJIVoOkslT1Ij9EZibB1Z3p1P
kSEAn2nAs8jKAZ1diAGgdjvHCEwBq2+R
=dJWF
-----END PGP SIGNATURE-----
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
