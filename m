Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbTEYEUr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 00:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbTEYEUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 00:20:47 -0400
Received: from vsat-148-64-8-86.c119.t7.mrt.starband.net ([148.64.8.86]:260
	"EHLO chaos.mshome.net") by vger.kernel.org with ESMTP
	id S261312AbTEYEUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 00:20:45 -0400
Date: Sat, 24 May 2003 22:33:20 -0600
From: Robert Creager <Robert_Creager@LogicalChaos.org>
To: linux-kernel@vger.kernel.org
Subject: Problem with virtually no buffer usage in 2.4.21mdk kernel
Message-Id: <20030524223320.7c1ac413.Robert_Creager@LogicalChaos.org>
Organization: Starlight Vision, LLC.
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.qD0gm5wG3w1/.h"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.qD0gm5wG3w1/.h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


[Please CC me personally, as I'm not subscribed]

Hey folks,

I'm using a custom built 2.4.21 kernel from the Mandrake 9.1 distribution.  The hardware is dual AMD Athlon 2600+ system with 2Gb of registered DDR ECC memory, SCSI and ATA disks.

My apparent problem is I'm seeing virtually no buffer usage, as checked from /proc/meminfo.  The system has been up for 11 days, with heavy dB and file access activity (Gb's worth per day), yet the buffer usage never budges.  Am I missing something fundamental, have I boffed the kernel build, or is there a problem?  I would appreciate any pointers.

        total:    used:    free:  shared: buffers:  cached:
Mem:  2119151616 2068426752 50724864        0    90112 1888358400
Swap: 2089177088 70832128 2018344960
MemTotal:      2069484 kB
MemFree:         49536 kB
MemShared:           0 kB
Buffers:            88 kB
Cached:        1823808 kB
SwapCached:      20292 kB
Active:        1209640 kB
Inactive:       712324 kB
HighTotal:     1179136 kB
HighFree:         2044 kB
LowTotal:       890348 kB
LowFree:         47492 kB
SwapTotal:     2040212 kB
SwapFree:      1971040 kB

Thanks for your time,
Rob

-- 
O_

--=.qD0gm5wG3w1/.h
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iEYEARECAAYFAj7QR5EACgkQgy51bQc2FFkIdwCg3h6/6edI4AuxL+uT/cyWOgJ/
zx8AnjFrTJeCApNqbGspLWo88rw2Jxl1
=AfKr
-----END PGP SIGNATURE-----

--=.qD0gm5wG3w1/.h--

