Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265934AbTGKUCY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbTGKUAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:00:25 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:4562 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266276AbTGKTvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 15:51:50 -0400
From: Andrew Theurer <habanero@us.ibm.com>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.5 'what to expect'
Date: Fri, 11 Jul 2003 15:06:22 -0500
User-Agent: KMail/1.5
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030711140219.GB16433@suse.de> <200307111437.12648.habanero@us.ibm.com> <20030711195418.GA30449@gtf.org>
In-Reply-To: <20030711195418.GA30449@gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307111506.22152.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 July 2003 14:54, Jeff Garzik wrote:
> On Fri, Jul 11, 2003 at 02:37:12PM -0500, Andrew Theurer wrote:
> > On Friday 11 July 2003 09:02, Dave Jones wrote:
> > > Process scheduler improvements.
> > > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > - Scheduler is now Hyperthreading SMP aware and will disperse processes
> > >   over physically different CPUs, instead of just over logical CPUs.
> >
> > I'm pretty sure this is not in 2.5 (unless it's in bk after 2.5.75)
>
> Wrong, grep for sibling.

I don't see sibling mentioned anywhere in the context of load balance, only in 
smpboot.c.  Where exactly do you see any HT awareness in load balance?

-Andrew Theurer
