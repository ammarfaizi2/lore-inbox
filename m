Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129488AbRBFSmi>; Tue, 6 Feb 2001 13:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129761AbRBFSm1>; Tue, 6 Feb 2001 13:42:27 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:29197 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129488AbRBFSmQ>;
	Tue, 6 Feb 2001 13:42:16 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102061841.VAA19895@ms2.inr.ac.ru>
Subject: Re: TCP_NOPUSH on FreeBSD, TCP_CORK on Linux (was: Is sendfile all that
To: alan@lxorguk.UKuu.ORG.UK (Alan Cox)
Date: Tue, 6 Feb 2001 21:41:40 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E14Puvx-0004TB-00@the-village.bc.nu> from "Alan Cox" at Feb 6, 1 02:45:00 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> > How close is TCP_NOPUSH to behaving identically to TCP_CORK now?

They have not so much of common.

TCP_NOPUSH enables T/TCP and its presense used to mean that
T/TCP is possible on this system. Linux headers cannot
even contain TCP_NOPUSH.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
