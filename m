Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268867AbTGJDPP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 23:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268872AbTGJDPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 23:15:15 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:6621 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S268867AbTGJDPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 23:15:08 -0400
Date: Thu, 10 Jul 2003 00:27:23 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Jim Gifford <maillist@jg555.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre3
In-Reply-To: <064101c34644$3d917850$3400a8c0@W2RZ8L4S02>
Message-ID: <Pine.LNX.4.55L.0307100025160.6316@freak.distro.conectiva>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva>
 <003501c34572$4113f0c0$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307081551480.21543@freak.distro.conectiva>
 <020301c3459b$942a1860$3400a8c0@W2RZ8L4S02> <1057703020.5568.10.camel@dhcp22.swansea.linux.org.uk>
 <024801c345a2$ceeef090$3400a8c0@W2RZ8L4S02> <Pine.LNX.4.55L.0307091428450.26373@freak.distro.conectiva>
 <064101c34644$3d917850$3400a8c0@W2RZ8L4S02>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jim,

Hum, so there are no memory problems.

Do you have the NMI oopser on? It might help us.

Also, do you remember when it started to crash like this? (which kernel
started to show the problem)

On Wed, 9 Jul 2003, Jim Gifford wrote:

> I ran memtest86 for 48 hours with no errors. (This was done about to week
> ago)
> ----- Original Message -----
> From: "Marcelo Tosatti" <marcelo@conectiva.com.br>
> To: "Jim Gifford" <maillist@jg555.com>
> Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>; "lkml"
> <linux-kernel@vger.kernel.org>
> Sent: Wednesday, July 09, 2003 10:33 AM
> Subject: Re: Linux 2.4.22-pre3
>
>
> >
> >
> > On Tue, 8 Jul 2003, Jim Gifford wrote:
> >
> > > ----- Original Message -----
> > > From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
> > > To: "Jim Gifford" <maillist@jg555.com>
> > > Cc: "Marcelo Tosatti" <marcelo@conectiva.com.br>; "lkml"
> > > <linux-kernel@vger.kernel.org>
> > > Sent: Tuesday, July 08, 2003 3:23 PM
> > > Subject: Re: Linux 2.4.22-pre3
> > >
> > >
> > > > On Maw, 2003-07-08 at 22:36, Jim Gifford wrote:
> > > > > Server is a multi-purpose box. Apache, Courier Mail, Proftp, and
> SSH.
> > > (ran
> > > > > on version 2.4.19 with no issues, problems started with 2.4.20.)
> > > > >
> > > > > Compiled using GCC 3.3.
> > > >
> > > > So the problem started before you switched compilers you were using to
> > > > build kernels ?
> > >
> > > The problem was also pre GCC 3.3. I also have tried to compile the
> kernel
> > > with GCC 2.95.3 I still get lock ups also.
> >
> > Have you tried memtest on the box? It might be memory corruption (??).
> >
> > Please confirm your memory is fine (with memtest), then we continue trying
> > to find the problem, OK?
