Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269186AbUIYCbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269186AbUIYCbx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 22:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269189AbUIYCbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 22:31:53 -0400
Received: from web51807.mail.yahoo.com ([206.190.38.238]:14939 "HELO
	web51807.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269186AbUIYCbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 22:31:50 -0400
Message-ID: <20040925023149.73704.qmail@web51807.mail.yahoo.com>
Date: Fri, 24 Sep 2004 19:31:49 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Re: resource provisioning
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040924112328.V1973@build.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the information Chris.  This is a good
starting point.

Phy
--- Chris Wright <chrisw@osdl.org> wrote:

> * Phy Prabab (phyprabab@yahoo.com) wrote:
> > I would like to know if the linux kernel has a
> > mechanism to control computing resources at a uid
> > level, which I will call "resource provisioning". 
> For
> > example, I would like to define on a multi cpu
> machine
> > that a list of uid's can not consume more than 1
> cpu
> > and no more than 1G RAM, irregardless or how many
> jobs
> > they launch on or to the system.
> 
> You can already do this in some pretty crude fashion
> via rlimits and
> sched_setaffinity (although the later doesn't have
> direct pam support
> that I know of, so you'd have to manage that on your
> own).
> 
> > So I guess, is this the correct term and is there
> a
> > posibilitity to do this now?
> 
> Otherwise, you must look at out of tree patches. 
> Linux-vserver does
> this, CKRM will allow you resource control, and PAGG
> + other module
> (perhaps job?) will give you this as well.
> 
> > I would like to avoid the virtual servers method
> as I
> > do not want to carve the machines in question into
> > more machines.
> 
> Note: the vserver method above doesn't create actual
> virtual machines,
> more like a software construct that you could
> consider a resource domain.
> 
> thanks,
> -chris
> -- 
> Linux Security Modules     http://lsm.immunix.org   
>  http://lsm.bkbits.net
> 



		
__________________________________
Do you Yahoo!?
Yahoo! Mail - 50x more storage than other providers!
http://promotions.yahoo.com/new_mail
