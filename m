Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273620AbRIURBd>; Fri, 21 Sep 2001 13:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273625AbRIURBM>; Fri, 21 Sep 2001 13:01:12 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:41738 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S273620AbRIURBE>;
	Fri, 21 Sep 2001 13:01:04 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Luigi Genoni <kernel@Expansa.sns.it>
Date: Fri, 21 Sep 2001 19:01:06 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: spurious interrupt with ac kernel but not with vanilla 
CC: Linux Kernel <linux-kernel@vger.kernel.org>, alan@lxorguk.ukuu.org.uk
X-mailer: Pegasus Mail v3.40
Message-ID: <41B7E064ABA@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Sep 01 at 18:39, Luigi Genoni wrote:
> I noticed that on the abit kt7A MBs that i have, with via KT133A chipset,
> after i installed the kernel 2.4.9-ac10 (ac11 and 12 as well),
> at boot i get this message,
> 
> Sep 21 11:52:11 DarkStar kernel: ice 00:0b.0
> Sep 21 11:52:11 DarkStar kernel: spurious 8259A interrupt: IRQ7.
>  immediatelly before scsi adaptec detection and inizzializzation.

This happens to me too (Asus A7V, KT133). It happens since I remember -
at least since Christmas, and for me it happens after unspecified time
after boot - varying from few seconds (during initscripts) to few
minutes. After it happens once, everything is apparently satisified
and no more spurious interrupts occurs (until next reboot). I always 
assumed that it is broken VIA again...
                                    Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
