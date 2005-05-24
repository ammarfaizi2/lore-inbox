Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVEXVj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVEXVj7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 17:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVEXVj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 17:39:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:11487 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262199AbVEXVjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 17:39:24 -0400
Message-ID: <42939FAF.8040805@punnoor.de>
Date: Tue, 24 May 2005 23:42:07 +0200
From: Prakash Punnoor <prakash@punnoor.de>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050511)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cpufreq/speedstep won't work on Sony Vaio PCG-F807K
References: <42935600.5090008@punnoor.de> <20050524203300.GA24187@isilmar.linta.de>
In-Reply-To: <20050524203300.GA24187@isilmar.linta.de>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigADF3A20742C1EF38C05A8A32"
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigADF3A20742C1EF38C05A8A32
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Dominik Brodowski schrieb:
> On Tue, May 24, 2005 at 06:27:44PM +0200, Prakash Punnoor wrote:
>>subject says it all. The cpufreq interface won't show up (using kernel
>>2.6.12-rc4). I tried the speedstep-smi and acpi-cpufreq module. When I try to
>>insert one of them, modprobe just report: No such device.
> 
> 
> Please compile the kernel with CPUFREQ_DEBUG enabled, boot the kernel with
> the option cpufreq.debug=2 and (try to) modprobe both modules again. Then
> send me or the cpufreq list (see MAINTAINERS) the output of "dmesg".

I first tried acpi-cpufreq (which didn't output much), then speedstep:

acpi-cpufreq: acpi_cpufreq_init
acpi-cpufreq: acpi_cpufreq_cpu_init
acpi-cpufreq: acpi_processor_cpu_init_pdc
speedstep-lib: x86: 6, model: 8
speedstep-lib: Coppermine: MSR_IA32_EBL_CR_POWERON is 0x47c80020, 0x0
speedstep-lib: Coppermine: MSR_IA32_PLATFORM ID is 0x0, 0xfb4d0000
speedstep-smi: signature:0x47534943, command:0x008000b2, event:0x000000b3,
perf_level:0x07d00100.
speedstep-smi: trying to obtain ownership with command 47534980 at port b2
speedstep-smi: result is 0
speedstep-smi: trying to determine frequencies with command 47534980 at port b2
speedstep-smi: result 47534980, low_freq 0, high_freq 4
speedstep-smi: could not detect low and high frequencies by SMI call.
speedstep-lib: trying to determine both speeds
speedstep-lib: P3 - MSR_IA32_EBL_CR_POWERON: 0x47c80020 0x0
speedstep-lib: speed is 650000
speedstep-lib: previous seped is 650000
speedstep-smi: trying to set frequency to state 1 with command 47534980 at port b2
speedstep-smi: retry 1, previous result 0, waiting...
speedstep-smi: retry 2, previous result 0, waiting...
speedstep-smi: retry 3, previous result 0, waiting...
speedstep-smi: retry 4, previous result 0, waiting...
speedstep-smi: retry 5, previous result 0, waiting...
cpufreq: change failed with new_state 2 and result 0
speedstep-lib: P3 - MSR_IA32_EBL_CR_POWERON: 0x47c80020 0x0
speedstep-lib: speed is 650000
speedstep-lib: low seped is 650000
speedstep-smi: trying to set frequency to state 0 with command 47534980 at port b2
speedstep-smi: retry 1, previous result 0, waiting...
speedstep-smi: retry 2, previous result 0, waiting...
speedstep-smi: retry 3, previous result 0, waiting...
speedstep-smi: retry 4, previous result 0, waiting...
speedstep-smi: retry 5, previous result 0, waiting...
cpufreq: change failed with new_state 2 and result 0
speedstep-lib: P3 - MSR_IA32_EBL_CR_POWERON: 0x47c80020 0x0
speedstep-lib: speed is 650000
speedstep-lib: high seped is 650000
speedstep-smi: could not detect two different speeds -- aborting.


HTH,

Prakash

--------------enigADF3A20742C1EF38C05A8A32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCk5+vxU2n/+9+t5gRAoldAJ9DcBj6tOJKPNMtXw1RwDHfeDf6HwCguM7R
W9Lh2ggQ0pqO1HNXRd7KjUk=
=+vuk
-----END PGP SIGNATURE-----

--------------enigADF3A20742C1EF38C05A8A32--
