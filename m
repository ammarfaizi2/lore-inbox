Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBLKhl>; Mon, 12 Feb 2001 05:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129529AbRBLKhb>; Mon, 12 Feb 2001 05:37:31 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21777 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129237AbRBLKhQ>; Mon, 12 Feb 2001 05:37:16 -0500
Subject: Re: [OT] Major Clock Drift
To: pavel@suse.cz (Pavel Machek)
Date: Mon, 12 Feb 2001 10:36:51 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), andrewm@uow.edu.au (Andrew Morton),
        teastep@seattlefirewall.dyndns.org (Tom Eastep),
        fd0man@crosswinds.net (Michael B. Trausch),
        jbm@joshisanerd.com (Josh Myer), linux-kernel@vger.kernel.org
In-Reply-To: <20010212113213.B235@bug.ucw.cz> from "Pavel Machek" at Feb 12, 2001 11:32:13 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14SGLm-0006es-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 			queued_writes=1;
> > 			return;
> > 		}
> > 	}
> 
> Unfortunately, that means that if machine crashes in interrupt, it may
> "loose" printk message. That is considered bad (tm).

The alternative is that the machine clock slides continually and the machine
is unusable. This is considered even worse by most people
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
