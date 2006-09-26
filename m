Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWIZU13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWIZU13 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 16:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWIZU13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 16:27:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:17366 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964789AbWIZU12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 16:27:28 -0400
From: Andi Kleen <ak@suse.de>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] x86[-64] PCI domain support
Date: Tue, 26 Sep 2006 22:27:22 +0200
User-Agent: KMail/1.9.3
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Jim Paradis <jparadis@redhat.com>, LKML <linux-kernel@vger.kernel.org>
References: <20060926191508.GA6350@havoc.gtf.org> <20060926202303.GA15369@kroah.com>
In-Reply-To: <20060926202303.GA15369@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609262227.22217.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 September 2006 22:23, Greg KH wrote:
> On Tue, Sep 26, 2006 at 03:15:08PM -0400, Jeff Garzik wrote:
> > 
> > The x86[-64] PCI domain effort needs to be restarted, because we've got
> > machines out in the field that need this in order for some devices to
> > work.
> > 
> > RHEL is shipping it now, apparently without any problems.
> > 
> > The 'pciseg' branch of
> > git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git pciseg
> 
> So are the NUMA issues now taken care of properly? 

I assume IBM would have complained if it was broken in RHEL.

But iirc Summit has two BIOS options for this. Maybe they just recommend
to set the other one for Linux. Anyways I guess that can be all figured
out once the patch is in tree.

-Andi

