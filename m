Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130836AbQLFUUz>; Wed, 6 Dec 2000 15:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131060AbQLFUUp>; Wed, 6 Dec 2000 15:20:45 -0500
Received: from k2.llnl.gov ([134.9.1.1]:21683 "EHLO k2.llnl.gov")
	by vger.kernel.org with ESMTP id <S130836AbQLFUUh>;
	Wed, 6 Dec 2000 15:20:37 -0500
Message-ID: <3A2E5227.693121F@scs.ch>
Date: Wed, 06 Dec 2000 06:50:15 -0800
From: Reto Baettig <baettig@scs.ch>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.17ext3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: 64bit offsets for block devices ?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Imagine we have a virtual disk which provides a 64bit (sparse) address
room. Unfortunately we can not use it as a block device because in a lot
of places (including buffer_head structure), we're using a long or even
an int for the block number. 

Is there any way of getting a standardized way of doing I/O to a block
device which could handle 64bit addresses for the block number?

Don't you think that we will run into problems anyway because soon there
will be raid systems with a couple of Terrabytes of space to waste for
mp3's ;-)

	Reto
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
