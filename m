Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbUCRJ5P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 04:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbUCRJ5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 04:57:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:41895 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262485AbUCRJws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 04:52:48 -0500
Date: Thu, 18 Mar 2004 01:52:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: macro@ds2.pg.gda.pl, thomas.schlichter@web.de, phil.el@wanadoo.fr,
       schwab@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6.4-rc2] bogus semicolon behind if()
Message-Id: <20040318015236.51c3f31f.akpm@osdl.org>
In-Reply-To: <16473.28647.29098.129203@alkaid.it.uu.se>
References: <200403090014.03282.thomas.schlichter@web.de>
	<20040308162947.4d0b831a.akpm@osdl.org>
	<20040309070127.GA2958@zaniah>
	<200403091208.20556.thomas.schlichter@web.de>
	<Pine.LNX.4.55.0403171734090.14525@jurand.ds.pg.gda.pl>
	<20040317102550.2ca7737c.akpm@osdl.org>
	<Pine.LNX.4.55.0403171946550.14525@jurand.ds.pg.gda.pl>
	<16473.28647.29098.129203@alkaid.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> Maciej W. Rozycki writes:
>  > On Wed, 17 Mar 2004, Andrew Morton wrote:
>  > 
>  > > I still have a couple of NMI patches in -mm:
>  > > 
>  > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6.5-rc1-mm1/broken-out/nmi_watchdog-local-apic-fix.patch
>  > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5-rc1/2.6.5-rc1-mm1/broken-out/nmi-1-hz.patch
>  > > 
>  > > What should we do with these?
>  > 
>  >  I think we should ask Mikael Pettersson as he is the local APIC watchdog 
>  > expert.  Mikael?
> 
> Will do. Is there a problem with them, or do you just want them
> reviewed for merging into 2.6.5-rc?
> 

They seem to work OK - I did a batch of testing with various setups.  But a
retest wouldn't hurt.

We mainly need a review and general finish-it-off-and-bless-it please.
