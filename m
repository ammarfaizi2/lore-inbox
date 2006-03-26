Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbWCZVSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbWCZVSM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 16:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWCZVSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 16:18:12 -0500
Received: from smtp2.libero.it ([193.70.192.52]:4297 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S932117AbWCZVSL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 16:18:11 -0500
Subject: linux kernel bug
From: Michele Schiavo <micheleschi@libero.it>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ruz6u21k45hvqRlhsCjC"
Date: Sun, 26 Mar 2006 23:18:01 +0200
Message-Id: <1143407881.12790.4.camel@nocona.uzz.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-Scanned: with antispam and antivirus automated system at libero.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ruz6u21k45hvqRlhsCjC
Content-Type: multipart/mixed; boundary="=-ez2rUeSwIE0ztOY9ANxf"


--=-ez2rUeSwIE0ztOY9ANxf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

i have found a little problem with sky2 experimental network module
since it's on stable kernel tree.

when my system is sending/reciving many data (particuraly with samba) in
UDP , the traffic will be too slow, many error and after i have to
unload and reload the module sky2.

Unfortunatly there is not log for that.

I can see there is something wrong like watching with ethereal network
analizer. It's report many out of order packet.

more /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :               Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping        : 3
cpu MHz         : 3211.539
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm
constant_tsc
 pni monitor ds_cpl est cid cx16 xtpr
bogomips        : 6429.54
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      :               Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping        : 3
cpu MHz         : 3211.539
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx lm
constant_tsc
 pni monitor ds_cpl est cid cx16 xtpr
bogomips        : 6422.21
clflush size    : 64
cache_alignment : 128
address sizes   : 36 bits physical, 48 bits virtual
power management:




In attachement my current kernel config.




--=-ez2rUeSwIE0ztOY9ANxf
Content-Disposition: attachment; filename=config
Content-Type: application/x-gzip; name=config
Content-Transfer-Encoding: base64

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


--=-ez2rUeSwIE0ztOY9ANxf--

--=-ruz6u21k45hvqRlhsCjC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Questa parte del messaggio =?ISO-8859-1?Q?=E8?= firmata

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD4DBQBEJwUJKy4KhW5rrnkRAsJ4AJjE/AIq7JUROTTy61/zfL7CDlwwAKC9NKBz
sJUAKi8KFBJWCw79tUmp9Q==
=RXq3
-----END PGP SIGNATURE-----

--=-ruz6u21k45hvqRlhsCjC--

