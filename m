Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277048AbRJJPC3>; Wed, 10 Oct 2001 11:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277227AbRJJPCT>; Wed, 10 Oct 2001 11:02:19 -0400
Received: from smtp1.hushmail.com ([64.40.111.31]:59912 "HELO
	smtp1.hushmail.com") by vger.kernel.org with SMTP
	id <S277187AbRJJPCO>; Wed, 10 Oct 2001 11:02:14 -0400
Message-Id: <200110101502.f9AF2DC06330@mailserver1c.hushmail.com>
From: jkniiv@hushmail.com
To: "Ryan C. Bonham" <Ryan@srfarms.com>
Cc: "Linux Kernel List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: RE: Dilemma: Replace Escalade with Adaptec 2400A or Promise Super trak66?
Date: Wed, 10 Oct 2001 08:02:13 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----BEGIN PGP SIGNED MESSAGE-----

Hi Ryan,

Some questions just to make sure:

Does it run stably? Have you had any issues with drives failing and going offline without any real reason? Any compatibility issues with certain makes of drives (mine are Maxtor DiamondMax Plus 60, configured as 4x60GB in RAID10)? And what about those Adaptec utilities (raidutil), are they handling the new driver OK?

Oh, I happened to stumble on the Open Source Newsletter at opensource.adaptec.com and was indeed hinted that the 2400A is a full member of the Adaptec I2O clan, but it was so vaguely put I wasn't sure really.

Thanks for your input,

  // Jarkko

On Wed, 10 Oct 2001 10:25:39 -0400, "Ryan C. Bonham" <Ryan@srfarms.com> wrote:
>All the Adaptec I2O RAID products use the same driver, including the
>ATA(Adaptec 2400A) based one.  The ATA drives/arrays will appear to the OS
>as a scsi
>device.  The driver was in the last Linus release also (2.4.10). I am
>running the adaptec 2400A on a 2.4.6 kernel which i patch with adaptecs
>dirvers, with no problems..
>
>Ryan
>
>
>
>> -----Original Message-----
>> From: jkniiv@hushmail.com [mailto:jkniiv@hushmail.com]
>> Sent: Wednesday, October 10, 2001 10:08 AM
>> To: linux-kernel@vger.kernel.org
>> Subject: Dilemma: Replace Escalade with Adaptec 2400A or Promise
>> Supertrak66?
>>
>>
>>
>> -----BEGIN PGP SIGNED MESSAGE-----
>>
>> Hi folks,
>>
>> I'm sorry to involve you lot but I have a dilemma of how to
>> replace a problematic 3Ware Escalade 6400 with another ATA
>> RAID controller due to the known problem of Escalade "losing"
>> one or several drives from my striped mirror (RAID10). It
>> needs a reboot and juggling the drives back and forth before
>> it rebuilds the set. Now that 3Ware seems to be discontinuing
>> the line, this issue probably won't be resolved any time soon
>> and I'm wondering which one of two remaining options, Adaptec
>> 2400A or Promise Supertrak66/100 is reasonably compatible
>> with recent (2.4.[89]) Alan Cox kernels? (compatible ==
>> hopefully reliable)
>>
>> I know that both are based on an I2O architecture so there's
>> some hope, at least, even if there is very little support
>> officially by Adaptec or Promise. Alan himself has proclaimed
>> that the Supertrak works for him just fine, but I presume
>> there are no Linux-based utilities available yet. Is there
>> then any way to find out if a drive has gone south and needs
>> to be replaced -- kernel log messages, maybe?
>>
>> The Adaptec 2400A is presumably very much like the 2100S SCSI
>> model. Adaptec has released some binary only drivers and
>> utilities but none for the 2.4 kernel line. There are however
>> some beta stage drivers (dpt_i2o) available as source for the
>> SCSI models. Now, I happened to list the symbols of the
>> binary only driver for the 2400A (dpt_i2o.o) and came to the
>> conclusion that they are the very same as in the SCSI driver
>> source! Any differences ought to be small. Now, I'm wondering
>> whether anybody has already tested the driver with a 2400A? Alan?
>>
>> Yours,
>>
>>   // Jarkko Kniivila, CIO, Ambientia Ltd., Finland
>>
>> -----BEGIN PGP SIGNATURE-----
>> Version: Hush 2.0
>>
>> wlsEARECABsFAjvEViAUHGprbmlpdkBodXNobWFpbC5jb20ACgkQlshdxPYU0CZLvQCd
>> FRTf26MRGbvJ79i6hiXdWwBO9ksAn2nROfTFKpsfOfOROgjHNWPIVmm5
>> =4bKb
>> -----END PGP SIGNATURE-----
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
>

-----BEGIN PGP SIGNATURE-----
Version: Hush 2.0

wlsEARECABsFAjvEYkQUHGprbmlpdkBodXNobWFpbC5jb20ACgkQlshdxPYU0Cac+ACg
g39LA0QS7Jq6D9Bfmrt9ZhlrVVsAoJ5RCmOgTY3Fu6/lC6EGGZdqkypb
=Oak3
-----END PGP SIGNATURE-----

