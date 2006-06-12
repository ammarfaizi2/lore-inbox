Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWFLSCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWFLSCv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWFLSCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:02:51 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:22436 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750877AbWFLSCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:02:51 -0400
Date: Mon, 12 Jun 2006 20:02:49 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Karel Kulhavy <clock@twibright.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PC card RS-232 freezes the computer
In-Reply-To: <20060612130841.GA16993@kestrel.barix.local>
Message-ID: <Pine.LNX.4.61.0606122001550.7959@yvahk01.tjqt.qr>
References: <20060612130841.GA16993@kestrel.barix.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hello
>
>When I insert "2 port RS-232" PC card/PCMCIA/carbus/whatever card
>(86x53x6mm with a golden strip with 8 nipples and 2x34 connector) into my
>Dell Inspiron 510m notebook with 2.6.16.19, the computer freezes and
>continues working when I remove it.
>
Try enabling CONFIG_ISA. I experienced the same lockup with a PCMCIA 
IDE CDROM drive and it was solved by enabling that one.

>The card label says "2 port RS-232 SUNIX Plug Into A Brand-new World
>S/N: CB 0077996 Made in Taiwan"
>
>XMMS before freezing plays last 300ms 3 times again.
>
>dmesg shows
>pccard: CardBus card inserted into slot 0
>pccard: card ejected from slot 0
>MCE: The hardware reports a non fatal, correctable incident occurred on
>CPU 0.
>Bank 0: b200004000000800
>
>Is the kernel intended to behave this way? If yes, is there a way how
>to configure up the kernel so the computer doesn't freeze and the card
>can be examined with lspci?
>
>CL<
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

Jan Engelhardt
-- 
| Software Engineer and Linux/Unix Network Administrator
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
