Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRADWOZ>; Thu, 4 Jan 2001 17:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130882AbRADWOH>; Thu, 4 Jan 2001 17:14:07 -0500
Received: from sls.lcs.mit.edu ([18.27.0.167]:64231 "EHLO sls.lcs.mit.edu")
	by vger.kernel.org with ESMTP id <S129183AbRADWNq>;
	Thu, 4 Jan 2001 17:13:46 -0500
Message-ID: <3A54F593.C3C548E3@sls.lcs.mit.edu>
Date: Thu, 04 Jan 2001 17:13:39 -0500
From: I Lee Hetherington <ilh@sls.lcs.mit.edu>
Organization: MIT Laboratory for Computer Science
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.18-pre25.1.smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Dell Precision 330 (Pentium 4, i850 chipset, 3c905c)
In-Reply-To: <3A54F49D.1584571A@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred wrote:

> Everything except the NIC works?

Yes.

> What do you mean with "without an interrupt assignment"?
> Is there no line for ethx in /proc/interrupt, or the number of
> interrupts remains 0?

There is no entry for eth0 anywhere in /proc/interrupts.  That seems
strange.

> what does `lspic -vxx` say about the interrupt number?

lspci -v says IRQ 11, which is what the BIOS says.  This is also what
I see in dmesg when eth0 is found.

> Is there a BIOS setting similar to "Pnp aware OS"? For the 2.2 kernel
> that must be "No", 2.2 might run with "Yes", but I'm not sure if the
> 850i board is supported.

I'll look into this.

Thanks.

--Lee Hetherington


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
