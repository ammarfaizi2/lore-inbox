Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131706AbQKNXiz>; Tue, 14 Nov 2000 18:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131710AbQKNXip>; Tue, 14 Nov 2000 18:38:45 -0500
Received: from boss.staszic.waw.pl ([195.205.163.66]:8456 "EHLO
	boss.staszic.waw.pl") by vger.kernel.org with ESMTP
	id <S131706AbQKNXi2>; Tue, 14 Nov 2000 18:38:28 -0500
Date: Wed, 15 Nov 2000 00:08:52 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <dake@staszic.waw.pl>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [uPATCH] Re: test11-pre5
In-Reply-To: <Pine.LNX.4.10.10011141346480.15149-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0011150006460.4963-100000@tricky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2000, Linus Torvalds wrote:
>  - pre5:
>     - Rasmus Andersen: add proper "<linux/init.h>" for sound drivers

Rasmus spotted gus_midi.c not 100% correctly... (anyway thanks Rasmus)

--- linux-240t10p5/drivers/sound/gus_midi.c	Wed Nov 15 00:06:14 2000
+++ linux/drivers/sound/gus_midi.c	Wed Nov 15 00:06:24 2000
@@ -15,7 +15,7 @@
  *		Added __init to gus_midi_init()
  */
 
-#include "linux/init.h"
+#include <linux/init.h>
 #include "sound_config.h"
 
 #include "gus.h"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
