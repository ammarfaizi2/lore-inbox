Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276330AbRJKNnZ>; Thu, 11 Oct 2001 09:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276359AbRJKNnP>; Thu, 11 Oct 2001 09:43:15 -0400
Received: from smtp4.hushmail.com ([64.40.111.32]:10508 "HELO
	smtp4.hushmail.com") by vger.kernel.org with SMTP
	id <S276330AbRJKNnH>; Thu, 11 Oct 2001 09:43:07 -0400
Message-Id: <200110111340.f9BDegx91619@mailserver1.hushmail.com>
From: jkniiv@hushmail.com
To: "Bonds, Deanna" <Deanna_Bonds@adaptec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RE: Dilemma: Replace Escalade with Adaptec 2400A or Promise Super trak66?
Date: Thu, 11 Oct 2001 06:40:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----BEGIN PGP SIGNED MESSAGE-----


On Wed, 10 Oct 2001 11:40:32 -0400, "Bonds, Deanna" <Deanna_Bonds@adaptec.com> wrote:
>
>Our drivers are completely open source and currently embedded in both the AC
>and Linus kernel and shipping with various distributions.  They have been
>completely qualified with our product verification lab (i.e. not beta).  It
>is the exact same driver across all of the i2o raid products, whether it is
>SCSI or ATA.  The i2o interface is the same and ATA drives/arrays appear to
>the OS as sd devices.
>

<rant small=small>
Aha, then this is a matter of miscommunication, obviously! When looking at your Linux Downloads page, the last official version made available is for Red Hat 7.0, kernel 2.2.16-22. Navigating to the Unsupported RAID Drivers (presumably this means not "completely qualified") page, one finds drivers for more recent kernels but only a vague phrase "Applies to: All DPT I2O architecture based RAID cards". This hints of the *possibility* of the drivers working with a 2400A ATA RAID controller. But this is important pre-sales info: not all of us know reading from the product description that the 2400A is based on I2O or that it's compatible enough to be supported by your I2O family drivers! Please clarify this for prospective Linux customers.
</rant>

>When changing adapters you will not just be able to plug the drives into the
>Adaptec card and go.  The raid tables and striping will be different.  The
>Adaptec metadata formats are public, I have not looked into the 3ware format
>though.  If there is enough interest we can explore creating a conversion
>program.
>

Well, I knew all along that the change would involve wiping the drives clean and pulling the data from backups. That'd be only a small nuisance but is alright with me. :-) The 3ware driver problems are *driving* me and co-workers restless (if not nuts)!

>Deanna
>

Thanks for your clarifying comments, Deanna! I'll probably try my luck with your product next.

Regards,

  // Jarkko Kniivilä, CIO, Ambientia Ltd.

-----BEGIN PGP SIGNATURE-----
Version: Hush 2.0

wlsEARECABsFAjvFoT4UHGprbmlpdkBodXNobWFpbC5jb20ACgkQlshdxPYU0CbeqQCf
TQNeuBiMTD8L0X/QhPd2622UvmkAoKeyPmqvIFRJsNSYWVqDiiF8y7y2
=dwpH
-----END PGP SIGNATURE-----

