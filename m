Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130006AbRAKNZx>; Thu, 11 Jan 2001 08:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130614AbRAKNZo>; Thu, 11 Jan 2001 08:25:44 -0500
Received: from zeus.kernel.org ([209.10.41.242]:40902 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130006AbRAKNZb>;
	Thu, 11 Jan 2001 08:25:31 -0500
Date: Sat, 5 Jan 2002 17:35:15 +0100 (CET)
From: David <davidge@jazzfree.com>
To: linux-kernel@vger.kernel.org
Subject: es1371 module dependencies problem
Message-ID: <Pine.LNX.4.21.0201051729040.952-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


kernel: 2.4.0
modutils: 2.3.23

loading the es1371 module gives me the following error:
/lib/modules/2.4.0/kernel/drivers/sound/es1371.o: unresolved symbol
ac97_probe_codec_Rsmp_1c61c357

soundcore.o loads ok, but es1371 not. Looking through the sources, i've
found that ac97_codec.c exports the symbol ac97_probe_codec. Why es1371
shows this error?

tia




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
