Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135905AbREIIeG>; Wed, 9 May 2001 04:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135902AbREIId4>; Wed, 9 May 2001 04:33:56 -0400
Received: from ip164-91.fli-ykh.psinet.ne.jp ([210.129.164.91]:53955 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S135901AbREIIdk>;
	Wed, 9 May 2001 04:33:40 -0400
Message-ID: <3AF900E0.DD2FA2B3@yk.rim.or.jp>
Date: Wed, 09 May 2001 17:33:36 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: SCSI Tape corruption - update
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


For comparison purposes,

I use stock kernel 2.4.4.
Use scsi tape support as module.
Tape drive is HP c1539 (aka 1533a) dds-2.
This drive is on the scsi chain of Tekram dc390, tmscsim driver
(used as module).
Hardware compression is enabled.

Under this setup,

    tar cvbf 20 /dev/st0 large_directory

works perfectly, and I can read it back without problem.

What software do you use for writing to tape?

Or maybe the problem is in the latest -ac tree only?

(HP has a software that checks the hardware installation and
drive health.
The software runs on Windows, and it supports firmware upgrade,
simple drive self-check, read/write check, etc. Highly recommended.
Obviously, the software is meant to help the HP tech support.
It generates a support ticket with the internal state of the firmware
media recoverable error statistics history and the like.

If the manufacturer of your tape drive has
a similar test software, you might want to check
the hardware using the vendor software.)



