Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129060AbQKPEyF>; Wed, 15 Nov 2000 23:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129186AbQKPExq>; Wed, 15 Nov 2000 23:53:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:30606 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129147AbQKPExm>;
	Wed, 15 Nov 2000 23:53:42 -0500
Date: Wed, 15 Nov 2000 20:08:43 -0800
Message-Id: <200011160408.UAA09279@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: wtarreau@yahoo.fr
CC: adam@yggdrasil.com, willy@meta-x.org, linux-kernel@vger.kernel.org
In-Reply-To: <20001116011632.23521.qmail@web1106.mail.yahoo.com> (message from
	willy tarreau on Thu, 16 Nov 2000 02:16:32 +0100 (CET))
Subject: Re: 2.4.0-test11-pre5/drivers/net/sunhme.c compile failure on x86
In-Reply-To: <20001116011632.23521.qmail@web1106.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Thu, 16 Nov 2000 02:16:32 +0100 (CET)
   From: willy tarreau <wtarreau@yahoo.fr>

   I also had to move the #include <asm/uaccess.h>
   out of the #ifdef __sparc__/#endif because
   copy_{from|to}_user were left undefined (see
   simple patch below).

Applied, thanks.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
