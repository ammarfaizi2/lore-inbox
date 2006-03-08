Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbWCHX6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbWCHX6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWCHX6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:58:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24247 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932601AbWCHX6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:58:23 -0500
Date: Wed, 8 Mar 2006 15:52:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: torvalds@osdl.org, gregkh@suse.de, bunk@stusta.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net, neilb@cse.unsw.edu.au,
       mmokrejs@ribosome.natur.cuni.cz, nathans@sgi.com
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for
 2.6.16-rc5
Message-Id: <20060308155247.76a4fcc0.akpm@osdl.org>
In-Reply-To: <1141861551.8599.112.camel@localhost.localdomain>
References: <20060306223545.GA20885@kroah.com>
	<20060308222652.GR4006@stusta.de>
	<20060308225029.GA26117@suse.de>
	<Pine.LNX.4.64.0603081502350.32577@g5.osdl.org>
	<20060308152928.21afef81.akpm@osdl.org>
	<1141861551.8599.112.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> wrote:
>
> On Wed, 2006-03-08 at 15:29 -0800, Andrew Morton wrote:
> > - It would be nice to get Martin MOKREJ
> >   <mmokrejs@ribosome.natur.cuni.cz>'s full 16GB recognised again.  Dave
> >   Hansen is working on that. 
> 
> Martin, please step in here if your problem has come back...
> 
> After Martin applied my debugging patch, the problem went away.  Last I
> heard, he was going to boot back into a kernel without my patch to see
> if it stayed fixed.
> 
> My guess is that it is be a screwy BIOS that is causing the problem
> intermittently.  Otherwise, I can't imagine how some printks could
> affect the problem.  It's not like this is happening in code where there
> are SMP races.
> 
> I also checked around the office a bit to see if anyone else was having
> memory detection issues on large memory x86 machines.  No luck.

OK, thanks Dave.

> I'd put this into the "unreproducible" bucket for now.

IBM must make big buckets.
