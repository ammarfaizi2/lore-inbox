Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129460AbQK1JQS>; Tue, 28 Nov 2000 04:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130008AbQK1JQI>; Tue, 28 Nov 2000 04:16:08 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:20453 "EHLO
        virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
        id <S129460AbQK1JPy>; Tue, 28 Nov 2000 04:15:54 -0500
Message-Id: <5.0.2.1.2.20001128084055.042262b0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Tue, 28 Nov 2000 08:46:09 +0000
To: Tom Mraz <t8m@centrum.cz>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Status of the NTFS driver in 2.4.0 kernels?
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0011280912030.16603-100000@p38mraz.cbu.pvt.c
 z>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's not a real bug. - It's a call to BUG() in ntfs_get_block which is 
there because the function is not actually implemented. - I have only ever 
seen this happen when using midnight commander to browse through an NTFS 
partition. - It seems to never happen if I am just in bash typing away or 
ftp-ing into the machine with the mounted NTFS partitions.

When are you hitting this? - If you are using mc just refrain from using it 
for now for ntfs filesystems and all will be fine.

Anton

At 08:33 28/11/2000, Tom Mraz wrote:
>I've tried to use the readonly NTFS driver in 2.4.0-test11 kernel, but it
>reported me a kernel BUG at fs.c:567. I've searched the archives where David
>Weinehall writes that the driver even in readonly mode doesn't support the
>Win2k NTFS. But I don't have Win2k NTFS (I have WinNT 4.0 SP 6) and the
>kernel still reports this bug :-(. The driver from 2.2.17 kernel seems to
>work fine. Could someone help me?
>
>Please Cc me, because I'm not subscribed to the kernel mailing list. (Or
>don't if you don't want to because I read the archives regularly. :-))
>
>Thanks,
>
>Tomas Mraz
>
>-----------------------------------------------------------------
>No matter how far down the wrong road you've gone, turn back.
>                                                 Turkish proverb
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>Please read the FAQ at http://www.tux.org/lkml/

-- 
      "Education is what remains after one has forgotten everything he 
learned in school." - Albert Einstein
-- 
Anton Altaparmakov  Voice: +44-(0)1223-333541(lab) / +44-(0)7712-632205(mobile)
Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
Cambridge CB2 3BU    ICQ: 8561279
United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
