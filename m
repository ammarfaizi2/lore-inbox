Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292482AbSCMGyO>; Wed, 13 Mar 2002 01:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292522AbSCMGyF>; Wed, 13 Mar 2002 01:54:05 -0500
Received: from maillog.promise.com.tw ([210.244.60.166]:30096 "EHLO
	maillog.promise.com.tw") by vger.kernel.org with ESMTP
	id <S292482AbSCMGxp>; Wed, 13 Mar 2002 01:53:45 -0500
Message-ID: <03ca01c1ca5b$b030afe0$59cca8c0@hank>
From: "Hank Yang" <hanky@promise.com.tw>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>,
        <arjanv@redhat.com>
In-Reply-To: <E16jKCT-00068v-00@the-village.bc.nu>
Subject: Re: [PATCH] Submitting PROMISE IDE Controllers Driver Patch
Date: Wed, 13 Mar 2002 14:52:48 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Alan.

    The patch-file 'patch-2.4.19-pre2-ac3' needs be modified for pdc202xx.c.
In pdc202xx.c, pdc202xx_new_tune_chipset()
switch (speed) to set timing only when UDMA 6 drives exist on ATA-133
controller (PDC20269 and PDC20275). If there are no any UDMA 6 drives
exists, we don't need to set timing here.

    Would you please modify this part?

Thanks and Regards
Hank

> >     I saw the 'patch-2.4.19-pre2-ac3' and it has build-in Maxtor 48 bit
lba
> > spec. Is these patch will be build into next kernel version 2.4.19?
> > Do you want us to make a patch for the 'patch-2.4.19-pre2-ac3'?
>
> I've submitted the IDE code in 2.4.19-pre2-ac3 to Marcelo and he has
> accepted it for 2.4.19-pre3. Hopefully that makes your job easier too.
>
> Alan

