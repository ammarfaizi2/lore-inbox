Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129266AbRBLRQI>; Mon, 12 Feb 2001 12:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129465AbRBLRP7>; Mon, 12 Feb 2001 12:15:59 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:11200 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S129266AbRBLRPo>; Mon, 12 Feb 2001 12:15:44 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andre Hedrick <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: ide_revalidate_disk() fix
Date: Mon, 12 Feb 2001 18:15:24 +0100
Message-Id: <19350107104708.11287@mailhost.mipsys.com>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre !

Any reason other than usual programmer "too many things to remember" for
2.4 lacking the small ide_revalidate_disk() fix we did recently in 2.2 to
keep the blocksize of the device intact ? (Just diff the 2 functions,
it's pretty obvious)

I'd be glad to send Linus a patch, but I beleive he won't accept an ide.c
patch that doesn't originate from you ;)

Regards,
Ben.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
