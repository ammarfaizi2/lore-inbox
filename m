Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319047AbSHFK1U>; Tue, 6 Aug 2002 06:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319048AbSHFK1U>; Tue, 6 Aug 2002 06:27:20 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:38416 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S319047AbSHFK1R>;
	Tue, 6 Aug 2002 06:27:17 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Bill Davidsen <davidsen@tmr.com>
Date: Tue, 6 Aug 2002 12:28:42 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] pdc20265 problem.
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Nick Orlov <nick.orlov@mail.ru>, lkml <linux-kernel@vger.kernel.org>,
       b.zolnierkiewitz@elka.pw.edu.pl
X-mailer: Pegasus Mail v3.50
Message-ID: <13AAA8A2687@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  5 Aug 02 at 23:48, Bill Davidsen wrote:
> On Sat, 3 Aug 2002, Bartlomiej Zolnierkiewicz wrote:
> 
> > And second problem is that 20265 is used as primary onboard
> > sometimes and sometimes as offboard (another config option?).
> 
> Can that not be configured at boot time with ide0=xxx or similar? I'm
> clearly missing why it would matter on or off board as long as the
> controller(s) were checked in the right order.

Make me favor, and extend ide0=<port> to also allow 
ide0=pci<slotnumber>.primary or .secondary... Until then
I do not know port address in advance (my board also uses
20265 as secondary ATA host, and I was really surprised what happened
to my /dev/hde after upgrade).
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
