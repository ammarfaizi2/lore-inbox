Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQKEUR4>; Sun, 5 Nov 2000 15:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129692AbQKEURr>; Sun, 5 Nov 2000 15:17:47 -0500
Received: from femail6.sdc1.sfba.home.com ([24.0.95.86]:4315 "EHLO
	femail6.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S129210AbQKEURl>; Sun, 5 Nov 2000 15:17:41 -0500
Date: Sun, 5 Nov 2000 15:17:25 -0500
From: Ari Pollak <compwiz@bigfoot.com>
To: linux-kernel@vger.kernel.org
Subject: scd/ide-scsi reporting size incorrectly
Message-ID: <20001105151725.A27278@darth.ns>
Mail-Followup-To: Ari Pollak <compwiz>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux darth.ns 2.4.0-test10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey. I'm using an Acer 50X cdrom used with scd & ide-scsi emulation, and
I just noticed that 'df' is reporting size incorrectly:
/dev/scd1                85946     85946         0 100% /mnt/cdrom

Even though du clearly shows there is much more than 85 MB used:
$ du -s /mnt/cdrom
359397	/mnt/cdrom

Is this a known bug?

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
