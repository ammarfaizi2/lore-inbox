Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129835AbQKTNQA>; Mon, 20 Nov 2000 08:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130472AbQKTNPu>; Mon, 20 Nov 2000 08:15:50 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12078 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129835AbQKTNPj>; Mon, 20 Nov 2000 08:15:39 -0500
Subject: Re: 2.4.0-test11-pre7: isapnp hang
To: hpa@zytor.com (H. Peter Anvin)
Date: Mon, 20 Nov 2000 12:45:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8v9uc1$5c5$1@cesium.transmeta.com> from "H. Peter Anvin" at Nov 19, 2000 05:22:09 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13xqKI-0003bd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems to me that it would be better to initialize all the (non-PnP)
> ISA cards first, and have them claim their preferred ranges.  Now you
> can pick the PnP isolate port out of what is left, and also have a
> much better idea of what is available.

Post 2.4 only. It means re-architecting all the ISA probes so that they don't
mix the PnP and non PnP probes. I suspect implementing a copy of the PCI
hot swap API would be the simplest



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
