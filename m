Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265067AbUEKXrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265067AbUEKXrk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265070AbUEKXpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:45:49 -0400
Received: from mail.kroah.org ([65.200.24.183]:6627 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265060AbUEKXpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:45:36 -0400
Date: Tue, 11 May 2004 16:32:07 -0700
From: Greg KH <greg@kroah.com>
To: Maneesh Soni <maneesh@in.ibm.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC 1/2] kobject_set_name - error handling
Message-ID: <20040511233207.GB27069@kroah.com>
References: <20040417082206.GM24997@parcelfarce.linux.theplanet.co.uk> <20040430101333.GB25296@in.ibm.com> <20040430101401.GC25296@in.ibm.com> <200404300748.14151.dtor_core@ameritech.net> <20040504053908.GA2900@in.ibm.com> <20040507222549.GB14660@kroah.com> <20030509153523.A20357@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030509153523.A20357@in.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 09, 2003 at 03:35:23PM +0530, Maneesh Soni wrote:
> On Fri, May 07, 2004 at 03:25:49PM -0700, Greg KH wrote:
> > On Tue, May 04, 2004 at 11:09:08AM +0530, Maneesh Soni wrote:
> > > 
> > > Greg, Are the patches fit for inclusion? I need to know this as my sysfs backing
> > > store patches are taking back seats because of these changes, particulary the
> > > one in second patch :-(.
> > 
> > I'm awash in different patches from you.  Can you try sending me the
> > ones you think are good enough for inclusion right now?  We can work
> > from there.
> > 
> 
> Sorry Greg, for confusing you by sending multiple copies. Here we are talking 
> about two patches which cleans up the kobject_set_name() usuage in the routines
> as mentioned below. The first one is appended here and the second one in the 
> next mail. I have complied and tested (booting) both the patches and hope they 
> are good for inclusion.
> 
> 
> 1) kobject_set_name-cleanup-01.patch
> 
> This patch corrects the following by checking the reutrn code from 
> kobject_set_name().
> 
> bus_add_driver()
> bus_register()
> sys_dev_register()

Ok, I applied this patch (it needed some manual messing with due to some
other patches in this area by others.)

thanks,

greg k-h
