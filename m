Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130530AbQKCPiC>; Fri, 3 Nov 2000 10:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130553AbQKCPhw>; Fri, 3 Nov 2000 10:37:52 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11384 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130530AbQKCPhq>; Fri, 3 Nov 2000 10:37:46 -0500
Subject: Re: ext3 vs. JFS file locations...
To: michael.boman@usa.net (Michael Boman)
Date: Fri, 3 Nov 2000 15:38:56 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A02D150.E7E87398@usa.net> from "Michael Boman" at Nov 03, 2000 10:53:04 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13rivh-0003bS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems like both IBM's JFS and ext3 wants to use fs/jfs .. IMHO that
> is like asking for problem.. A more logic location for ext3 should be
> fs/ext3, no?

fs/jfs is the general purpose journalling layer. Of course while thats very
sensible it does clash with the ibm jfs. Maybe fs/journalling is needed ?



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
