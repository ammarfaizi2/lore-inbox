Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266757AbUGUWH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266757AbUGUWH1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 18:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266753AbUGUWH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 18:07:26 -0400
Received: from mail.kroah.org ([69.55.234.183]:57492 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266758AbUGUWHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 18:07:05 -0400
Date: Wed, 21 Jul 2004 18:05:29 -0400
From: Greg KH <greg@kroah.com>
To: Jesse Stockall <stockall@magma.ca>
Cc: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] delete devfs
Message-ID: <20040721220529.GB18721@kroah.com>
References: <20040721141524.GA12564@kroah.com> <200407211626.55670.oliver@neukum.org> <20040721145208.GA13522@kroah.com> <1090444782.8033.4.camel@homer.blizzard.org> <20040721212745.GC18110@kroah.com> <1090446817.8033.18.camel@homer.blizzard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090446817.8033.18.camel@homer.blizzard.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 05:53:37PM -0400, Jesse Stockall wrote:
> On Wed, 2004-07-21 at 17:27, Greg KH wrote:
> > 
> > It fixes an obviously broken chunk of code that is not maintained by
> > _anyone_.  And it will clean up all device drivers a _lot_ to have this
> > gone, which will benifit everyone in the long run.
> > 
> 
> Agreed, but this 'broken' chunk of code is 'working' for a lot of people
> (whether or not this is due to pure luck is not the point)

Pure luck.

> > As for "right now"?  Why not?  I'm just embracing the new development
> > model of the kernel :)
> 
> That's the point that Oliver and I raised, the "leave it till 2.7" (not
> breaking things for real world users) argument seems stronger than the
> "rip it now" (because it makes things cleaner, easier to code, etc)
> argument. 

The kernel development model (the whole stable/development tree thing)
has changed based on the discussions at the kernel summit yesterday.
See lwn.net for more details. That is why I sent this patch at this
point in time.

thanks,

greg k-h
