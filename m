Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWG3JrD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWG3JrD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 05:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWG3JrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 05:47:03 -0400
Received: from ns2.suse.de ([195.135.220.15]:11182 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932166AbWG3JrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 05:47:01 -0400
Date: Sun, 30 Jul 2006 02:42:44 -0700
From: Greg KH <greg@kroah.com>
To: Hubert Tonneau <hubert.tonneau@fullpliant.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc3
Message-ID: <20060730094244.GB18296@kroah.com>
References: <06ATWAN12@briare1.heliogroup.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06ATWAN12@briare1.heliogroup.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 01:03:59PM +0000, Hubert Tonneau wrote:
> Greg KH wrote:
> >
> > On Sun, Jul 30, 2006 at 12:21:13PM  0000, Hubert Tonneau wrote:
> > > Off topic information:
> > > With 2.6.17, none of my USB sound cards works; all of them work with 2.6.16
> > 
> > That's not good at all.  Care to run 'git bisect' on the tree to find
> > out what patch caused it?
> 
> Hard to do since I'm not a git user.

How about just using the -rc versions on kernel.org with a binary
search?  Then use the nightly snapshots that were inbetween them?

> You know, I'm the crazy guy that rewrote everything ... but the kernel :-)
> 
> Anyway, would this log help you ?

Not really.  Odds are this is an ALSA issue, but I'm not sure.

thanks,

greg k-h
