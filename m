Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272274AbTHNJ2T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 05:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272275AbTHNJ2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 05:28:19 -0400
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:15113 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S272274AbTHNJ2R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 05:28:17 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: <linux-kernel@vger.kernel.org>
Subject: Via KT400 agpgart issues
Date: Thu, 14 Aug 2003 10:25:12 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308141025.12747.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Ok, I _am_ using the nVidia modules (on 2.4.21) but the fact that the agpgart 
driver can't sense my agp apature size is concerning... (its set to 256MB in 
the bios)

0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed Jul 
16 19:03:09 PDT 2003
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: Detected Via Apollo Pro KT400 chipset
agpgart: unable to determine aperture size.
0: NVRM: AGPGART: unable to retrieve symbol table

I'm running a GeForce FX 5600 128Mb with AGP 3.0 support enabled.
It seems to run ok, but its slower than the Ti 4200-4x I took out by a larger 
margin than it really should be (according to the benchmarks I've seen 
scattered through the internet.)
I'm also running with the Local APIC turned on (it doesnt seem to break 
anything).

Is anything actually broken or is this nothing to worry about?

Cheers,

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD4DBQE/O1V4Bn4EFUVUIO0RAu0VAJip/2qWkG6e6uc/YVYKD5u2f6RwAJ9msH9y
y1VIT2ZaUL5dCQPGoRvjTg==
=a21r
-----END PGP SIGNATURE-----

