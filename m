Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275823AbRJJOKI>; Wed, 10 Oct 2001 10:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275825AbRJJOJt>; Wed, 10 Oct 2001 10:09:49 -0400
Received: from smtp4.hushmail.com ([64.40.111.32]:51720 "HELO
	smtp4.hushmail.com") by vger.kernel.org with SMTP
	id <S275818AbRJJOJf>; Wed, 10 Oct 2001 10:09:35 -0400
Message-Id: <200110101408.f9AE87w91970@mailserver1.hushmail.com>
From: jkniiv@hushmail.com
To: linux-kernel@vger.kernel.org
Subject: Dilemma: Replace Escalade with Adaptec 2400A or Promise Supertrak66?
Date: Wed, 10 Oct 2001 07:08:07 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----BEGIN PGP SIGNED MESSAGE-----

Hi folks,

I'm sorry to involve you lot but I have a dilemma of how to replace a problematic 3Ware Escalade 6400 with another ATA RAID controller due to the known problem of Escalade "losing" one or several drives from my striped mirror (RAID10). It needs a reboot and juggling the drives back and forth before it rebuilds the set. Now that 3Ware seems to be discontinuing the line, this issue probably won't be resolved any time soon and I'm wondering which one of two remaining options, Adaptec 2400A or Promise Supertrak66/100 is reasonably compatible with recent (2.4.[89]) Alan Cox kernels? (compatible == hopefully reliable)

I know that both are based on an I2O architecture so there's some hope, at least, even if there is very little support officially by Adaptec or Promise. Alan himself has proclaimed that the Supertrak works for him just fine, but I presume there are no Linux-based utilities available yet. Is there then any way to find out if a drive has gone south and needs to be replaced -- kernel log messages, maybe?

The Adaptec 2400A is presumably very much like the 2100S SCSI model. Adaptec has released some binary only drivers and utilities but none for the 2.4 kernel line. There are however some beta stage drivers (dpt_i2o) available as source for the SCSI models. Now, I happened to list the symbols of the binary only driver for the 2400A (dpt_i2o.o) and came to the conclusion that they are the very same as in the SCSI driver source! Any differences ought to be small. Now, I'm wondering whether anybody has already tested the driver with a 2400A? Alan?

Yours,

  // Jarkko Kniivila, CIO, Ambientia Ltd., Finland

-----BEGIN PGP SIGNATURE-----
Version: Hush 2.0

wlsEARECABsFAjvEViAUHGprbmlpdkBodXNobWFpbC5jb20ACgkQlshdxPYU0CZLvQCd
FRTf26MRGbvJ79i6hiXdWwBO9ksAn2nROfTFKpsfOfOROgjHNWPIVmm5
=4bKb
-----END PGP SIGNATURE-----

