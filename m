Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132032AbQKZQDZ>; Sun, 26 Nov 2000 11:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130121AbQKZQDQ>; Sun, 26 Nov 2000 11:03:16 -0500
Received: from [193.120.224.170] ([193.120.224.170]:57501 "EHLO
        florence.itg.ie") by vger.kernel.org with ESMTP id <S132032AbQKZQDD>;
        Sun, 26 Nov 2000 11:03:03 -0500
Date: Sun, 26 Nov 2000 15:33:00 +0000 (GMT)
From: Paul Jakma <paulj@itg.ie>
To: <linux-kernel@vger.kernel.org>
Subject: problem with hp C1537A tape drives
Message-ID: <Pine.LNX.4.30.0011261520220.892-100000@rossi.itg.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a problem with the aforementioned DDS-3 tape drives. I'm using
one with amanda for backups. But every now and then the nightly backup
fails with "I/O error" and i see the following in the system logs:

st0: Error with sense data: [valid=0] Info fld=0x0, Current st09:00:
sense key Aborted Command
Additional Sense indicates Data phase error

I try various things to get the drive to work again -> mt rewind, mt
retension, load and unload the tape. "scsi remove-single-device" ->
power off drive -> power up -> "scsi add-single-device". (it's not the
tape cause i've tried replacing tapes).

but nothing helps. now it mightn't be unreasonable to say the drive is
faulty, so i replaced the drive with an identical C1537A. And... same
thing happens again: after a couple of weeks of good backups i get the
same problem again.

Is there a known problem with SCSI tape drives? or with HP DDS-3
drives? What does the kernel error message mean? (it's all 0's so not
much i guess). What is a "Data Phase error"?

thanks in advance,

Paul Jakma.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
