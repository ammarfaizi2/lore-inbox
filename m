Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWIXQdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWIXQdH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 12:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWIXQdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 12:33:07 -0400
Received: from havoc.gtf.org ([69.61.125.42]:47276 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751189AbWIXQdG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 12:33:06 -0400
Date: Sun, 24 Sep 2006 12:33:05 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git patches] libata updates
Message-ID: <20060924163305.GA14483@havoc.gtf.org>
References: <20060924162850.GA14323@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924162850.GA14323@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 12:28:50PM -0400, Jeff Garzik wrote:
> 
> Notable changes:
> * move to drivers/ata
> * add Alan's PATA drivers; drivers/ide still primary PATA for some time
> * AHCI suspend/resume

Notable notes I should have included:

* These changes have been in -mm for a while; the PATA drivers have been
  in -mm for quite a while
* There were no objections when the PATA merge plan was posted:
  http://lkml.org/lkml/2006/8/9/285


> Please pull from 'upstream-linus' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev.git upstream-linus

As an aside, Tejun Heo has an iomap patch that kills the much-hated
libata build warnings, and I have some related work as well.  Hopefully
the warnings should go away in 2.6.20.

	Jeff



