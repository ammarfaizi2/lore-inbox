Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbQKFLCx>; Mon, 6 Nov 2000 06:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129098AbQKFLCo>; Mon, 6 Nov 2000 06:02:44 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12876 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129053AbQKFLCa>; Mon, 6 Nov 2000 06:02:30 -0500
Subject: Re: [PATCH] document ECN in 2.4 Configure.help
To: andrewm@uow.edu.au (Andrew Morton)
Date: Mon, 6 Nov 2000 11:02:47 +0000 (GMT)
Cc: oxymoron@waste.org (Oliver Xymoron), barryn@pobox.com,
        linux-kernel@vger.kernel.org, hadi@cyberus.ca (jamal)
In-Reply-To: <3A068C00.272BD5D2@uow.edu.au> from "Andrew Morton" at Nov 06, 2000 09:46:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13sk36-00066o-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>        with the TCP ECN_ECHO and CWR flags set, to indicate
>        ECN-capability, then the sender should send its second
>        SYN packet without these flags set. This is because

Now that is nice. The end user perceived effect is that folks with faulty 
firewalls have horrible slow web sites with a 3 or 4 second wait for each
page. The perfect incentive. If only someone could do the same to path mtu
discovery incompetents.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
