Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270486AbTGSD3F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 23:29:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270488AbTGSD3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 23:29:05 -0400
Received: from dsl-gte-19434.linkline.com ([64.30.195.78]:31110 "EHLO server")
	by vger.kernel.org with ESMTP id S270486AbTGSD3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 23:29:01 -0400
Message-ID: <000301c34da7$e6a3af70$3400a8c0@W2RZ8L4S02>
From: "Jim Gifford" <maillist@jg555.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: "lkml" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva> <064101c34644$3d917850$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307100025160.6316@freak.distro.conectiva> <042801c3472c$f4539f80$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307110953370.28177@freak.distro.conectiva> <06e301c347c7$2a779590$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111405320.29894@freak.distro.conectiva> <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111749160.5537@freak.distro.conectiva> <001801c348a0$9dab91e0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307141145340.23121@freak.distro.conectiva> <00fd01c34c8d$a03a4960$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307171545460.1789@freak.distro.c onectiva> <014501c34c9b$d93d4920$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307171649340.2003@freak.distro.c onectiva> <01d701c34cc0$7f698740$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307180925580.6642@freak.dis tro.conectiva> <002e01c34d41$687dbe30$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307181421550.7889@freak.distro.conectiva>
Subject: Re: 2.4.22-pre6 deadlock
Date: Fri, 18 Jul 2003 12:53:05 -0700
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
Cc: "lkml" <linux-kernel@vger.kernel.org>
Sent: Friday, July 18, 2003 10:34 AM
Subject: Re: 2.4.22-pre6 deadlock


>
>
> Jim,
>
> What is this dazuko thing ?
>
> >>EIP; f74e1005 <_end+371aeba5/3a4cfc00>   <=====
>
> Trace; fa9132a9 <[dazuko]dazuko_run_daemon_on_slotlist+95/338>
> Trace; fa9135e1 <[dazuko]dazuko_run_daemon+95/ba>
> Trace; fa913e0a <[dazuko]dazuko_sys_open+da/1d5>
> Trace; c0109a3f <system_call+33/38>
> Proc;  couriertcpd
>
>
>
>
>
>
>
> On Fri, 18 Jul 2003, Jim Gifford wrote:
>
> > ----- Original Message -----
> > From: "Marcelo Tosatti" <marcelo@conectiva.com.br>
> > To: "Jim Gifford" <maillist@jg555.com>
> > Cc: "lkml" <linux-kernel@vger.kernel.org>
> > Sent: Friday, July 18, 2003 5:26 AM
> > Subject: Re: 2.4.22-pre6 deadlock
> >
> >
> > >
> > > Yes, please.
> > >
> > > I'll investigate yours and Stephan more carefully today.
> > >
> > > On Thu, 17 Jul 2003, Jim Gifford wrote:
> > >
> > > > If it acts up again, do you want a copy of the build logs??
> > > >
> > >
> >
> > Happened last night with the stock kernel.
> >
> > Enclosed the build logs, kysmoops report, and the sysrq dump
information.
> >
>

It's part of the antivirus scanner. Information available at
http://www.dazuko.org
In the past I thought this was the problem and disabled it, but the problem
still existed.

I will send you a private mail with a proposal.

