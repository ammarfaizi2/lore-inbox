Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbRGIQCM>; Mon, 9 Jul 2001 12:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262568AbRGIQCC>; Mon, 9 Jul 2001 12:02:02 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:23048 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S262389AbRGIQBr>;
	Mon, 9 Jul 2001 12:01:47 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: "Gary White (Network Administrator)" <admin@netpathway.com>
Date: Mon, 9 Jul 2001 18:00:51 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: VMWare crashes
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <82677BD2F89@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  9 Jul 01 at 9:49, Gary White (Network Administr wrote:
> I realize this may be a VMWare problem, but I just waited to
> bring this to the attention of the developers in case it was related
> to the kernel and to also see if anyone else is having the same
> problem. VMWare dies under load with all kernel versions up to and
> including ac versions after 2.4.6. Kernel version up to and including
> 2.4.5-ac15 I know all run fine. Somewhere between 2.4.5-ac15 and 2.4.6
> is where the problem started. I have backed up to 2.4.5 now and VMWare
> is rock solid.

> Unable to handle kernel NULL pointer dereference at virtual address 00000070
>  printing eip:
> e1af85e1
> Call Trace: [<c0203fe4>] [<c0203fe4>] [<c011722f>] [<c012eb26>] [<c0106dc3>]

Could you feed these oopeses through ksymoops? 

I'm now running vmware 24h/day with linux and win98 as guest, doing
network transfers between host and guest, and I did not noticed any problems.

It worked fine with 2.4.5-ac24 from wednesday to sunday, and yesterday
I upgraded to 2.4.6-ac2, and it still works. Kernel compiled with
Debian's gcc-3.0-3 or gcc-3.0-4, Asus A7V, KT133, 1GHz Athlon, and
Chaintech 6BTM, 440BX, 300MHz Celeron... I did not tested Linus's kernel
for more than 6 months now, so I cannot tell whether it works with Linus's
2.4.6, or not...
                                        Best regards,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
