Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130342AbQJ0AxM>; Thu, 26 Oct 2000 20:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130415AbQJ0AxC>; Thu, 26 Oct 2000 20:53:02 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47698 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130342AbQJ0Awt>; Thu, 26 Oct 2000 20:52:49 -0400
Subject: Re: [PATCH] make my life easier ...
To: torvalds@transmeta.com (Linus Torvalds)
Date: Fri, 27 Oct 2000 01:52:56 +0100 (BST)
Cc: sfr@linuxcare.com.au (Stephen Rothwell),
        andre@linux-ide.org (Andre Hedrick), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox), mlord@pobox.com (Mark Lord)
In-Reply-To: <Pine.LNX.4.10.10010260829150.2335-100000@penguin.transmeta.com> from "Linus Torvalds" at Oct 26, 2000 08:31:34 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13oxlT-00042A-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> certainly accept it), then why not just do the equivalent of a reset in
> the high-level IDE driver on coming back from sleep? Possibly together
> with forcing any other setup state we know about.

Because windows seems to drop the controller back to PIO mode 0 and the BIOS
knows about it. At least in the palmax case, although since 2.4test doesnt
boot on it as of pre9 I've not tried the 2.4 patches yet.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
