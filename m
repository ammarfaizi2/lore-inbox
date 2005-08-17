Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750886AbVHQFlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbVHQFlE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 01:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVHQFlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 01:41:04 -0400
Received: from xenotime.net ([66.160.160.81]:63676 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750886AbVHQFlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 01:41:03 -0400
Date: Tue, 16 Aug 2005 22:41:01 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sudoyang@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: compiling only one module in kernel version 2.6?
Message-Id: <20050816224101.295806c8.rdunlap@xenotime.net>
In-Reply-To: <1124248729.5764.70.camel@localhost.localdomain>
References: <4f52331f050816190957cec081@mail.gmail.com>
	<1124248729.5764.70.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Aug 2005 23:18:49 -0400 Steven Rostedt wrote:

> On Tue, 2005-08-16 at 19:09 -0700, Fong Vang wrote:
> > What's the easiest way to compile just one module in the Linux 2.6 kernel tree?
> > 
> > This no longer seem to work:
> > 
> >   $ cd /usr/src/linux
> >   $ make SUBDIRS=fs/reiserfs modules
> >            Building modules, stage 2.
> >            MODPOST
> > 
> >   I don't see any .ko generated.
> 
> It worked for me. Is your reiserfs turned on as a module, and not
> compiled into the kernel. (<M> not <*> nor < >)

Sam only added make .ko build support very recently,
so it could easily depend on what kernel verison Fong is using.

---
~Randy
