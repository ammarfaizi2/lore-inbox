Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130664AbQKNHig>; Tue, 14 Nov 2000 02:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130690AbQKNHi1>; Tue, 14 Nov 2000 02:38:27 -0500
Received: from [203.116.59.241] ([203.116.59.241]:37640 "HELO
	aquarius.starnet.gov.sg") by vger.kernel.org with SMTP
	id <S130664AbQKNHiR>; Tue, 14 Nov 2000 02:38:17 -0500
Message-ID: <013301c04e09$a40902a0$050010ac@starnet.gov.sg>
From: "Corisen" <csyap@starnet.gov.sg>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <200011140118.eAE1IuV17166@moisil.dev.hydraweb.com> <4.3.2.7.2.20001113205514.00af7d20@mail.osagesoftware.com> <008801c04de0$9c08a840$050010ac@starnet.gov.sg>
Subject: Re: anyone compiled 2.2.17 on RH7 successfully? [SOLVED]
Date: Tue, 14 Nov 2000 15:08:07 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thanks for all those who replied. your help is really appreciated.

basically, in order to compile kernel in RH7, kgcc *MUST* be used instead of
gcc.

to use kgcc edit the Makefile. find the line below and change to:
CC =$(CROSS_COMPILE)kgcc <----(changed to kgcc instead of gcc/cc)

once again. thank you for those who helped :)

cheers!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
