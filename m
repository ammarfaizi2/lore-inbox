Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267621AbRGUMZx>; Sat, 21 Jul 2001 08:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267622AbRGUMZn>; Sat, 21 Jul 2001 08:25:43 -0400
Received: from tartarus.telenet-ops.be ([195.130.132.34]:25267 "HELO
	smtp2.pandora.be") by vger.kernel.org with SMTP id <S267621AbRGUMZf>;
	Sat, 21 Jul 2001 08:25:35 -0400
Date: Sat, 21 Jul 2001 14:25:39 +0200
From: Sven Vermeulen <sven.vermeulen@rug.ac.be>
To: Linux-kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: 2.4.7 build failure : esssolo1.c troubles
Message-ID: <20010721142539.A6276@Zenith.starcenter>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.4.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

gcc -D__KERNEL__ -I/home/nitro/src/linux-2.4.7/include -Wall \
  -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer \
  -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 \
  -march=k6    -c -o esssolo1.o esssolo1.c \
esssolo1.c:2455: warning: initialization from incompatible pointer type
esssolo1.c:2457: warning: initialization from incompatible pointer type

and

drivers/sound/sounddrivers.o: In function `solo1_probe':
drivers/sound/sounddrivers.o(.text.init+0x3ab): undefined reference to \
  `gameport_register_port'
drivers/sound/sounddrivers.o: In function `solo1_remove':
drivers/sound/sounddrivers.o(.text.init+0x4d7): undefined reference to \
  `gameport_unregister_port'
make: *** [vmlinux] Error 1


-- 
 Sven Vermeulen            -    Key-ID CDBA2FDB 
 LUG: http://www.lugwv.be  -    http://www.keyserver.net

