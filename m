Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130870AbRAIOdR>; Tue, 9 Jan 2001 09:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131088AbRAIOdH>; Tue, 9 Jan 2001 09:33:07 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:59147 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130870AbRAIOcs>; Tue, 9 Jan 2001 09:32:48 -0500
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
To: sct@redhat.com (Stephen C. Tweedie)
Date: Tue, 9 Jan 2001 14:33:13 +0000 (GMT)
Cc: mingo@elte.hu (Ingo Molnar), hch@caldera.de (Christoph Hellwig),
        davem@redhat.com (David S. Miller), riel@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
        sct@redhat.com (Stephen Tweedie)
In-Reply-To: <20010109142542.G4284@redhat.com> from "Stephen C. Tweedie" at Jan 09, 2001 02:25:42 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Fzpr-0006ij-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Bad bad bad.  We already have SCSI devices optimised for bandwidth
> which don't approach decent performance until you are passing them 1MB
> IOs, and even in networking the 1.5K packet limit kills us in some

Even low end cheap raid cards like the AMI megaraid dearly want 128K writes.
Its quite a difference on them

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
