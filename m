Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131220AbQLUSEc>; Thu, 21 Dec 2000 13:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131256AbQLUSEX>; Thu, 21 Dec 2000 13:04:23 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46094 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131220AbQLUSEH>; Thu, 21 Dec 2000 13:04:07 -0500
Subject: Re: [PATCH] few fixes for ymf_sb.c in test13pre3-ac3
To: proski@gnu.org (Pavel Roskin)
Date: Thu, 21 Dec 2000 17:36:16 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <Pine.LNX.4.30.0012211152490.2220-100000@fonzie.nine.com> from "Pavel Roskin" at Dec 21, 2000 12:27:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1499dZ-0003Li-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CONFIG_SOUND_YMFPCI is declared twice - once outside CONFIG_OSS, then
> inside CONFIG_OSS. I'm removing the later declaration.

Its an in progress thing. The next stage is to remove ymf_sb completely as
we have done in 2.2.19pre and to put the ymf_sb midi magic into it

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
