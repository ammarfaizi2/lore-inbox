Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129566AbQKNAmE>; Mon, 13 Nov 2000 19:42:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130399AbQKNAly>; Mon, 13 Nov 2000 19:41:54 -0500
Received: from as3-3-4.ml.g.bonet.se ([194.236.33.69]:47108 "EHLO
	tellus.mine.nu") by vger.kernel.org with ESMTP id <S129566AbQKNAlt>;
	Mon, 13 Nov 2000 19:41:49 -0500
Date: Tue, 14 Nov 2000 01:11:42 +0100 (CET)
From: Tobias Ringstrom <tori@tellus.mine.nu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: tulip memory leak
Message-ID: <Pine.LNX.4.21.0011140107470.20014-100000@svea.tellus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There might be a small memory leak in the tulip driver since tp->mtable
allocated in eeprom.c around line 172 is never freed.

/Tobias


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
