Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269036AbTGQTlc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 15:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269106AbTGQTlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 15:41:32 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:26794 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S269036AbTGQTlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 15:41:31 -0400
Date: Thu, 17 Jul 2003 16:50:44 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Jim Gifford <maillist@jg555.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.22-pre6 deadlock
In-Reply-To: <014501c34c9b$d93d4920$3400a8c0@W2RZ8L4S02>
Message-ID: <Pine.LNX.4.55L.0307171649340.2003@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva>
 <020301c3459b$942a1860$3400a8c0@W2RZ8L4S02> <1057703020.5568.10.camel@dhcp22.swansea.linux.org.uk>
 <024801c345a2$ceeef090$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307091428450.26373@freak.distro.conectiva>
 <064101c34644$3d917850$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307100025160.6316@freak.distro.conectiva>
 <042801c3472c$f4539f80$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307110953370.28177@freak.distro.conectiva>
 <06e301c347c7$2a779590$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111405320.29894@freak.distro.conectiva>
 <002b01c347e9$36a04110$f300a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307111749160.5537@freak.distro.conectiva>
 <001801c348a0$9dab91e0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307141145340.23121@freak.distro.conectiva>
 <00fd01c34c8d$a03a4960$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307171545460.1789@freak.distro.c
 onectiva> <014501c34c9b$d93d4920$3400a8c0@W2RZ8L4S02>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jim,

Probably (just a guess) netfilter is tainting the kernel.

Anyway, could you please try to reproduce the deadlock with stock -pre6?

Your feedback with this oopses are very very useful Jim. Thanks a lot.

On Thu, 17 Jul 2003, Jim Gifford wrote:

> ----- Original Message -----
> From: "Marcelo Tosatti" <marcelo@conectiva.com.br>
> To: "Jim Gifford" <maillist@jg555.com>
> Cc: "lkml" <linux-kernel@vger.kernel.org>
> Sent: Thursday, July 17, 2003 11:46 AM
> Subject: Re: 2.4.22-pre6 deadlock
>
>
> >
> > Jim,
> >
> > I just noticed your kernel is tained.
> >
> > For what reason?
> >
> >
>
> The only patches I use are for netfilter options and the updated megaraid
> driver everything else is stock.
>
> Do you think some of the netfilter options could be causing the problems??
>
