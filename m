Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265263AbTLFWEr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 17:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265264AbTLFWEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 17:04:47 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:37251
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265263AbTLFWEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 17:04:46 -0500
Date: Sat, 6 Dec 2003 17:01:47 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Markku Savela <msa@burp.tkv.asdf.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11, TSC cannot be used as a timesource.
In-Reply-To: <200312061652.59880.dtor_core@ameritech.net>
Message-ID: <Pine.LNX.4.58.0312061701260.1758@montezuma.fsmlabs.com>
References: <200312061603.hB6G3CrG012634@burp.tkv.asdf.org>
 <Pine.LNX.4.58.0312061253010.10548@montezuma.fsmlabs.com>
 <200312062056.hB6Kuh0D001004@burp.tkv.asdf.org> <200312061652.59880.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Dec 2003, Dmitry Torokhov wrote:

> On Saturday 06 December 2003 03:56 pm, Markku Savela wrote:
> > > From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
> > >
> > > On Sat, 6 Dec 2003, Markku Savela wrote:
> > > > I've seen some references to above problem, but no clear answer.
> > > > The 'ntpd' is complaining a lot...
> > > >
> > > > I have ASUS P4S800. Here is some extracts from dmesg (I can provide
> > > > more complete dump, if anyone wants something specific.)
> > >
> > > Does this only happen when running X11?
> >
> > Hmm.. possibly. When I boot single user, it does not appear to happen.
> >
>
> Do you have an ACPI battery stat or thermal monitor apps running (I see
> that you have ACPI active). Does it help it you increase the polling
> interval? Too many systems spend too much time in SCI handler...

Yes cat /proc/interrupts might also give some sort of rough indication.

