Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269950AbTHBRdw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 13:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269958AbTHBRdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 13:33:52 -0400
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:53636 "EHLO server")
	by vger.kernel.org with ESMTP id S269950AbTHBRdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 13:33:49 -0400
Message-ID: <002101c3591c$3a85f600$3400a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: "Andrea Arcangeli" <andrea@suse.de>, "lkml" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0307100025160.6316@freak.distro.conectiva> <042801c3472c$f4539f80$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307110953370.28177@freak.distro.conectiva> <06e301c347c7$2a779590$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111405320.29894@freak.distro.conectiva> <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111749160.5537@freak.distro.conectiva> <001801c348a0$9dab91e0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307141145340.23121@freak.distro.conectiva> <008701c34a29$caabb0f0$3400a8c0@W2RZ8L4S02> <20030719172103.GA1971@x30.local> <018101c34f4d$430d5850$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307210943160.25565@freak.distro.conectiva> <005a01c34fed$fea51120$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307220852470.10991@freak.distro.conectiva> <012d01c35066$2c56d400$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307221358440.23424@freak.distro.conectiva>
Subject: Re: 2.4.22-pre5 deadlock
Date: Sat, 2 Aug 2003 10:33:46 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


----- Original Message ----- 
From: "Marcelo Tosatti" <marcelo@conectiva.com.br>
To: "Jim Gifford" <maillist@jg555.com>
Cc: "Andrea Arcangeli" <andrea@suse.de>; "lkml"
<linux-kernel@vger.kernel.org>
Sent: Tuesday, July 22, 2003 10:00 AM
Subject: Re: 2.4.22-pre5 deadlock


>
>
> On Tue, 22 Jul 2003, Jim Gifford wrote:
>
> > ----- Original Message -----
> > From: "Marcelo Tosatti" <marcelo@conectiva.com.br>
> > To: "Jim Gifford" <maillist@jg555.com>
> > Cc: "Andrea Arcangeli" <andrea@suse.de>; "lkml"
> > <linux-kernel@vger.kernel.org>
> > Sent: Tuesday, July 22, 2003 4:53 AM
> > Subject: Re: 2.4.22-pre5 deadlock
> >
> >
> > >
> > >
> > > On Mon, 21 Jul 2003, Jim Gifford wrote:
> > >
> > > > > Lets wait and see what happens without the iptables and dazuko
> > modules.
> > > > >
> > > > Marcelo,
> > > >     -pre7 seems to be working ok. Do you want me to enable the
dazuko
> > thing
> > > > again to see if it's the cause, or do you want me to wait a little
> > longer to
> > > > see what happens.
> > >
> > > Jim,
> > >
> > > I prefer if you leave -pre7 running for a while to confirm its stable.
> > >
> > >
> > >
> > top - 08:29:37 up 2 days, 13:41,  2 users,  load average: 2.33, 2.12,
2.03
> > Tasks: 109 total,   3 running, 106 sleeping,   0 stopped,   0 zombie
> >  Cpu0 :   0.3% user,   3.9% system,  95.8% nice,   0.0% idle
> >  Cpu1 :   1.3% user,   0.6% system,  98.1% nice,   0.0% idle
> > Mem:   1033672k total,   639904k used,   393768k free,   160764k buffers
> > Swap:   265060k total,        0k used,   265060k free,   187444k cached
> >
> > Do you want me to do something intensive. I have a compile that I can do
> > that takes over 8 hours.
>
> Jim,
>
> I guess most of us is already convinced that the lockups were caused by
> the non-stock code.
>
> How long it usually took to lockup before?
>
Marcelo,
    I just got back from vacation, pre8 was running with the dazuko module
and the program that used it. No down time at all, I will start adding the
iptables modules and see which one causes the problems. (I left on Sunday
8am returned on 8pm on Friday).

Jim

