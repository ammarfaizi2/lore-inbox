Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUA2X3i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 18:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266520AbUA2X3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 18:29:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:64204 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266519AbUA2X3h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 18:29:37 -0500
Date: Thu, 29 Jan 2004 15:30:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
Cc: torvalds@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       linuxppc64-dev@lists.linuxppc.org
Subject: Re: Fw: [PATCH][2.6] PCI Scan all functions
Message-Id: <20040129153015.0e77f8e7.akpm@osdl.org>
In-Reply-To: <1075417841.679.139.camel@magik>
References: <20040127130803.10b666f3.akpm@osdl.org>
	<Pine.LNX.4.58.0401271345060.10794@home.osdl.org>
	<1075241556.681.19.camel@magik>
	<Pine.LNX.4.58.0401271428340.10794@home.osdl.org>
	<1075247559.672.33.camel@magik>
	<Pine.LNX.4.58.0401271559230.10794@home.osdl.org>
	<1075417841.679.139.camel@magik>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jake Moilanen <moilanen@austin.ibm.com> wrote:
>
> On Tue, 2004-01-27 at 18:09, Linus Torvalds wrote:
> > On Tue, 27 Jan 2004, Jake Moilanen wrote:
> > > 
> > > I tried this patch on my one (and only) machine that exibits this
> > > issue.  Everything was detected correctly.  
> > 
> > Ok. This at least looks more palatable in that it's now confined a bit 
> > better. 
> > 
> > However, looking at the logic, we really only want to do the 
> > "pcibios_scan_all_fns()" once per device, not once for each function, no?
> > 
> > 		Linus
> 
> Here's a patch that addresses Linus's concerns.  Andrew, if you have no
> objections, please apply.

Could you please send me a changelog description for this patch?  A bit of
background for posterity, so other kernel developers can come in a year
hence and answer the question "what's all this about then?".  Thanks.

