Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbUKBRF5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbUKBRF5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 12:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbUKBRCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 12:02:13 -0500
Received: from hostmaster.org ([212.186.110.32]:12930 "EHLO hostmaster.org")
	by vger.kernel.org with ESMTP id S261251AbUKBQ6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 11:58:50 -0500
Subject: Re: 2.6.8 and 2.6.9 Dual Opteron glitches
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: Daniel Egger <degger@fhm.edu>
Cc: Linux Mailing List Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <5AC1EEB8-2CD7-11D9-BF00-000A958E35DC@fhm.edu>
References: <5AC1EEB8-2CD7-11D9-BF00-000A958E35DC@fhm.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SjBXJAX9n39Qg5l6oSY+"
Date: Tue, 02 Nov 2004 17:58:47 +0100
Message-Id: <1099414727.4618.11.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SjBXJAX9n39Qg5l6oSY+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I am using a not-so-new Tyan Thunder K8W S2885 based Dual Opteron
System.

On Die, 2004-11-02 at 14:59 +0100, Daniel Egger wrote:=20
> 1) 32 bit kernel HPET calibration hang: If the kernel is compiled

Cannot tell as I am using a 64-bit kernel without HPET. Can someone
maybe tell me which applications use HPET yet?

> 2) 64 bit kernel vgettimeofday panic: The kernel panics in

Cannot confirm this, both 2.6.8.1 and 2.6.9 boot OK.

> 3) Interrupt distribution 32 bit vs. 64 bit. Below is a copy of the

Cannot confirm this, interrupts seem to be almost equally distributed
with 64-bit kernel and irqbalance running. Did you note that x86_64 does
not provide in-kernel IRQ balancing.

           CPU0       CPU1
  0:    2921345    2988327    IO-APIC-edge  timer
  1:       5767       5414    IO-APIC-edge  i8042
  3:          2        147    IO-APIC-edge  serial
  4:      23806      21183    IO-APIC-edge  serial
  8:          2         37    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 14:      77847      72327    IO-APIC-edge  ide0
 15:      21317      29959    IO-APIC-edge  ide1
 16:     216766     217251   IO-APIC-level  EMU10K1, mga@pci:0000:05:00.0
 17:          0          0   IO-APIC-level  AMD AMD8111
 19:     182493     182216   IO-APIC-level  ohci_hcd, ohci_hcd
 24:     317611       1085   IO-APIC-level  eth0
NMI:          0          0
LOC:    5908168    5908259
ERR:          0
MIS:          0

> 4) ACPI powermanagement (32bit and 64bit): No matter which ACPI options

AFAIK power management is almost unsupported on SMP systems.

Tom

--=20
  T h o m a s   Z e h e t b a u e r   ( TZ251 )
  PGP encrypted mail preferred - KeyID 96FFCB89
      finger thomasz@hostmaster.org for key

Quantum Mechanics is God's version of "Trust me."





--=-SjBXJAX9n39Qg5l6oSY+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iQEVAwUAQYe8x2D1OYqW/8uJAQJF7QgAiBL/dbvgqxvFXdJrsg3BPDg2qX8/lrle
FBn+P880ewQ6pRpnTWjyhm5ZtpxZgO9HXwoP9zOnpz4/rX6tyMc8waR5vEVvqRvu
3zCFzRru9KOYdxOrGUtbpQzn5B6mpzjVNPdgppQu54uRJ8co7CHa4K5DWhvy/FOZ
GjrFyc26BmFsYF/9tlZ1iz1wFSH+PlH3uxoCTt8vPK0Jfgk4IgFDI6JD8g4kQfv6
y0FfdfHL1i0GD4SyQCCVkFtMhWMLltfOCgiRnRXr8zSd4I8kWKgc6AQEaQWtFpPB
ArV3sQ8Zm7483ID5nrFxvLEW3LJBJtqIgsZkV9xGAmDiIl3bQ5KZ2w==
=s727
-----END PGP SIGNATURE-----

--=-SjBXJAX9n39Qg5l6oSY+--

