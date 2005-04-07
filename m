Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbVDGIbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbVDGIbU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVDGIaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:30:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:10418 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262391AbVDGI2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 04:28:02 -0400
Date: Thu, 7 Apr 2005 01:27:24 -0700
From: Greg KH <greg@kroah.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org
Subject: Re: connector is missing in 2.6.12-rc2-mm1
Message-ID: <20050407082723.GA4669@kroah.com>
References: <1112855509.18360.27.camel@frecb000711.frec.bull.fr> <20050406234257.460edb9a.akpm@osdl.org> <20050407081718.GA4402@kroah.com> <1112862649.28858.108.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112862649.28858.108.camel@uganda>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2005 at 12:30:49PM +0400, Evgeniy Polyakov wrote:
> On Thu, 2005-04-07 at 01:17 -0700, Greg KH wrote:
> > On Wed, Apr 06, 2005 at 11:42:57PM -0700, Andrew Morton wrote:
> > > Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> > > >
> > > > Hello,
> > > > 
> > > >  I don't see the connector directory in the 2.6.12-rc2-mm1 tree. So it
> > > > seems that you removed the connector?
> > > 
> > > Greg dropped it for some reason.  I think that's best because it needed a
> > > significant amount of rework.  I'd like to see it resubitted in totality so
> > > we can take another look at it.
> > 
> > Greg dropped it because he's radically changing the way he handles
> > patches.  I still have them around here somewhere...
> 
> He probably was quite dissapointed/overflowed by it's quality and
> quantity, but please thank him for his comments and tell him it 
> was very pleasant to work with.

Heh, that must have been what happened... :)

> > Yeah, here they are.  Hm, I'd really like to stop carrying them around,
> > as my workload doesn't lend itself to handling these.
> > 
> > If you don't mind, can you create up a new connector, super-io, and
> > kobject-connector patch and send them to andrew for him to add to -mm?
> > That way I'll not have to worry about them anymore, as they keep
> > floating in-and-out of the -mm releases depending on the state of my
> > trees.  I can still handle your w1 patches, and have 2 of them pending.
> > 
> > Is that ok with you?
> 
> Ok, I will prepare new series of that patches and will push them
> upstream.

Great, that makes my life a lot easier.  Thanks.

greg k-h
