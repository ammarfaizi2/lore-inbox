Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131731AbQKUXzs>; Tue, 21 Nov 2000 18:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131763AbQKUXzi>; Tue, 21 Nov 2000 18:55:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59474 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131731AbQKUXzY>; Tue, 21 Nov 2000 18:55:24 -0500
Subject: Re: Linux 2.4.0test11-ac1
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Tue, 21 Nov 2000 23:25:44 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3A1AC4E1.80E5F423@mandrakesoft.com> from "Jeff Garzik" at Nov 21, 2000 01:54:25 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yMnL-0005Ky-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > o       Cleanup console_verbose() dunplication
> include/linux/kernel.h:  if we are adding new inlines to kernel headers,
> they should be 'static inline'..

Agreed

> > o       Epic100 update
> 
> dhinds seemed to question the epic100 fix which is enclosed in
> CONFIG_CARDBUS...  also I have a big endian fix for epic100 in my local
> tree.

I dont think its CONFIG_CARDBUS, we need to test the chip version. But
as it stands without that newer cards dont work. Its a WiP

> The change to hp-plus is totally unnecessary and backwards... 
> [un]load_8390_module is null, has been for a while.  A bombing run was
> made recently through most drivers to -remove- the now-null calls to
> *_8390_module.

Thats just cruft, already done

> > o       Tulip crash fix on weird eeproms
> Hopefully an update with this and more will be out this week.

Ok

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
