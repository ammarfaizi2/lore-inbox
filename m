Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263178AbSJBQll>; Wed, 2 Oct 2002 12:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263179AbSJBQll>; Wed, 2 Oct 2002 12:41:41 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:28666 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263178AbSJBQlj>; Wed, 2 Oct 2002 12:41:39 -0400
Date: Wed, 2 Oct 2002 09:46:36 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Dereferencing semaphores and atomic_t's
Message-ID: <20021002164636.GB1317@beaverton.ibm.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
References: <20021002111625.B24770@flint.arm.linux.org.uk> <1033564868.23758.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033564868.23758.2.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox [alan@lxorguk.ukuu.org.uk] wrote:
> On Wed, 2002-10-02 at 11:16, Russell King wrote:
> > drivers/scsi/scsi_error.c:
> > 
> >         SCSI_LOG_ERROR_RECOVERY(3, printk("Wake up parent %d\n",
> >                                           shost->eh_notify->count.counter));
> > 
> 
> This is already fixed in 2.4 - just forward port the fixes

I added sem_getcount to my scsi_error.c update and my scsi_hosts update
patch. I should have these out soon.

Sorry Russell that it has taken longer than I said to get the updated
scsi_error patch out. I am still investigating an issue with getting
door lock to work post fault insertion.

-andmike
--
Michael Anderson
andmike@us.ibm.com

