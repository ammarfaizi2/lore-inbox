Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932385AbWGLSTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWGLSTf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWGLSTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:19:30 -0400
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:51104 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932419AbWGLSTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:19:25 -0400
Date: Wed, 12 Jul 2006 14:12:02 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.18-rc1-mm1
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Arjan van de Ven <arjan@infradead.org>, "Brown, Len" <len.brown@intel.com>,
       linux-acpi <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Rajesh Shah <rajesh.shah@intel.com>,
       Reuben Farrelly <reuben-lkml@reub.net>,
       Randy Dunlap <rdunlap@xenotime.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>
Message-ID: <200607121415_MC3-1-C4C4-EE7F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060711230055.GL18838@kroah.com>

On Tue, 11 Jul 2006 16:00:55 -0700, Greg KH wrote:

> > > >> PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved
> > > >> PCI: Not using MMCONFIG.
> > > >> PCI: Using configuration type 1
> > > >> ACPI: Interpreter enabled
> > > >> 
> > > >> Is there any way to verify that there really is a BIOS bug 
> > > >there?  If it is, is there anyone within Intel or are there any
> > > >known contacts 
> > > >who can push and poke > to get this looked at/fixed?
> > > >(It's a new Intel board, I'd hope they could get it right..).
> > > 
> > > Arjan should probably comment on that one.
> > 
> > I could.. but please next time if you want to CC me use an email address
> > I actually read ;)
> > 
> > Greg has a patch to relax this check, and Rajesh has a further patch to
> > relax it more.
> 
> Hm, no, my patch should already be in 2.6.18-rc1, I don't have any
> pending MMCONFIG patches in my queue or tree.
> 
> So if you think I'm missing one, please resend it to me.

What happened to:

        http://lkml.org/2006/6/26/640

        [patch 0/2] PCI: improve extended config space verification - take #2

I tested the first round of this patchset on i386 and it worked for me (TM).

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
