Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbUDFSyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263968AbUDFSyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:54:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:60288 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263953AbUDFSyb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:54:31 -0400
Date: Tue, 6 Apr 2004 14:57:15 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack challenge 
In-Reply-To: <20040406180443.41252.qmail@web40502.mail.yahoo.com>
Message-ID: <Pine.LNX.4.53.0404061437020.8186@chaos>
References: <20040406180443.41252.qmail@web40502.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Apr 2004, Sergiy Lozovsky wrote:

>
> --- Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> > Sergiy Lozovsky <serge_lozovsky@yahoo.com> said:
> > > --- John Stoffel <stoffel@lucent.com> wrote:
> > > > >>>>> "Sergiy" == Sergiy Lozovsky
> > > > <serge_lozovsky@yahoo.com> writes:
> >
> > [...]
> >
> > > UNIX security policy is already implemented in the
> > > Kernel,
> >
> > Basic mechanism, not policy.
>
> In case of VXE even mechanism is not stored inside the
> kernel! This was the main goal - not to store(encode)
> security model (mechanism) in the kernel. In VXE it is
> loadable as well as particular security policy. It
> loads on demand (during the start of subsystem) and
> unloads when subsystem ends it work.
>
> When susbsytem doesn't run - model and policy are
> stored as a file.
>
> VXE allow to preload model and policy if that is
> desired, but it's just one of the options.
>
> >
> > Policy has no place inside the kernel.
>
> Root privileges (ability to send a signal to any
> process, access any file and so on) are encoded in the
> kernel.
>

That's not policy. That's mechanism (one of many).

> > > > Then *WHY* does the LISP interpreter need to be
> > in
> > > > the kernel in the
> > > > first place?  Hint, you just said you wanted to
> > > > protect the kernel...
> > >
> > > All LISP errors are incapsulated within LISP VM.
> >
> > They aren't. A bad kprintf(), or a call to the wrong
> > function inside the
> > kernel, or fiddling with the wrong data structure,
> > and you are toast.
>

Let me get this right. You learned LISP right?
Now you think it's the only way to go. There is
a name for this, where one starts to identify
with his captors... It's called the Stockholm
Syndrome, named after four Swedes bound in bank-
vault for six days became attached to their captors.

LISP is just a TOOL and a poor one, at that. There
are many tools available under Unix/Linux and, if
you don't like what's available, you can readily
make your own. Once you learn new tools, the Stockholm
Syndrome will go away although you'll probably always
like the first tool you learned to use. I like DDT,
myself.

Nobody who has a clue would suggest LISP inside a kernel.
When I first read this, I was sure it was an April-fool
joke, although somewhat cruel, kinda like; "what to do
with a dead cat..."

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


