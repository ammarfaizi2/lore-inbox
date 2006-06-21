Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWFUX11@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWFUX11 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 19:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932107AbWFUX11
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 19:27:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12256 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751341AbWFUX10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 19:27:26 -0400
Date: Wed, 21 Jun 2006 16:27:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: greg@kroah.com, gregkh@suse.de, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org, geert@linux-m68k.org
Subject: Re: [PATCH] 64bit resources start end value fix
Message-Id: <20060621162715.4d91ff05.akpm@osdl.org>
In-Reply-To: <20060621231552.GA25514@in.ibm.com>
References: <20060621172903.GC9423@in.ibm.com>
	<20060621132227.ec401f93.akpm@osdl.org>
	<20060621204120.GA14739@in.ibm.com>
	<20060621135855.ce68720f.akpm@osdl.org>
	<20060621231552.GA25514@in.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 19:15:52 -0400
Vivek Goyal <vgoyal@in.ibm.com> wrote:

> On Wed, Jun 21, 2006 at 01:58:55PM -0700, Andrew Morton wrote:
> > > 
> > > Andrew, you don't have to apply this patch. It is supposed to be picked
> > > by Greg.
> > > 
> > > There seems to be some confusion. Just few days back Greg consolidated
> > > and re-organized all the 64bit resources patches and posted on LKML for
> > > review.
> > > 
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=115015916118671&w=2
> > > 
> > > There were few review comments regarding kconfig options.
> > > I reworked the patch and CONFING_RESOURCES_32BIT was changed to
> > > CONFIG_RESOURCES_64BIT.
> > > 
> > > http://marc.theaimsgroup.com/?l=linux-kernel&m=115072559700302&w=2
> > > 
> > > Now Greg's tree and your tree are not exact replica when it comes to 
> > > 64bit resource patches. Hence this patch is supposed to be picked by 
> > > Greg to make sure things are not broken in his tree.
> > 
> > I'm working against Greg's tree, always...
> 
> I am sorry. That's a mistake on my part. I misunderstood it.

Oh.

> Can you please include the attached patch.

Hopefully I'll pick it up from
http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/gregkh-03-pci
later today?
