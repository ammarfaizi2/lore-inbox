Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270925AbTGVQtE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 12:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270926AbTGVQtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 12:49:04 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:24202 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270925AbTGVQtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 12:49:01 -0400
Date: Tue, 22 Jul 2003 14:00:25 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Jim Gifford <maillist@jg555.com>
Cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre5 deadlock
In-Reply-To: <012d01c35066$2c56d400$3400a8c0@W2RZ8L4S02>
Message-ID: <Pine.LNX.4.55L.0307221358440.23424@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307100025160.6316@freak.distro.conectiva>
 <042801c3472c$f4539f80$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307110953370.28177@freak.distro.conectiva>
 <06e301c347c7$2a779590$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111405320.29894@freak.distro.conectiva>
 <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111749160.5537@freak.distro.conectiva>
 <001801c348a0$9dab91e0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307141145340.23121@freak.distro.conectiva>
 <008701c34a29$caabb0f0$3400a8c0@W2RZ8L4S02> <20030719172103.GA1971@x30.local>
 <018101c34f4d$430d5850$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307210943160.25565@freak.distro.conectiva>
 <005a01c34fed$fea51120$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307220852470.10991@freak.distro.conectiva>
 <012d01c35066$2c56d400$3400a8c0@W2RZ8L4S02>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Jul 2003, Jim Gifford wrote:

> ----- Original Message -----
> From: "Marcelo Tosatti" <marcelo@conectiva.com.br>
> To: "Jim Gifford" <maillist@jg555.com>
> Cc: "Andrea Arcangeli" <andrea@suse.de>; "lkml"
> <linux-kernel@vger.kernel.org>
> Sent: Tuesday, July 22, 2003 4:53 AM
> Subject: Re: 2.4.22-pre5 deadlock
>
>
> >
> >
> > On Mon, 21 Jul 2003, Jim Gifford wrote:
> >
> > > > Lets wait and see what happens without the iptables and dazuko
> modules.
> > > >
> > > Marcelo,
> > >     -pre7 seems to be working ok. Do you want me to enable the dazuko
> thing
> > > again to see if it's the cause, or do you want me to wait a little
> longer to
> > > see what happens.
> >
> > Jim,
> >
> > I prefer if you leave -pre7 running for a while to confirm its stable.
> >
> >
> >
> top - 08:29:37 up 2 days, 13:41,  2 users,  load average: 2.33, 2.12, 2.03
> Tasks: 109 total,   3 running, 106 sleeping,   0 stopped,   0 zombie
>  Cpu0 :   0.3% user,   3.9% system,  95.8% nice,   0.0% idle
>  Cpu1 :   1.3% user,   0.6% system,  98.1% nice,   0.0% idle
> Mem:   1033672k total,   639904k used,   393768k free,   160764k buffers
> Swap:   265060k total,        0k used,   265060k free,   187444k cached
>
> Do you want me to do something intensive. I have a compile that I can do
> that takes over 8 hours.

Jim,

I guess most of us is already convinced that the lockups were caused by
the non-stock code.

How long it usually took to lockup before?
