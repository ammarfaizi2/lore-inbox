Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129248AbQKVSuR>; Wed, 22 Nov 2000 13:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129703AbQKVSuH>; Wed, 22 Nov 2000 13:50:07 -0500
Received: from [204.176.206.253] ([204.176.206.253]:9234 "EHLO
        cerberus.infinium.com") by vger.kernel.org with ESMTP
        id <S129521AbQKVSty>; Wed, 22 Nov 2000 13:49:54 -0500
Subject: Re: Linux 2.4.0test11-ac1
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OFB83F6CD5.A326D1F5-ON8525699F.00641A3D@infinium.com>
Date: Wed, 22 Nov 2000 13:18:00 -0500
X-MIMETrack: Serialize by Router on WHQNTSE1/Infinium Software(Release 5.0.4 |June 8, 2000) at
 11/22/2000 01:18:04 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
To: "H. Peter Anvin" <hpa@transmeta.com>
From: Bruce_Holzrichter@infinium.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, linux-kernel-owner@vger.kernel.org,
        macro@ds2.pg.gda.pl, Ingo Molnar <mingo@chiara.elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I am a relative newcomer to Linux and recently watching the kernel lists.
FWIW, I have a quad Pentium 100 HP netserver that will panic kernel 2.2.x
and 2.4.x (last checked with 2.4 test9) when bios APIC is turned on.  I
know this is not related to what your talking about, and that these are
probably rare systems, but I thought I would let you know.

Thanks,
Bruce H.


                                                                                                 
                    "H. Peter Anvin"                                                             
                    <hpa@transmeta.com>             To:     Alan Cox <alan@lxorguk.ukuu.org.uk>  
                    Sent by:                        cc:     macro@ds2.pg.gda.pl, "H. Peter       
                    linux-kernel-owner@vger.        Anvin" <hpa@zytor.com>, Ingo Molnar          
                    kernel.org                      <mingo@chiara.elte.hu>,                      
                                                    linux-kernel@vger.kernel.org                 
                                                    Subject:     Re: Linux 2.4.0test11-ac1       
                    11/22/2000 01:02 PM                                                          
                                                                                                 
                                                                                                 




Alan Cox wrote:
>
> > >     if(vendor!=INTEL && !has_apic)
> > >             /* No SMP */
> >
> >  And suddenly certain i486 systems do not work anymore?  Well, I
haven't
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



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
