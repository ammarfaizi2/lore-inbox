Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265290AbUAFCYe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 21:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbUAFCYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 21:24:33 -0500
Received: from [209.195.52.120] ([209.195.52.120]:33496 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S265290AbUAFCYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 21:24:30 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Ed Tomlinson <edt@aei.ca>
Cc: Samium Gromoff <deepfire@sic-elvis.zel.ru>, linux-kernel@vger.kernel.org
Date: Mon, 5 Jan 2004 18:23:54 -0800 (PST)
Subject: Re: 2.6.0 performance problems
In-Reply-To: <200401051009.46293.edt@aei.ca>
Message-ID: <Pine.LNX.4.58.0401051821460.11842@dlang.diginsite.com>
References: <87brpq7ct3.wl@canopus.ns.zel.ru> <200312300855.00741.edt@aei.ca>
 <87smiud180.wl@canopus.ns.zel.ru> <200401051009.46293.edt@aei.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jan 2004, Ed Tomlinson wrote:

>
> On January 05, 2004 07:33 am, Samium Gromoff wrote:
> > At Tue, 30 Dec 2003 08:55:00 -0500,
> >
> > Ed Tomlinson wrote:
> > > On December 30, 2003 06:41 am, Samium Gromoff wrote:
> > > > Reality sucks.
> > > >
> > > > People are ignorant enough to turn blind eye to obvious vm regressions.
> > > >
> > > > No developers run 64M boxens anymore...
> > >
> > > No one is turning a blind eye.  Notice Linus has reponded to and is
> > > interested in this thread.  The vm is not perfect in all cases - in most
> > > cases it is faster though...
> >
> > "in most cases it is faster" is a big lie.
> >
> > The reality is: on all usual one-way boxes 2.6 goes slower than 2.4 once
> > you start paging.
>
> I would argue that in most case you do not page or page very little - know that is
> the case here.
>

This may be true of you have lots of memory, but with memory hogs like
mozilla and openoffice out there anyone who is working on an older machine
will be pageing, if only for the time it takes for the huge bloated
desktop app to start and get it's working set into memory.

things get even worse if you make the mistake of useing Gnome or KDE for
your desktop.

David Lang

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
