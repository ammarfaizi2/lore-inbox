Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132649AbQKWHxC>; Thu, 23 Nov 2000 02:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132657AbQKWHwx>; Thu, 23 Nov 2000 02:52:53 -0500
Received: from callisto.space.umu.se ([192.36.114.9]:43790 "EHLO
        callisto.umea.irf.se") by vger.kernel.org with ESMTP
        id <S132649AbQKWHwq>; Thu, 23 Nov 2000 02:52:46 -0500
Message-ID: <010a01c0551e$22a3bdb0$067224c0@umea.irf.se>
From: Pär-Ola Nilsson <peje@umea.irf.se>
To: "Andreas Dilger" <adilger@turbolinux.com>,
        "Mohammad A. Haque" <mhaque@haque.net>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <200011230640.eAN6eb223846@webber.adilger.net>
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
Date: Thu, 23 Nov 2000 08:22:28 +0100
MIME-Version: 1.0
Content-Type: text/plain;
        charset="Windows-1252"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.3018.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 540028982 = 0x20303036 = " 336"
> 540024880 = 0x20302030 = " 3 3"
> 170926128 = 0x0a302030 = "\n3 3"
>
These should be:
540028982 = 0x20303036 = " 006"
540024880 = 0x20302030 = " 0 0"
170926128 = 0x0a302030 = "\n0 0"

/Pär-Ola Nilsson


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
