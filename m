Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263955AbTDNV2g (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263957AbTDNV2g (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:28:36 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:60927 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263955AbTDNV2c (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 17:28:32 -0400
Date: Mon, 14 Apr 2003 14:30:54 -0700
From: Greg KH <greg@kroah.com>
To: oliver@neukum.name
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] /sbin/hotplug multiplexor
Message-ID: <20030414213054.GA5700@kroah.com>
References: <20030414190032.GA4459@kroah.com> <200304142209.56506.oliver@neukum.org> <20030414203328.GA5191@kroah.com> <200304142311.01245.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304142311.01245.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 11:11:01PM +0200, Oliver Neukum wrote:
> 
> > > Now let's be conservative and assume 16KB unswappable memory
> > > per task. Now we take the famous 4000 disk case. 64MB. A lot
> > > but probably not deadly. But multiply this by 15 and the machine is
> > > absolutely dead.
> >
> > Ok, then the "Enterprise Edition" of the distros that expect to handle
> > 4000 disks will have to add the following patch to their version of the
> > hotplug package.
> >
> > In the meantime, the other 99% of current Linux users will exist just
> > fine :)
> 
> Well, for a little elegance you might introduce subdirectories for each type
> of hotplug event and use only them.

No, that's for the individual scripts/programs to decide.  For example,
that's what the current hotplug scripts do, but that's not at all what
the udev program wants to do.

thanks,

greg k-h
