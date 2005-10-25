Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbVJYFdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbVJYFdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 01:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbVJYFdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 01:33:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4564 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751299AbVJYFdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 01:33:07 -0400
Date: Mon, 24 Oct 2005 22:32:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, Laurent Riffard <laurent.riffard@free.fr>
Subject: Re: intel-agp and yenta-socket issues (was Re: 2.6.14-rc5-mm1
Message-Id: <20051024223223.267d46ec.akpm@osdl.org>
In-Reply-To: <200510250513.j9P5DjGv004612@turing-police.cc.vt.edu>
References: <20051024014838.0dd491bb.akpm@osdl.org>
	<200510250513.j9P5DjGv004612@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> On Mon, 24 Oct 2005 01:48:38 PDT, Andrew Morton said:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc5/2.6.14-rc5-mm1/
> 
> > +agp-updates-owner-field-of-struct-pci_driver.patch
> 
> intel-agp would hang during modprobe until I backed this one out.

A sysrq trace would be nice.

> Am still seeing a hang trying to modprobe yenta-socket during early boot.  I'm
> not seeing any obvious candidates to back out here - the -rc4-mm1 version is
> identical, and -rc4-mm1 boots OK for me.
> 
> I wasn't seeing any output from alt-sysrq-T, but it occurs to me that maybe
> the console level wasn't set nicely yet - this is happening pretty early in
> rc.sysinit.

Can you wait until the system is fully booted, get sysrq working then
modprobe the module by hand?

> Is there an undocumented requirement for a newer modprobe?

I hope not.   I'm using some ancient thing - it works OK.
