Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317374AbSGZIpK>; Fri, 26 Jul 2002 04:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317381AbSGZIpK>; Fri, 26 Jul 2002 04:45:10 -0400
Received: from [195.63.194.11] ([195.63.194.11]:42759 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317374AbSGZIpJ>; Fri, 26 Jul 2002 04:45:09 -0400
Message-ID: <3D410BA9.2090202@evision.ag>
Date: Fri, 26 Jul 2002 10:43:21 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] IDE 106
References: <Pine.LNX.4.33.0207241410040.3542-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------080007050601030500020209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080007050601030500020209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Small missing notch.

--------------080007050601030500020209
Content-Type: text/plain;
 name="ide-106.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-106.diff"

diff -durNp -x '*.[ao]' -x '*~' -x '*.cmd' -x '*.orig' -x '*.rej' -x 'vmlinu*' -x bzImage -x bootsect -x conmakehash -x setup -x build -x asm -x config -x '.*' -x consolemap_deftbl.c -x defkeymap.c -x devlist.h -x classlist.h -x autoconf.h -x compile.h -x version.h -x System.map -x gen-devlist -x fixdep -x split-include linux-2.5.28/drivers/ide/main.c linux/drivers/ide/main.c
--- linux-2.5.28/drivers/ide/main.c	2002-07-26 09:50:44.000000000 +0200
+++ linux/drivers/ide/main.c	2002-07-26 10:15:57.000000000 +0200
@@ -1069,7 +1069,6 @@ int ide_register_subdriver(struct ata_de
 
 	}
 	drive->revalidate = 1;
-	drive->suspend_reset = 0;
 
 	return 0;
 }

--------------080007050601030500020209--

