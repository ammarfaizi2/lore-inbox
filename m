Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129935AbQKVSdf>; Wed, 22 Nov 2000 13:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129625AbQKVSdZ>; Wed, 22 Nov 2000 13:33:25 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:35087 "EHLO
        neon-gw.transmeta.com") by vger.kernel.org with ESMTP
        id <S129248AbQKVSdT>; Wed, 22 Nov 2000 13:33:19 -0500
Message-ID: <3A1C0A4A.62694193@transmeta.com>
Date: Wed, 22 Nov 2000 10:02:50 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: macro@ds2.pg.gda.pl, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@chiara.elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11-ac1
In-Reply-To: <E13ye9w-0006FS-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > >     if(vendor!=INTEL && !has_apic)
> > >             /* No SMP */
> >
> >  And suddenly certain i486 systems do not work anymore?  Well, I haven't
> 
> i486 is an intel processor
> 

... but doesn't announce itself as such.

> >       if (boot_cpu_id != -1U
> >           && APIC_INTEGRATED(apic_version[boot_cpu_id]) && !has_apic)
> >               /* No SMP */
> >
> > It should filter broken MP-tables and work fine on all 82489DX-based
> > systems.  I'll have a patch soon if we agree on this solution.
> 
> we could try that. It doesnt seem unreasonable

Seems reasonable enough.

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
