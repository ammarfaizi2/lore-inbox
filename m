Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292419AbSBZRav>; Tue, 26 Feb 2002 12:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292418AbSBZRaf>; Tue, 26 Feb 2002 12:30:35 -0500
Received: from L1180P04.dipool.highway.telekom.at ([62.46.211.100]:39176 "HELO
	the-happy-freaks") by vger.kernel.org with SMTP id <S292415AbSBZRaR>;
	Tue, 26 Feb 2002 12:30:17 -0500
Date: Tue, 26 Feb 2002 18:30:18 +0100
From: Clemens Kirchgatterer <clemens@thf.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: strange behaviour difference of scsi driver aha152x in 2.4.x and 2.2.x
Message-Id: <20020226183018.730eb0ca.clemens@thf.ath.cx>
Organization: The Happy Freaks
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i had a very hard time to get my old microtek scanmaker e3 scanner to
work on an ava1502 isa scsi controller under linux 2.4.17. host adapter
was allways detected correctly, but never the scanner. i tried to
change some timeout values within the kernel driver, but this wild
guessing didn't change anything. today i tired kernel 2.2.20. and it
seemed to work at first sight, as it reported the scanner at bootup, but
refused to start init with FATAL: kernel to old. (maybe a drm problem?)
anyway. i rebooted with 2.4.17 and this time the scanner was detected
without problems. this looks like the scsi bus has been initialized
slightly diffrent with the 2.2 kernel, what made it work under 2.4
afterwards.

is this something that can be fixed? or ain't it broken, anyway? i'm
willing to provide any information i can, if somebody wants to have a
look at this.

best regards ...
clemens
