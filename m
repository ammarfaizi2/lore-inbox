Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262392AbUBXSos (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbUBXSos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:44:48 -0500
Received: from chaos.analogic.com ([204.178.40.224]:9088 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262392AbUBXSn4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:43:56 -0500
Date: Tue, 24 Feb 2004 13:44:18 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Tomas Szepe <szepe@pinerecords.com>
cc: sandr8@crocetta.org, Gautam Pagedar <gautam@cins.unipune.ernet.in>,
       linux-kernel@vger.kernel.org
Subject: Re: can i modify ls
In-Reply-To: <20040224165943.GB24370@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.53.0402241338210.916@chaos>
References: <005601c3fd75$1c681510$8c01080a@crayii> <403B7402.2000008@universitari.crocetta.org>
 <20040224163530.GA24370@louise.pinerecords.com> <Pine.LNX.4.53.0402241139580.532@chaos>
 <20040224165943.GB24370@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Tomas Szepe wrote:

> On Feb-24 2004, Tue, 11:44 -0500
> Richard B. Johnson <root@chaos.analogic.com> wrote:
>
> > On Tue, 24 Feb 2004, Tomas Szepe wrote:
> >
> > > On Feb-24 2004, Tue, 15:55 +0000
> > > Alessandro Salvatori <a.salvatori@universitari.crocetta.org> wrote:
> > >
> > > > it's quite interesting...
> > >
> > > Actually, it's not.
> > >
> > > 1) The presence/absence of the read permission on a directory determines
> > > 	whether the user will be able to list the directory's contents.
> > >
> > > 2) The fs permission model is enforced by the kernel.  Trying to impose
> > > 	additional restrictions in userspace is fragile, futile and
> > > 	an incredibly stupid idea.
> >
> > If you don't have any programming tools and no access to any (like
> > a banking or restrictive office environment), and there is no
> > way to get any external executable files to run, i.e., no floppy
> > or no shell that could possibly access one, then writing a minimal
> > 'ls' program that allows the clerk to see what's in her directory
> > might be useful.
>
> So what is it exactly that prevents the admin from running /bin/chmod
> in the setup you're describing?

No such program. FYI, there are lots of systems where the root file-system
has a very limited set of tools, sometimes it's on NFS. The machine needs
to be booted with a different root for maintenance. This is even
commonplace for store cash-register, and resturant menu setups
where there is a "server" in the back room that needs to be restarted
in a maintenance mode, been that way since DOS 3.0. A system is
secure if (1) there are no tools available to harm it, and (2) if
the box that contains additional tools is (physically) locked up.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


