Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130609AbRBDLE7>; Sun, 4 Feb 2001 06:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131616AbRBDLE3>; Sun, 4 Feb 2001 06:04:29 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:31502 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130277AbRBDLEY>; Sun, 4 Feb 2001 06:04:24 -0500
Subject: Re: PS hanging in 2.4.1 - More interesting things
To: Shawn.Starr@Home.net (Shawn Starr)
Date: Sun, 4 Feb 2001 11:05:25 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A7C9638.63C513D0@Home.net> from "Shawn Starr" at Feb 03, 2001 06:37:28 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14PMz2-0001NA-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, I rebooted the system, then syslogd was using 100% cpu?
> it seems like perhaps reiserfs is causing this problem??

Typically it means your syslogd (klogd actually) is too old and has a bug that
a 0 length printk causes it to spin.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
