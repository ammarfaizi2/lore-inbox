Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932372AbWFEBrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWFEBrQ (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 21:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWFEBrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 21:47:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20380 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932372AbWFEBrP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 21:47:15 -0400
Date: Sun, 4 Jun 2006 18:47:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: merging new drivers (was Re: 2.6.18 -mm merge plans)
Message-Id: <20060604184711.0a328d18.akpm@osdl.org>
In-Reply-To: <20060605013223.GD17361@havoc.gtf.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	<20060605013223.GD17361@havoc.gtf.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2006 21:32:23 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> On Sun, Jun 04, 2006 at 01:50:11PM -0700, Andrew Morton wrote:
> > areca-raid-linux-scsi-driver.patch
> 
> >   I'm going to start sending the Areca driver to James, too.  The vendor
> >   has worked hard and the hardware is becoming more important - let's help
> >   them get it in.
> 
> 
> In general, I'm a bit disappointed at the time it takes new drivers to
> reach the upstream kernel.  I grant that a lot of vendor drivers are
> unreadable, unmergable shite...  but on the other side of the coin, I
> see a lot of decent drivers get stalled simply because they aren't
> perfect.
> 
> I would rather see a driver get "95% there" -- because once a driver is
> merged into the upstream kernel, it has a lot more visibility, and will
> inevitably receive the remaining changes and cleanups anyway.
> 

Yes, I agree.  As long as we reasonably think that a piece of code *will*
become acceptable within a reasonable amount of time then going early is
safe.

A large part of that calculation is non-technical: do we believe that the
originator will do the work to get things finished off.  Often, that's a
pretty easy call to make.
