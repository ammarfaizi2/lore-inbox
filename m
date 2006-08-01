Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751799AbWHATE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751799AbWHATE1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbWHATE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:04:26 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:17081 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751800AbWHATEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:04:25 -0400
Subject: Re: deprecate and convert some sleep_on variants.
From: Steven Rostedt <rostedt@goodmis.org>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Dave Jones <davej@redhat.com>, arjan@infradead.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <29495f1d0608011120j8103c5bwd169367ee2d67bc0@mail.gmail.com>
References: <20060801180643.GD22240@redhat.com>
	 <29495f1d0608011120j8103c5bwd169367ee2d67bc0@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 15:03:50 -0400
Message-Id: <1154459030.29772.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-01 at 13:20 -0500, Nish Aravamudan wrote:
> On 8/1/06, Dave Jones <davej@redhat.com> wrote:
> > We've been carrying this for a dogs age in Fedora. It'd be good to get
> > this in -mm, so that it stands some chance of getting upstreamed at some point.
> >
> > Signed-off-by: Arjan van de Ven <arjan@infradead.org>
> > Signed-off-by: Dave Jones <davej@redhat.com>
> >

> Also, would these changes:
> 
> > diff -urNp --exclude-from=/home/davej/.exclude linux-1060/include/linux/wait.h linux-1070/include/linux/wait.h
> > --- linux-1060/include/linux/wait.h
> > +++ linux-1070/include/linux/wait.h
> 
> Be better in a separate patch?

As well as the changes to kernel/sched.c

-- Steve


