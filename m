Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWAIIxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWAIIxQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 03:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWAIIxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 03:53:16 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:15888 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1750955AbWAIIxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 03:53:16 -0500
Date: Mon, 9 Jan 2006 03:53:00 -0500
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Boxer Gnome <aiko.sex@gmail.com>
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time
Message-ID: <20060109085300.GU11085@mail>
Mail-Followup-To: Boxer Gnome <aiko.sex@gmail.com>,
	andersen@codepoet.org, linux-kernel@vger.kernel.org
References: <174467f50601082354y7ca871c7k@mail.gmail.com> <20060109080632.GA27915@codepoet.org> <174467f50601090021v53b33e31u@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174467f50601090021v53b33e31u@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/06 04:21:49PM +0800, Boxer Gnome wrote:
> 2006/1/9, Erik Andersen <andersen@codepoet.org>:
> > On Mon Jan 09, 2006 at 03:54:24PM +0800, Boxer Gnome wrote:
> > > and the dos ntfs driver was not released by the MS offical.So,what' wrong?
> > >
> > > Somebody who can explain this ?
> >
> > Sure, thats easy.  You havn't paid Anton and Richard to quit
> > their jobs to work full time on finishing full linux ntfs
> > support.  It is really quite amazing how many "linux can't do foo"
> > type problems could be quickly solved by sending large amounts of
> > money to the right people.
> >
> >  -Erik
> >
> > --
> > Erik B. Andersen             http://codepoet-consulting.com/
> > --This message was written using 73% post-consumer electrons--
> >
> But the dos' ntfs drive was free software,no ne need pay.

Only the read-only version is monetarily free.

> I see, the ntfs' spec is not so hard to know.I always think it hard to
> be supported before, for the ntfs' spec belongs to MS.

Do you mean NTFSDOS from SysInternals? If so, look at it again and you'll
see that it uses the NTFS.sys and NTOSKRNL.exe files from an NT
installation. They worked around the need to understand the filesystem by
just writing a wrapper for the NTFS driver that MS released. And if you
care to trust that sort of wrapper take a look at CaptiveNTFS and you'll
see the exact same thing for Linux, except you don't have to pay for write
support with CaptiveNTFS. You just have to pray that it works right.

Jim.
