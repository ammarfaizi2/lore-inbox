Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268567AbRHDRKV>; Sat, 4 Aug 2001 13:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267233AbRHDRKM>; Sat, 4 Aug 2001 13:10:12 -0400
Received: from titan.golden.net ([199.166.210.90]:15871 "EHLO titan.golden.net")
	by vger.kernel.org with ESMTP id <S268567AbRHDRJy>;
	Sat, 4 Aug 2001 13:09:54 -0400
From: "John L. Males" <software_iq@TheOffice.net>
Organization: Toronto, Ontario, Canada
To: linux-kernel@vger.kernel.org
Date: Sat, 4 Aug 2001 13:09:28 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: First Time Memory Use Observations using 2.4(.7) Kernel - 20010804
Reply-to: software_iq@TheOffice.net
Message-ID: <3B6BF408.21678.2A5073@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

After a few hoops and loops of efforts over past week I have managed
to to have my SuSE 6.4 start up the 2.4 kernel.  I wanted to get a
feel for the 2.4 kernel and specifically the memory management
behaviour.  I had felt there were some issues at least at the 2.2
Kernel, but not sure how much is kernel vs application related.

My first experience is with the 2.4.7 Kernel.  I have not used a 2.4
kernel before.  I am not using a varient of the kernel with the
single-use patch from Daniel Phillips.

My initial overall impression of the 2.4.7 kernel is encouraging. On
the specific memory management aspect, I saw some positive
improvement in the way memory is "consumed", but discovered by
accident that in another manner a sudden leak from 182MB to 230MB+. 
When I checked via qps to see where the gain was, I could not seem to
find any cause for this jump in the applications. as it had seemed to
be indiacted via qps with a 2.2 kernel.  I can only assume the cause
of this sudden bump was within the Kernel itself, but cannot prove
that.  This type of bump up in memory never happened with the 2.2
Kernels I have used to date, and I have been using the 2.2.19 kernel
almost since its release.  I shut down the one major application I
had been using to see if it would restore memory to pre-application
like usage levels.  Sadly it only partly did and not to level I am
accustomed to with the 2.2 kernels.

I am not on the Kernel mailing list, so any thoughts to my
observations or how I can validate my observations with metrics would
be appreciated be replying to my eMail address.  I am not using a
varient of the kernel with the single-use patch from Daniel Phillips.


Regards,

John L. Males
Software I.Q. Consulting
Toronto, Ontario
Canada
04 August 2001 13:09
mailto:software_iq@TheOffice.net
mailto:jlmales@softhome.net

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use <http://www.pgp.com>

iQA/AwUBO2w6U14sOqR1C4kdEQK30QCfb0pY+MBxWm/1h5zLcjg5rUx4d9kAoK8+
Vug7S739jl8r/kQJo+tNSWDk
=c1bn
-----END PGP SIGNATURE-----

