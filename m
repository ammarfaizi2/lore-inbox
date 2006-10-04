Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWJDNdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWJDNdn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 09:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWJDNdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 09:33:43 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:21669 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S932409AbWJDNdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 09:33:43 -0400
From: "=?utf-8?q?S=2E=C3=87a=C4=9Flar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: Dave Jones <davej@redhat.com>
Subject: Ondemand/Conservative not working with 2.6.18
Date: Wed, 4 Oct 2006 16:33:34 +0300
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1247133.dsjOZzMiyv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610041633.44870.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1247133.dsjOZzMiyv
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi;

With kernel 2.6.18 "ondemand" and "conservative" governors are not working=
=20
with Sony Vaio FS-215B laptop, no frequency scaling or anything else :)=20
occurs while system is %100 idle or at any workload using these governors,=
=20
but setting "performance" governor changes to 1733 Mhz and "powersave"=20
changes to 800 Mhz as expected. They all works without a problem with=20
2.6.16.x, system information below;

/proc/cpuinfo

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 13
model name      : Intel(R) Pentium(R) M processor 1.73GHz
stepping        : 8
cpu MHz         : 1733.000
cache size      : 2048 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca=
=20
cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx up est tm2
bogomips        : 3460.80

/sys/devices/system/cpu/cpu0/cpufreq values

ondemand/ignore_nice_load:0
ondemand/up_threshold:60
ondemand/sampling_rate:333000
ondemand/sampling_rate_min:10000
ondemand/sampling_rate_max:10000000
scaling_cur_freq:1733000
cpuinfo_cur_freq:1733000
scaling_available_frequencies:1733000 1333000 1067000 800000
scaling_available_governors:ondemand performance
scaling_driver:centrino
scaling_governor:ondemand
affected_cpus:0
scaling_max_freq:1733000
scaling_min_freq:800000
cpuinfo_max_freq:1733000
cpuinfo_min_freq:800000

Cheers
=2D-=20
S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart1247133.dsjOZzMiyv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFI7g4y7E6i0LKo6YRAtTkAKCG2Tp41ARDxvKDIBQ5dZGfqzoM6wCgvtbp
k0CNdfeSZzdDaH5/5NtcRqc=
=Oorm
-----END PGP SIGNATURE-----

--nextPart1247133.dsjOZzMiyv--
