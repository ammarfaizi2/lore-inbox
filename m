Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbRALRCd>; Fri, 12 Jan 2001 12:02:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130846AbRALRCW>; Fri, 12 Jan 2001 12:02:22 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:10114 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S129773AbRALRCT>; Fri, 12 Jan 2001 12:02:19 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3A5F3697.38DEA1FE@colorfullife.com> 
In-Reply-To: <3A5F3697.38DEA1FE@colorfullife.com> 
To: Manfred Spraul <manfred@colorfullife.com>
Cc: frank@unternet.org, linux-kernel@vger.kernel.org
Subject: Re: QUESTION: Network hangs with BP6 and 2.4.x kernels, hardware related? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Jan 2001 17:02:02 +0000
Message-ID: <26987.979318922@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



manfred@colorfullife.com said:
> IRR for interrupt 19 is set, that means the IO APIC has sent the
> interrupt to a cpu but not yet received the corresponding EOI.

OK, but couldn't we reset it by sending an extra EOI when the drivers 
decide that they've missed interrupts?

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
