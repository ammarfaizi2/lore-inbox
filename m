Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262548AbUKLPOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262548AbUKLPOO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 10:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262550AbUKLPOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 10:14:14 -0500
Received: from fmmailgate04.web.de ([217.72.192.242]:60564 "EHLO
	fmmailgate04.web.de") by vger.kernel.org with ESMTP id S262548AbUKLPOL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 10:14:11 -0500
Date: Fri, 12 Nov 2004 16:14:09 +0100
Message-Id: <683491845@web.de>
MIME-Version: 1.0
From: "Enrico Bartky" <DOSProfi@web.de>
To: linux-kernel@vger.kernel.org
Subject: PROMISE Ultra133 TX2 (PDC20269)
Organization: http://freemail.web.de/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have the following problem with my controller:

I have attached a 8 GB UDMA4 Harddisk, but it works only with UDMA2. The controller BIOS displays the right mode (4), but in the kernel dmesg it comes with pio. after i execute hdparm -I /dev/hde it says:

... udma2* udma3 udma4

If I try to force the UDMA4 mode with hdparm -Xudma4 /dev/hde , ... theres no difference. The harddisk leaves at udma2.

What can I do?
I have tried 2.4.26, 2.6.9, 2.6.10-rc1...

Can you help me?

Thanx, EnricoB
________________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt neu bei WEB.DE FreeMail: http://freemail.web.de/?mc=021193

