Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965282AbWI0FD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965282AbWI0FD4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 01:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965269AbWI0FDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 01:03:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:50570 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965277AbWI0FDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 01:03:54 -0400
Date: Tue, 26 Sep 2006 21:40:51 -0700
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Andrew Morton <akpm@osdl.org>, Jim Paradis <jparadis@redhat.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86[-64] PCI domain support
Message-ID: <20060927044051.GA32589@kroah.com>
References: <20060926191508.GA6350@havoc.gtf.org> <20060926202303.GA15369@kroah.com> <4519912C.80402@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4519912C.80402@garzik.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 04:44:28PM -0400, Jeff Garzik wrote:
> Greg KH wrote:
> >On Tue, Sep 26, 2006 at 03:15:08PM -0400, Jeff Garzik wrote:
> >>The x86[-64] PCI domain effort needs to be restarted, because we've got
> >>machines out in the field that need this in order for some devices to
> >>work.
> >>
> >>RHEL is shipping it now, apparently without any problems.
> >>
> >>The 'pciseg' branch of
> >>git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git pciseg
> >
> >So are the NUMA issues now taken care of properly?  If so, care to send
> >me the patches for this so I can add them to my quilt tree?
> 
> Er, I just posted the combined patch for review.  Can't you pull from 
> the above URL?  It's a bit of a pain to dive in and out of git.

I agree, it is a pain :)

And I don't use git for patch maintenance, only for sending stuff to
Linus.  So I'd have to pull this and extract out the patches and edit
the headers in order to get them into my tree in mbox form (as my
patchflow works off of emails.)

So, care to make it a bit easier for me to take these?

thanks,

greg k-h
