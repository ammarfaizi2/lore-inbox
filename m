Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131489AbQLVSlr>; Fri, 22 Dec 2000 13:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131370AbQLVSli>; Fri, 22 Dec 2000 13:41:38 -0500
Received: from h24-65-192-120.cg.shawcable.net ([24.65.192.120]:38908 "EHLO
	webber.adilger.net") by vger.kernel.org with ESMTP
	id <S129870AbQLVSlZ>; Fri, 22 Dec 2000 13:41:25 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200012221809.eBMI9jA27136@webber.adilger.net>
Subject: Re: recommended gcc compiler version
In-Reply-To: <200012220700.XAA09901@pobox.com> "from Barry K. Nathan at Dec 21,
 2000 11:00:46 pm"
To: barryn@pobox.com
Date: Fri, 22 Dec 2000 11:09:45 -0700 (MST)
CC: "Robert B. Easter" <reaster@comptechnews.com>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry writes:
> > Linux 2.2.18?
> 
> gcc 2.7.2.3 is safest, but egcs 1.1.2 should be safe even for
> mission-critical stuff. gcc 2.95.2 seems to work for many people, but
> isn't necessarily safe.

Speaking of this - I had problems with a gcc 2.95.2 compiled 2.2.18+IDE patch,
yet the same kernel compiled with egcs is OK.  On one system the 2.95.2
kernel complained at partition checking time, but seemed to work OK, and
on an SMP box, the kernel would just panic at partition checking time.

If anyone is interested in looking at this (gcc folks or whatever), I
have KDB in that kernel and can send you a stack trace at the panic.
Otherwise, I'll just stick with egcs.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
