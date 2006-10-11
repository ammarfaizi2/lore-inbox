Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161176AbWJKTh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161176AbWJKTh6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161175AbWJKTh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:37:58 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:38559 "EHLO uludag.org.tr")
	by vger.kernel.org with ESMTP id S1161067AbWJKTh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:37:57 -0400
From: "=?iso-8859-9?q?S=2E=C7a=F0lar?= Onur" <caglar@pardus.org.tr>
Reply-To: caglar@pardus.org.tr
Organization: =?utf-8?q?T=C3=9CB=C4=B0TAK_/?= UEKAE
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: Ondemand/Conservative not working with 2.6.18
Date: Wed, 11 Oct 2006 22:38:00 +0300
User-Agent: KMail/1.9.5
Cc: "Dave Jones" <davej@redhat.com>, linux-kernel@vger.kernel.org
References: <EB12A50964762B4D8111D55B764A8454B6C08C@scsmsx413.amr.corp.intel.com>
In-Reply-To: <EB12A50964762B4D8111D55B764A8454B6C08C@scsmsx413.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1700547.PkTOibKvg4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200610112238.03319.caglar@pardus.org.tr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1700547.PkTOibKvg4
Content-Type: text/plain;
  charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

11 Eki 2006 =C7ar 22:00 tarihinde, Pallipadi, Venkatesh =FEunlar=FD yazm=FD=
=FEt=FD:=20
> Can you configure with CPU_FREQ_DEBUG and do "echo 5 >
> /sys/module/cpufreq/parameter/debug" before switching the governor to
> ondemand and see whether you see any messages in dmesg?

Here it is;

zangetsu cpufreq # echo 5 > /sys/module/cpufreq/parameters/debug
zangetsu cpufreq # echo "ondemand" > scaling_governor
zangetsu cpufreq # dmesg

=2E..
cpufreq-core: setting new policy for CPU 0: 800000 - 1733000 kHz
freq-table: request for verification of policy (800000 - 1733000 kHz) for c=
pu=20
0
freq-table: verification lead to (800000 - 1733000 kHz) for cpu 0
freq-table: request for verification of policy (800000 - 1733000 kHz) for c=
pu=20
0
freq-table: verification lead to (800000 - 1733000 kHz) for cpu 0
cpufreq-core: new min and max freqs are 800000 - 1733000 kHz
cpufreq-core: governor switch
cpufreq-core: __cpufreq_governor for CPU 0, event 2
cpufreq-core: __cpufreq_governor for CPU 0, event 1
cpufreq-core: governor: change or update limits
cpufreq-core: __cpufreq_governor for CPU 0, event 3

Cheers
=2D-=20
S.=C7a=F0lar Onur <caglar@pardus.org.tr>
http://cekirdek.pardus.org.tr/~caglar/

Linux is like living in a teepee. No Windows, no Gates and an Apache in hou=
se!

--nextPart1700547.PkTOibKvg4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFLUgby7E6i0LKo6YRAlh0AJ9P+sdnqmwD98k7ExPZ4eV/rJ68xQCePKux
/xkiGzir52owkX+ALz7cX5o=
=xns+
-----END PGP SIGNATURE-----

--nextPart1700547.PkTOibKvg4--
