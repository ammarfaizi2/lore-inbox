Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUAQAB1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 19:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265843AbUAQAB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 19:01:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:50049 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265823AbUAQABZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 19:01:25 -0500
Date: Fri, 16 Jan 2004 16:01:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: root@chaos.analogic.com
Cc: cliffw@osdl.org, bunk@fs.tum.de, piggin@cyberone.com.au, mpm@selenic.com,
       linux-kernel@vger.kernel.org
Subject: Re: [1/4] better i386 CPU selection
Message-Id: <20040116160133.5af17a6a.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0401161425110.31018@chaos>
References: <20040106054859.GA18208@waste.org>
	<3FFA56D6.6040808@cyberone.com.au>
	<20040106064607.GB18208@waste.org>
	<3FFA5ED3.6040000@cyberone.com.au>
	<20040110004625.GB25089@fs.tum.de>
	<20040110005232.GD25089@fs.tum.de>
	<20040116111501.70200cf3.cliffw@osdl.org>
	<Pine.LNX.4.53.0401161425110.31018@chaos>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>
> On Fri, 16 Jan 2004, cliff white wrote:
> 
> > On Sat, 10 Jan 2004 01:52:32 +0100
> > Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> >
> > > Changes:
> 
> > > - AMD Elan is a different subarch, you can't configure a kernel that
> > >   runs on both the AMD Elan and other i386 CPUs
> 
> NO! NO!  This prevents development of an AMD embeded system on an
> "ordinary" machine like this one (Pentium IV). The fact that the
> timer runs at a different speed means nothing, one just sets the
> workstation time every day. Please do NOT do this. It prevents
> important usage.

Can't you just configure it for some lower denominator such as 386?

I must say that I'm a bit wobbly about Adrian's recent patches, simply
because of the overall intrusiveness and conceptual changes which they
introduce.

Remind me again, what did they buy us?


