Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130121AbQKZQOr>; Sun, 26 Nov 2000 11:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132068AbQKZQOg>; Sun, 26 Nov 2000 11:14:36 -0500
Received: from filesrv1.baby-dragons.com ([199.33.245.55]:25104 "EHLO
        filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
        id <S130121AbQKZQO3>; Sun, 26 Nov 2000 11:14:29 -0500
Date: Sun, 26 Nov 2000 07:44:00 -0800 (PST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Paul Jakma <paulj@itg.ie>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: problem with hp C1537A tape drives
In-Reply-To: <Pine.LNX.4.30.0011261520220.892-100000@rossi.itg.ie>
Message-ID: <Pine.LNX.4.30.0011260739550.1949-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Paul ,  Could you add a little more info like which scsi
	chipset you are using & what the driver version is & what kernel
	version you are running also (One more )& how you have the drive
	chained to the scsi-bus .  Someplace there is a pointer on howto
	reset the scsi-bus from the /proc system , BUT the method is
	highly not recommended .  Hth ,  JimL

On Sun, 26 Nov 2000, Paul Jakma wrote:
> I have a problem with the aforementioned DDS-3 tape drives. I'm using
> one with amanda for backups. But every now and then the nightly backup
> fails with "I/O error" and i see the following in the system logs:
> st0: Error with sense data: [valid=0] Info fld=0x0, Current st09:00:
> sense key Aborted Command
> Additional Sense indicates Data phase error
> I try various things to get the drive to work again -> mt rewind, mt
> retension, load and unload the tape. "scsi remove-single-device" ->
> power off drive -> power up -> "scsi add-single-device". (it's not the
> tape cause i've tried replacing tapes).
> but nothing helps. now it mightn't be unreasonable to say the drive is
> faulty, so i replaced the drive with an identical C1537A. And... same
> thing happens again: after a couple of weeks of good backups i get the
> same problem again.
> Is there a known problem with SCSI tape drives? or with HP DDS-3
> drives? What does the kernel error message mean? (it's all 0's so not
> much i guess). What is a "Data Phase error"?
> thanks in advance,
> Paul Jakma.
       +----------------------------------------------------------------+
       | James   W.   Laferriere | System  Techniques | Give me VMS     |
       | Network        Engineer | 25416      22nd So |  Give me Linux  |
       | babydr@baby-dragons.com | DesMoines WA 98198 |   only  on  AXP |
       +----------------------------------------------------------------+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
