Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUCZUcS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 15:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbUCZUcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 15:32:18 -0500
Received: from mail.kroah.org ([65.200.24.183]:49900 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261197AbUCZUcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 15:32:17 -0500
Date: Fri, 26 Mar 2004 12:30:51 -0800
From: Greg KH <greg@kroah.com>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: whiteheat USB serial compile failure on PPC (2.6)
Message-ID: <20040326203051.GE26896@kroah.com>
References: <20040319010015.GE19053@kroah.com> <Pine.GSO.4.44.0403261429520.2460-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0403261429520.2460-100000@math.ut.ee>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2004 at 02:36:00PM +0200, Meelis Roos wrote:
> > Bah, looks like PPC doesn't ever define CMSPAR :(
> >
> > How about adding something like:
> > 	#ifndef CMSPAR
> > 	#define CMSPAR 0
> > 	#endif
> > To the beginning of the driver like the cdc-acm.c driver does?  If that
> > works, care to send me a patch?
> 
> Yes, it compiles.

Applied, thanks.

greg k-h
