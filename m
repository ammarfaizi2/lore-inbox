Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129590AbQKRRc0>; Sat, 18 Nov 2000 12:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129781AbQKRRcQ>; Sat, 18 Nov 2000 12:32:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3080 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129590AbQKRRb7>; Sat, 18 Nov 2000 12:31:59 -0500
Subject: Re: VGA PCI IO port reservations
To: hpa@zytor.com (H. Peter Anvin)
Date: Sat, 18 Nov 2000 17:02:00 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8v4oe5$vbl$1@cesium.transmeta.com> from "H. Peter Anvin" at Nov 17, 2000 06:10:13 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13xBNJ-0001r5-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is.  There are plenty of devices for which an arbitrary IN is an
> irrecoverable state transition.

The ne2000 clones being the most infamous of them. Blind ISA read probing is
not a safe business

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
