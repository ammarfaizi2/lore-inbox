Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317952AbSGWBBj>; Mon, 22 Jul 2002 21:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317953AbSGWBBj>; Mon, 22 Jul 2002 21:01:39 -0400
Received: from maillog.promise.com.tw ([210.244.60.166]:24848 "EHLO
	maillog.promise.com.tw") by vger.kernel.org with ESMTP
	id <S317952AbSGWBBi>; Mon, 22 Jul 2002 21:01:38 -0400
Message-ID: <000d01c231e5$10f8ae40$47cba8c0@promise.com.tw>
From: "support" <support@promise.com.tw>
To: "Francois Romieu" <romieu@cogenit.fr>
Cc: "Hank" <hanky@promise.com.tw>, <linux-kernel@vger.kernel.org>
References: <01b801c22f0b$c02cc360$47cba8c0@promise.com.tw> <01ee01c2312e$22976900$47cba8c0@promise.com.tw> <20020722083548.A27973@fafner.intra.cogenit.fr>
Subject: Re: [PATCH] 2.4.19-rc2-ac2 pdc202xx.c update
Date: Tue, 23 Jul 2002 09:05:30 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We think there is no problems, Acturally it is

if (speed == XFER_UDMA_2) {
        OUT_BYTE((thold + adj), indexreg);
        OUT_BYTE((IN_BYTE(datareg) & 0x7f), datareg);
}

So,
if (speed == XFER_UDMA_2)
        set_2regs(thold, (IN_BYTE(datareg) & 0x7f));

--
Promise Technology, Inc


