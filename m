Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130073AbQK3QRm>; Thu, 30 Nov 2000 11:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130083AbQK3QRe>; Thu, 30 Nov 2000 11:17:34 -0500
Received: from u-code.de ([207.159.137.250]:11752 "EHLO u-code.de")
        by vger.kernel.org with ESMTP id <S130073AbQK3QRU>;
        Thu, 30 Nov 2000 11:17:20 -0500
From: Eckhard Jokisch <e.jokisch@u-code.de>
Reply-To: e.jokisch@u-code.de
Organization: u-code
To: linux-kernel@vger.kernel.org
Subject: IDE_TAPE problem wiht ONSTREAM DI30
Date: Thu, 30 Nov 2000 16:26:09 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: gadio@netvision.net.il
MIME-Version: 1.0
Message-Id: <00113016484200.11054@eckhard>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried the ide-tape driver for several weeks now. And after some time during
writing or reading tar stops because of errors.

Error messages are:
Nov 30 15:32:20  kernel: ide-tape: ht0: I/O error, pc =  8, key =  0,
asc =  0, ascq =  2 Nov 30 15:32:25 eckhard last message repeated 1000 times
Nov 30 15:32:25  kernel: ide-tape: ht0: unrecovered read error on logical block number 461706, skipping
Nov 30 15:32:25  kernel: ide-tape: ht0: I/O error, pc =  8, key =  0, asc =  0, ascq =  2
Nov 30 15:32:31  last message repeated 1000 times
Nov 30 15:32:31  kernel: ide-tape: ht0: unrecovered read error on logical block number 461707, skipping
Nov 30 15:32:31  kernel: ide-tape: ht0: I/O error, pc =  8, key =  0, asc =  0, ascq =  2 

I tried to switch of pipelining by setting the parameters in ide-tape.c to 0
but it didn't help too much ( the error seems to raise later :-(

This happens with 2.2.14, 2.2.17 and 2.4.test11 on SuSE-Linux6.4.

I would really like to help finding the reason for this despite it takes a lot
of time to fill a complete tape with tar. 
Please - what's going on there? 

Eckhard Jokisch



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
