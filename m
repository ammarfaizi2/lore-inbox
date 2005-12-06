Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932640AbVLFVeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbVLFVeS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 16:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932641AbVLFVeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 16:34:18 -0500
Received: from xenotime.net ([66.160.160.81]:26769 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932640AbVLFVeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 16:34:17 -0500
Date: Tue, 6 Dec 2005 13:34:11 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Brian Gerst <bgerst@didntduck.org>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Add tainting for proprietary helper modules.
In-Reply-To: <1133900880.23610.77.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0512061333100.5519@shark.he.net>
References: <20051203004102.GA2923@redhat.com>  <Pine.LNX.4.61.0512050832290.27133@chaos.analogic.com>
  <20051205173041.GE12664@redhat.com>  <20051205093436.44d146e6@localhost.localdomain>
  <1133899612.23610.59.camel@localhost.localdomain>  <4395F097.5060005@didntduck.org>
 <1133900880.23610.77.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005, Alan Cox wrote:

> On Maw, 2005-12-06 at 15:12 -0500, Brian Gerst wrote:
> > Alan Cox wrote:
> > > On Llu, 2005-12-05 at 09:34 -0800, Stephen Hemminger wrote:
> > >
> > >>IMHO ndiswrapper can't claim legitimately to be GPL, so just
> > >>patch that.
> > >
> > >
> > > Actually it isnt so simple. Load ndiswrapper. Now load a GPL windows
> > > driver binary. I don't know if ndiswrapper itself could dig licenses out
> > > of windows modules but if so it could even conditionally taint.
> > >
> > > Alan
> >
> > On the other hand, if the windows driver were GPL then there wouldn't be
> > any barrier to writing a native driver.
>
> Sure, but the point was to demonstrate in a clear and logical fashion
> that ndiswrapper could be GPL.
> -

so it would be OK to run a windows NDIS driver on Linux,
by using ndiswrapper, as long as the windows NDIS driver is GPL?

Never mind its possible stack needs or who knows what else.

-- 
~Randy
