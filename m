Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265420AbSJXSoQ>; Thu, 24 Oct 2002 14:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265482AbSJXSoQ>; Thu, 24 Oct 2002 14:44:16 -0400
Received: from bg77.anu.edu.au ([150.203.223.77]:35014 "EHLO lassus.himi.org")
	by vger.kernel.org with ESMTP id <S265420AbSJXSoO>;
	Thu, 24 Oct 2002 14:44:14 -0400
Date: Fri, 25 Oct 2002 04:50:25 +1000
From: Simon Fowler <simon@himi.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [CFT] faster athlon/duron memory copy implementation
Message-ID: <20021024185025.GB5667@himi.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3DB82ABF.8030706@colorfullife.com> <20021024184328.GA5667@himi.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
In-Reply-To: <20021024184328.GA5667@himi.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2002 at 04:43:28AM +1000, Simon Fowler wrote:
> On Thu, Oct 24, 2002 at 07:15:43PM +0200, Manfred Spraul wrote:
> > AMD recommends to perform memory copies with backward read operations=
=20
> > instead of prefetch.
> >=20
> > http://208.15.46.63/events/gdc2002.htm
> >=20
> > Attached is a test app that compares several memory copy implementation=
s.
> > Could you run it and report the results to me, together with cpu,=20
> > chipset and memory type?
> >=20
> > Please run 2 or 3 times.
> >=20
> simon@caccini:~/hacking$ cat /proc/cpuinfo=20
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 1
> model name      : AMD-K7(tm) Processor
> stepping        : 2
> cpu MHz         : 553.880
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmo=
v pat mmx syscall mmxext 3dnowext 3dnow
> bogomips        : 1104.28
>=20
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] System=
 Controller (rev 25)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP Bri=
dge (rev 01)

Generic PC100 and PC133 DIMM - both 256MB.

Simon

--=20
PGP public key Id 0x144A991C, or http://himi.org/stuff/himi.asc
(crappy) Homepage: http://himi.org
doe #237 (see http://www.lemuria.org/DeCSS)=20
My DeCSS mirror: ftp://himi.org/pub/mirrors/css/=20

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9uEDwQPlfmRRKmRwRAlEjAKC0KZ3BWmBgmE+dwbY54o+hQnWpjQCgvWn4
x1A4pNuhlECSsabF+Hhzaxo=
=0Qhw
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
