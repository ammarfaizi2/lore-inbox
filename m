Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129745AbQLSSWY>; Tue, 19 Dec 2000 13:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130464AbQLSSWE>; Tue, 19 Dec 2000 13:22:04 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:46607 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129745AbQLSSV6>;
	Tue, 19 Dec 2000 13:21:58 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: ferret@phonewave.net
Date: Tue, 19 Dec 2000 18:49:09 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Startup IPI (was: Re: test13-pre3)
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@chiara.elte.hu
X-mailer: Pegasus Mail v3.40
Message-ID: <1021802F66E2@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Dec 00 at 21:59, ferret@phonewave.net wrote:
> 
> Pardon me for not fully groking the issues here and possibly coming to a
> wrong conclusion, but this has to do with SMP systems crashing at APIC
> init time, just before penguin display (with fbcon at least)? If so, I
> have a board that does this with certain cache settings made in the BIOS.
> It's a 430HX chipset with two Pentium MMX 200s installed, *ancient* BIOS.
 
I'm using BIOS dated 19/07/2000, last week it was latest BIOS on Gigabyte
site for 6VXD7 (two PIII/800). I did not looked for updates today yet.

I tried to change C2P Concurrency & Master (en/dis), AGP Mode (1x/2x/4x),
Power mgmt - Display Activity (monitor/ignore), PNP OS (yes/no)
(24 combinations total), but any combination dies if there are read
accesses to videoram during startup. Today I finally digged out some 
old ISA VGA (Realtek), plugged it in and - it dies too. So it does not 
depend on bus type.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                             
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
