Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262675AbTHZPMc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTHZPMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:12:32 -0400
Received: from [24.241.190.29] ([24.241.190.29]:48068 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S262675AbTHZPM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:12:28 -0400
Date: Tue, 26 Aug 2003 11:12:25 -0400
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Where'd my second proc go?
Message-ID: <20030826151225.GT16183@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nZJAkgcjPzQrJB+u"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nZJAkgcjPzQrJB+u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



Dual-P3-850.  Bios reports both procs.  2.4.21-ac3 reported both procs.
2.4.22-rc2-ac1 only shows one.  The lilo used to have a "maxcpus=3D1"
append but I removed that and I tried changing it to 4 even.  cat
/proc/cpu only shows 1 still.


root# cat /proc/cpuinfo=20
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 846.342
cache size      : 256 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips        : 1684.27

root# uname -a
Linux nms-hub2.acs.pnap.net 2.4.22-rc2-ac1 #1 SMP Sat Aug 9 12:32:27 EDT 20=
03 i686 unknown


Pushing to the latest 2.4.22 kernel would be a nightmare as that means
another testing cycle and 2.4.23 will be out before it gets passed.

Thoughts?
  Robert



:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--nZJAkgcjPzQrJB+u
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/S3jZ8+1vMONE2jsRAm7rAJ9iIxcQ43dU9gXrLandQos2XTx3ZACdFT+K
cduykdIhgLhvlwpqOuzn/e4=
=BlZ+
-----END PGP SIGNATURE-----

--nZJAkgcjPzQrJB+u--
