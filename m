Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264042AbTEGQaN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 12:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbTEGQaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 12:30:13 -0400
Received: from chaos.analogic.com ([204.178.40.224]:58242 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264042AbTEGQaM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 12:30:12 -0400
Date: Wed, 7 May 2003 12:45:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: petter wahlman <petter@bluezone.no>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <1052323711.3739.750.camel@badeip>
Message-ID: <Pine.LNX.4.53.0305071243400.12878@chaos>
References: <1052321673.3727.737.camel@badeip>  <Pine.LNX.4.53.0305071147510.12652@chaos>
 <1052323711.3739.750.camel@badeip>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 May 2003, petter wahlman wrote:

> On Wed, 2003-05-07 at 18:00, Richard B. Johnson wrote:
> > On Wed, 7 May 2003, petter wahlman wrote:
> >
> > >
> > > It seems like nobody belives that there are any technically valid
> > > reasons for hooking system calls, but how should e.g anti virus
> > > on-access scanners intercept syscalls?
> > > Preloading libraries, ptracing init, patching g/libc, etc. are
> >   ^^^^^^^^^^^^^^^^^^^
> >                     |________  Is the way to go. That's how
> > you communicate every system-call to a user-mode daemon that
> > does whatever you want it to do, including phoning the National
> > Security Administrator if that's the policy.
> >
> > > obviously not the way to go.
> > >
> >
> > Oviously wrong.
>
>
> And how would you force the virus to preload this library?
>
> -p.
>

I wouldn't.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

