Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966059AbWK2Huk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966059AbWK2Huk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 02:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966190AbWK2Huk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 02:50:40 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59566 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S966059AbWK2Huj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 02:50:39 -0500
Date: Tue, 28 Nov 2006 23:47:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org
Subject: Re: 2.6.19-rc6-mm1: drivers/net/chelsio/: unused code
Message-Id: <20061128234719.9b3a224d.akpm@osdl.org>
In-Reply-To: <20061129073609.GA11084@stusta.de>
References: <20061123021703.8550e37e.akpm@osdl.org>
	<20061124001731.GO3557@stusta.de>
	<20061127102455.362fe88f@dxpl.pdx.osdl.net>
	<20061129073609.GA11084@stusta.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 08:36:09 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> On Mon, Nov 27, 2006 at 10:24:55AM -0800, Stephen Hemminger wrote:
> > On Fri, 24 Nov 2006 01:17:31 +0100
> > Adrian Bunk <bunk@stusta.de> wrote:
> > 
> > > On Thu, Nov 23, 2006 at 02:17:03AM -0800, Andrew Morton wrote:
> > > >...
> > > > Changes since 2.6.19-rc5-mm2:
> > > >...
> > > > +chelsio-22-driver.patch
> > > >...
> > > >  netdev updates
> > > 
> > > It is suspicious that the following newly added code is completely unused:
> > >   drivers/net/chelsio/ixf1010.o
> > >     t1_ixf1010_ops
> > >   drivers/net/chelsio/mac.o
> > >     t1_chelsio_mac_ops
> > >   drivers/net/chelsio/vsc8244.o
> > >     t1_vsc8244_ops
> > > 
> > > cu
> > > Adrian
> > > 
> > 
> > All that is gone in later version. I reposted new patches
> > after -mm2 was done.
> 
> It seems these patches didn't make it into 2.6.19-rc6-mm2 ?
> 

I dropped that patch and picked up Francois's tree instead.
