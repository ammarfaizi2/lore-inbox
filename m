Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161219AbWF0RoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161219AbWF0RoK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 13:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161231AbWF0RoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 13:44:10 -0400
Received: from xenotime.net ([66.160.160.81]:25761 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161219AbWF0RoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 13:44:09 -0400
Date: Tue, 27 Jun 2006 10:46:49 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: wfg@mail.ustc.edu.cn, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm3: no help text for READAHEAD_ALLOW_OVERHEADS
Message-Id: <20060627104649.25832e61.rdunlap@xenotime.net>
In-Reply-To: <20060627144019.GA13915@stusta.de>
References: <20060627015211.ce480da6.akpm@osdl.org>
	<20060627091429.GK23314@stusta.de>
	<20060627134337.GA6117@mail.ustc.edu.cn>
	<20060627144019.GA13915@stusta.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 16:40:19 +0200 Adrian Bunk wrote:

> On Tue, Jun 27, 2006 at 09:43:37PM +0800, Wu Fengguang wrote:
> > On Tue, Jun 27, 2006 at 11:14:29AM +0200, Adrian Bunk wrote:
> > > On Tue, Jun 27, 2006 at 01:52:11AM -0700, Andrew Morton wrote:
> > > >...
> > > > Changes since 2.6.17-mm2:
> > > > +readahead-kconfig-option-readahead_allow_overheads.patch
> > > >...
> > > >  readahead updates
> > > >...
> > > 
> > > The READAHEAD_ALLOW_OVERHEADS option lacks a help text.
> > 
> > Oh, it just acts as a submenu and a reminder ;)
> > 
> > > Additionally, the "default n" is pointless and should be removed.
> > 
> > I expect the _extra_ features are useless for normal users.
> > Your reasoning or feeling?
> >...
> 
> That's not my point, my point is that if you remove the "default n" 
> line, nothing changes. The default is still "n", but it's better 
> readable.

Why is it more readable without the "default n" line?
One could say that supplying the default "default n" line is clearer
than having it omitted.

---
~Randy
