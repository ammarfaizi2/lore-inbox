Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261838AbSJDScb>; Fri, 4 Oct 2002 14:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261888AbSJDScb>; Fri, 4 Oct 2002 14:32:31 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:11262 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261838AbSJDScb>; Fri, 4 Oct 2002 14:32:31 -0400
Subject: Re: export of sys_call_table
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <p73fzvmqdg4.fsf@oldwotan.suse.de>
References: <20021003153943.E22418@openss7.org.suse.lists.linux.kernel>
	<20021003221525.GA2221@kroah.com.suse.lists.linux.kernel>
	<20021003222716.GB14919@suse.de.suse.lists.linux.kernel>
	<1033684027.1247.43.camel@phantasy.suse.lists.linux.kernel>
	<20021003233504.GA20570@suse.de.suse.lists.linux.kernel>
	<20021003235022.GA82187@compsoc.man.ac.uk.suse.lists.linux.kernel>
	<mailman.1033691043.6446.linux-kernel2news@redhat.com.suse.lists.linux.kerne
	 l>
	<200210040403.g9443Vu03329@devserv.devel.redhat.com.suse.lists.linux.kernel>
	 <20021003233221.C31444@openss7.org.suse.lists.linux.kernel>
	<20021004133657.B17216@devserv.devel.redhat.com.suse.lists.linux.kernel> 
	<p73fzvmqdg4.fsf@oldwotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Oct 2002 19:46:33 +0100
Message-Id: <1033757193.31839.51.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-04 at 19:14, Andi Kleen wrote:
> privateice also needs it. And there is no easy way to fix it like
> oprofile, unless you moved it completely into the kernel.
> 
> And AFS of course too for afssyscall.
> 
> (both are free)

AFS patches a collection of random syscalls in pretty icky ways. Again
afssyscall wants doing the right way - with a kernel stub like NFS has

