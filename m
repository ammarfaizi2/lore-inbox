Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263576AbUC3Tgh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 14:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbUC3Tgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 14:36:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:48790 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263576AbUC3Tgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 14:36:33 -0500
Date: Tue, 30 Mar 2004 11:36:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm2
Message-Id: <20040330113620.33d01d9c.akpm@osdl.org>
In-Reply-To: <200403301127.05151.jbarnes@sgi.com>
References: <20040317201454.5b2e8a3c.akpm@osdl.org>
	<200403301127.05151.jbarnes@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes <jbarnes@sgi.com> wrote:
>
> On Wednesday 17 March 2004 8:14 pm, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6
> >.5-rc1-mm2/
> >
> > - Dropped the early-x86-cpu-detection patches, as these appear to be the
> >   source of recent early-crash problems.
> >
> > - Several fixes against the new writeback code.
> >
> > - Several fixes against the new block unplugging code.
> 
> I just tracked down a hang I've been seeing in the 2.6.5-rcX-mm trees to this 
> release.  The symptom is that the machine hangs sometime during init script 
> startup, usually at around the time swap space is enabled (using pretty stock 
> Red Hat scripts).  Before I look into it any further, are there any patches 
> that I should look at dropping to see if the hang goes away?
> 
> The hang occurs all the way through 2.6.5-rc3-mm1, but Linus' 2.6.5-rc3 
> release works fine.

I don't see anything especially hangy in 2.6.5-rc1-mm2 - maybe it's
something which was sucked in via one of the "external trees".  rc3-mm1
boots OK on my ia64 box.

Do you not have the means to work out where things are stuck at?
