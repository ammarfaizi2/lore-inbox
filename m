Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267297AbSKPQN3>; Sat, 16 Nov 2002 11:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbSKPQN3>; Sat, 16 Nov 2002 11:13:29 -0500
Received: from pc151.host13.starman.ee ([62.65.205.151]:260 "EHLO amd-laptop")
	by vger.kernel.org with ESMTP id <S267297AbSKPQN2>;
	Sat, 16 Nov 2002 11:13:28 -0500
Date: Sat, 16 Nov 2002 18:12:24 +0200
From: Priit Laes <amd@tt.ee>
To: linux-kernel@vger.kernel.org
Subject: [BUG] 2.4.20-rc2 - Kernel Panic
Message-ID: <20021116161224.GA5144@amd-laptop.mshome.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.19-gentoo-r9 (i686)
X-GPG-Fingerprint: 7297 A6E5 287F 40FD 0945  17FF 9D35 D5C0 8545 2118
X-GPG-Key: http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x85452118
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I compiled latest 2.4.20 kernel for my router (Intel 486 DX 100Mhz) and
when booting up, it fired me with this message:
CPU: Intel 486 DX/4 stepping 00
Kernel panic: Kernel compiled for Pentium+, requires TSC feature!
In idle task - not syncing
=2E.. and there it stays, just flashing leds... (I also wonder why isn't num
lock flashing :P )
Ok.. here is part of my dot.config
# Processor type and features
#
# CONFIG_M386 is not set
CONFIG_M486=3Dy
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
=2E..
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=3Dm=20
CONFIG_NOHIGHMEM=3Dy
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_HIGHMEM is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set
# CONFIG_X86_UP_APIC is not set
# CONFIG_X86_UP_IOAPIC is not set
# CONFIG_X86_TSC_DISABLE is not set
CONFIG_X86_TSC=3Dy

I guess it's a bug in a menuconfig...
And please Cc: me... i am not enlisted at linux-kernel. (I couldn't wait
for Mutt counting these endless seconds.)
--=20
Priit Laes <amd@tt.ee>                                     _o)         =20
http://amd-core.tk                                         /\\  _o)  _o)
GSM : +37256959083                                        _\_V _(\) _(\)

--DocE+STaALJfprDB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE91m5onTXVwIVFIRgRAly1AJ9mypUJdTYekV+DHs/VC2MSut0c2ACfaHFt
Jnq4cJ6lG/bS3BXid9BKBFg=
=8AuJ
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
