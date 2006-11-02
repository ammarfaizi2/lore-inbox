Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752669AbWKBFt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbWKBFt0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 00:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbWKBFt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 00:49:26 -0500
Received: from cantor2.suse.de ([195.135.220.15]:25051 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752669AbWKBFtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 00:49:25 -0500
Date: Wed, 1 Nov 2006 21:49:32 -0800
From: Greg KH <gregkh@suse.de>
To: "Martin J. Bligh" <mbligh@google.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Mike Galbraith <efault@gmx.de>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
Message-ID: <20061102054932.GA9849@suse.de>
References: <20061031075825.GA8913@suse.de> <45477131.4070501@google.com> <20061031174639.4d4d20e3@gondolin.boeblingen.de.ibm.com> <4547833C.5040302@google.com> <20061031182919.3a15b25a@gondolin.boeblingen.de.ibm.com> <4547FABE.502@google.com> <20061101020850.GA13070@suse.de> <45480241.2090803@google.com> <20061102052409.GA9642@suse.de> <45498174.5070309@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45498174.5070309@google.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 09:26:12PM -0800, Martin J. Bligh wrote:
> 
> >>>Even with CONFIG_SYSFS_DEPRECATED enabled?  For some reason I'm guessing
> >>>that you missed that suggestion a while back...
> >>Yes - Enabling CONFIG_SYSFS_DEPRECATED didn't help.
> >
> >Ok, you are correct, for a stupid reason, this option didn't correctly
> >work for a range of device types (I can get into the gory details if
> >anyone really cares...)
> >
> >I've now fixed this up, and a few other bugs that I kept tripping on
> >(which others also hit), and have refreshed my tree so that the next -mm
> >will be much better in this area.
> >
> >If the problem persists (and I've built a zillion different kernels in
> >different configurations today testing to make sure it doesn't), please
> >let me know.
> >
> >I can post updated patches here if people want them.
> >
> >thanks for everyone's patience, I appreciated it.
> 
> Thanks for fixing this up. If you could post a diff somewhere against
> either mainline or -mm

These changes aren't in mainline, so I'll make up something against
-mm...

thanks,

greg k-h
