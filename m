Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131264AbQL1VrF>; Thu, 28 Dec 2000 16:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131914AbQL1Vqz>; Thu, 28 Dec 2000 16:46:55 -0500
Received: from ANancy-101-1-1-133.abo.wanadoo.fr ([193.251.70.133]:44038 "HELO
	the-truth.nobis.phear.org") by vger.kernel.org with SMTP
	id <S131264AbQL1Vqo>; Thu, 28 Dec 2000 16:46:44 -0500
Message-ID: <20001228211937.7175.qmail@the-truth.nobis.phear.org>
From: Pixel@the-truth.nobis.phear.org
Subject: New driver
To: linux-kernel@vger.kernel.org
Date: Thu, 28 Dec 2000 22:19:37 +0100 (CET)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I've just joined this mailing-list so forgive-me if I do some mistakes.

I've done a little add-on to the linux kernel source in order to build
directly the driver for the em8300 chip. This chip is the main chip
of the DXR3 and Hollywood Plus mpeg decompression cards. Since now, the
source of this driver was an external source tree and it builded four
modules that drives the cards. But since the major update of the
2.4.0's Makefiles, it wasn't able to compile up.

As I really wanted to use both of them, I tried my best to make it
working and it cames into a patch against the linux-2.4.0-test13-pre4
kernel.

It adds a new section into the configuration tree in order to support
the mpeg decompression cards. And so it builds correctly this driver.

I wanted to share what I've done but since I'm very new to kernel hacking
I don't know what to do with my patch. Could you give me some hints?

Thanks!

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
