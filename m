Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129777AbQKVSa4>; Wed, 22 Nov 2000 13:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129248AbQKVSaq>; Wed, 22 Nov 2000 13:30:46 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52587 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129703AbQKVSad>; Wed, 22 Nov 2000 13:30:33 -0500
Subject: Re: Linux 2.4.0test11-ac1
To: macro@ds2.pg.gda.pl
Date: Wed, 22 Nov 2000 17:58:14 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), hpa@zytor.com (H. Peter Anvin),
        mingo@chiara.elte.hu (Ingo Molnar), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.3.96.1001122175514.29041A-100000@delta.ds2.pg.gda.pl> from "Maciej W. Rozycki" at Nov 22, 2000 06:49:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13ye9w-0006FS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 	if(vendor!=INTEL && !has_apic)
> > 		/* No SMP */
> 
>  And suddenly certain i486 systems do not work anymore?  Well, I haven't

i486 is an intel processor

> 	if (boot_cpu_id != -1U
> 	    && APIC_INTEGRATED(apic_version[boot_cpu_id]) && !has_apic)
> 		/* No SMP */
> 
> It should filter broken MP-tables and work fine on all 82489DX-based
> systems.  I'll have a patch soon if we agree on this solution.

we could try that. It doesnt seem unreasonable

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
