Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270303AbTGRR2Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 13:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270292AbTGRR2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 13:28:16 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:59570 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270303AbTGRRZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 13:25:58 -0400
Date: Fri, 18 Jul 2003 14:34:00 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Jim Gifford <maillist@jg555.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre6 deadlock
In-Reply-To: <002e01c34d41$687dbe30$3400a8c0@W2RZ8L4S02>
Message-ID: <Pine.LNX.4.55L.0307181421550.7889@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva>
 <064101c34644$3d917850$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307100025160.6316@freak.distro.conectiva>
 <042801c3472c$f4539f80$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307110953370.28177@freak.distro.conectiva>
 <06e301c347c7$2a779590$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111405320.29894@freak.distro.conectiva>
 <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111749160.5537@freak.distro.conectiva>
 <001801c348a0$9dab91e0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307141145340.23121@freak.distro.conectiva>
 <00fd01c34c8d$a03a4960$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307171545460.1789@freak.distro.c
 onectiva> <014501c34c9b$d93d4920$3400a8c0@W2RZ8L4S02>
 <Pine.LNX.4.55L.0307171649340.2003@freak.distro.c onectiva>
 <01d701c34cc0$7f698740$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307180925580.6642@freak.dis
 tro.conectiva> <002e01c34d41$687dbe30$3400a8c0@W2RZ8L4S02>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jim,

What is this dazuko thing ?

>>EIP; f74e1005 <_end+371aeba5/3a4cfc00>   <=====

Trace; fa9132a9 <[dazuko]dazuko_run_daemon_on_slotlist+95/338>
Trace; fa9135e1 <[dazuko]dazuko_run_daemon+95/ba>
Trace; fa913e0a <[dazuko]dazuko_sys_open+da/1d5>
Trace; c0109a3f <system_call+33/38>
Proc;  couriertcpd







On Fri, 18 Jul 2003, Jim Gifford wrote:

> ----- Original Message -----
> From: "Marcelo Tosatti" <marcelo@conectiva.com.br>
> To: "Jim Gifford" <maillist@jg555.com>
> Cc: "lkml" <linux-kernel@vger.kernel.org>
> Sent: Friday, July 18, 2003 5:26 AM
> Subject: Re: 2.4.22-pre6 deadlock
>
>
> >
> > Yes, please.
> >
> > I'll investigate yours and Stephan more carefully today.
> >
> > On Thu, 17 Jul 2003, Jim Gifford wrote:
> >
> > > If it acts up again, do you want a copy of the build logs??
> > >
> >
>
> Happened last night with the stock kernel.
>
> Enclosed the build logs, kysmoops report, and the sysrq dump information.
>
