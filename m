Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129266AbQKBW52>; Thu, 2 Nov 2000 17:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129285AbQKBW5S>; Thu, 2 Nov 2000 17:57:18 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10578 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129266AbQKBW5I>; Thu, 2 Nov 2000 17:57:08 -0500
Subject: Re: select() bug
To: pmarquis@iname.com (Paul Marquis)
Date: Thu, 2 Nov 2000 22:58:23 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3A01F07C.1DB597CE@iname.com> from "Paul Marquis" at Nov 02, 2000 05:53:48 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rTJQ-00021U-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I guess in theory, you're right, though if a write() could succeed,
> shouldn't select() say that it would?

Thats certainly not normal for a lot of devices.  Most fast devices wake up
when buffers are half empty for example.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
