Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTKYJwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 04:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTKYJwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 04:52:16 -0500
Received: from matrix.roma2.infn.it ([141.108.255.2]:36498 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id S262188AbTKYJwO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 04:52:14 -0500
From: "Emiliano 'AlberT' Gabrielli" <AlberT_NOSPAM_@SuperAlberT.it>
Reply-To: AlberT@SuperAlberT.it
Organization: SuperAlberT.it
To: lgb@lgb.hu, linux-kernel@vger.kernel.org
Subject: Re: hyperthreading
Date: Tue, 25 Nov 2003 10:48:51 +0100
User-Agent: KMail/1.5.4
References: <20031125094419.GB339@vega.digitel2002.hu>
In-Reply-To: <20031125094419.GB339@vega.digitel2002.hu>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311251048.53046.AlberT_NOSPAM_@SuperAlberT.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 10:44, martedì 25 novembre 2003, Gábor Lénárt wrote:
> Hi,
>
> A somewhat stupid question from me, but I have no documentation about
> this topic, namely, how can I enable hyperthreading with 2.6.0 test
> kernels?
>
> My /proc/cpuinfo shows:
>
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 15
> model           : 1
> model name      : Intel(R) Pentium(R) 4 CPU 1.70GHz
> stepping        : 2
> cpu MHz         : 1694.605
> cache size      : 256 KB
> [...]
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
> cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
> bogomips        : 3334.14


P4 does not support HT ... only Xeon and new generation P4-HT does.

moreover you need olso a MB with HT support

- -- 
<?php echo '       Emiliano `AlberT` Gabrielli       '."\n".
           '  E-Mail: AlberT_AT_SuperAlberT_it  '."\n".
           '  Web:    http://SuperAlberT.it  '."\n".
'  IRC:    #php,#AES azzurra.com '."\n".'ICQ: 158591185'; ?>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/wyWDF4boRkzPHocRAhw5AJ95gD2xOL7AtfqKo2eOl0nQXbXl6wCgzsIB
lWN9pkyqelZ8cRIZoypklrw=
=uylL
-----END PGP SIGNATURE-----

