Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130024AbRADWJp>; Thu, 4 Jan 2001 17:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131061AbRADWJf>; Thu, 4 Jan 2001 17:09:35 -0500
Received: from colorfullife.com ([216.156.138.34]:13574 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S130024AbRADWJV>;
	Thu, 4 Jan 2001 17:09:21 -0500
Message-ID: <3A54F49D.1584571A@colorfullife.com>
Date: Thu, 04 Jan 2001 23:09:33 +0100
From: Manfred <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: ilh@sls.lcs.mit.edu, linux-kernel@vger.kernel.org
Subject: Re: Dell Precision 330 (Pentium 4, i850 chipset, 3c905c)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Anybody get this working with 2.2.18 or 2.4.0-prerelease?
> I can't seem to get the on-board 3c905c to work.

Everything except the NIC works?

> I've seen it without an interrupt assignment in
> /proc/interrupts. With Red Hat's pump (DHCP), it sends 
> packets out but doesn't seem to see the response. 

What do you mean with "without an interrupt assignment"?
Is there no line for ethx in /proc/interrupt, or the number of
interrupts remains 0?

what does `lspic -vxx` say about the interrupt number?

Is there a BIOS setting similar to "Pnp aware OS"? For the 2.2 kernel
that must be "No", 2.2 might run with "Yes", but I'm not sure if the
850i board is supported.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
