Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286871AbSANOdZ>; Mon, 14 Jan 2002 09:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286647AbSANOdL>; Mon, 14 Jan 2002 09:33:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:10515 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286934AbSANOc1>; Mon, 14 Jan 2002 09:32:27 -0500
Subject: Re: Problem with ServerWorks CNB20LE and lost interrupts
To: zwane@linux.realnet.co.sz (Zwane Mwaikambo)
Date: Mon, 14 Jan 2002 14:43:18 +0000 (GMT)
Cc: macro@ds2.pg.gda.pl (Maciej W. Rozycki), jim@federated.com (Jim Studt),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <Pine.LNX.4.33.0201141622120.9308-100000@netfinity.realnet.co.sz> from "Zwane Mwaikambo" at Jan 14, 2002 04:23:22 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Q8KU-0001t7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 14 Jan 2002, Maciej W. Rozycki wrote:
> 
> >  The "noapic" option should probably get removed -- it was meant as a
> > debugging aid (as many of the "no*" options) at the early days of I/O APIC
> > support, I believe...  Now the support is pretty stable.
> 
> Oooooh that will break a _lot_ of boxes! Otherwise i agree wholeheartedly.

noapic seems to be needed by a measurable number of boxes, many of which the
BIOS vendor will never fix or has refused to fix or assist in correcting.

