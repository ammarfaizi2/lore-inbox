Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267111AbTAFTAv>; Mon, 6 Jan 2003 14:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbTAFTAv>; Mon, 6 Jan 2003 14:00:51 -0500
Received: from mx0.gmx.net ([213.165.64.100]:10526 "HELO mx0.gmx.net")
	by vger.kernel.org with SMTP id <S267111AbTAFTAt>;
	Mon, 6 Jan 2003 14:00:49 -0500
Date: Mon, 6 Jan 2003 20:09:20 +0100 (MET)
From: Daniel Blueman <daniel.blueman@gmx.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <Pine.LNX.3.96.1030106132528.10550A-100000@gatekeeper.tmr.com>
Subject: Re: Gigabit/SMP performance problem
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0008973862@gmx.net
X-Authenticated-IP: [81.86.104.216]
Message-ID: <23239.1041880161@www5.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Even with HT turned off on this dual-Xeon box, all IRQs are routed to CPU 0.

Kernel here is the latest RedHat 2.4.18 one.

Just curious what kernel Avery is running...

Dan

> On 4 Jan 2003, Daniel Blueman wrote:
> 
> > It's interesting you have IRQs balanced over the two logical
> > processors. I can't get this on HT Xeons with stock RedHat 7.3 kernel.
> 
> I think he's using two physical processors, if by "logical processors" you
> are thinking HT... I also recall he has HT off, but the original post
> isn't handy.
> 
> > 
> > Can you post the exact kernel version string, please?
> > 
> > TIA,
> >   Dan
> > 
> > "Avery Fay" <avery_fay@symantec.com> wrote in message
>
news:<OF256CD297.9F92C038-ON85256CA3.006A4034-85256CA3.00705DEA@symantec.com>...
> > > Dual Pentium 4 Xeon at 2.4 Ghz. I believe I am using irq load
> balancing as 
> > > shown below (seems to be applied to Red Hat's kernel). Here's 
> > > /proc/interrupts:
> 
> -- 
> bill davidsen <davidsen@tmr.com>
>   CTO, TMR Associates, Inc
> Doing interesting things with little computers since 1979.
> 

-- 
Daniel J Blueman

+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
NEU: Mit GMX ins Internet. Rund um die Uhr für 1 ct/ Min. surfen!

