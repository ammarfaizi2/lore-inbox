Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266624AbUGUV3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266624AbUGUV3h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 17:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266738AbUGUV3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 17:29:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:59264 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266624AbUGUV3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 17:29:35 -0400
Date: Wed, 21 Jul 2004 17:27:52 -0400
From: Greg KH <greg@kroah.com>
To: Jesse Stockall <stockall@magma.ca>
Cc: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] delete devfs
Message-ID: <20040721212745.GC18110@kroah.com>
References: <20040721141524.GA12564@kroah.com> <200407211626.55670.oliver@neukum.org> <20040721145208.GA13522@kroah.com> <1090444782.8033.4.camel@homer.blizzard.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090444782.8033.4.camel@homer.blizzard.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 05:19:42PM -0400, Jesse Stockall wrote:
> On Wed, 2004-07-21 at 10:52, Greg KH wrote:
> > 
> > And as Lars points out, the code is unmaintained, unused, and buggy.
> > All good reasons to rip out it out at any moment in time.
> 
> Unused? Since when does every Linux user use a vendor supplied kernel? I
> have no use for devfs, never used it in the past, and I'm a happy udev
> user now, but that doesn't change the fact that there are many devfs
> users out there.
> 
> What does this gain us right now?

It fixes an obviously broken chunk of code that is not maintained by
_anyone_.  And it will clean up all device drivers a _lot_ to have this
gone, which will benifit everyone in the long run.

As for "right now"?  Why not?  I'm just embracing the new development
model of the kernel :)

thanks,

greg k-h
