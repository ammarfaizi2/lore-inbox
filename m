Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266115AbTIKAVx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 20:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266116AbTIKAVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 20:21:53 -0400
Received: from mail.kroah.org ([65.200.24.183]:61569 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266115AbTIKAVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 20:21:51 -0400
Date: Wed, 10 Sep 2003 17:21:35 -0700
From: Greg KH <greg@kroah.com>
To: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [RFC] add kobject to struct module
Message-ID: <20030911002135.GB6996@kroah.com>
References: <20030909222421.GA7703@kroah.com> <20030911003247.V30046@flint.arm.linux.org.uk> <20030910234538.GB6719@kroah.com> <20030911000429.GF1461@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911000429.GF1461@matchmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 05:04:29PM -0700, Mike Fedyk wrote:
> On Wed, Sep 10, 2003 at 04:45:38PM -0700, Greg KH wrote:
> > To quote from include/linux/moduleparam.h:
> > /* This is the fundamental function for registering boot/module
> >    parameters.  perm sets the visibility in driverfs: 000 means it's
> >    not there, read bits mean it's readable, write bits mean it's
> >    writable. */
> 
> Any chance to make it always visible and read-only by default with the
> option of making it writable?

I don't know.  Doesn't matter to me.

> Exposing the module options would be very helpful.
> 
> Also showing its read/write in the sysfs directory listing would be great.
> (if it doesn't already do that).

Look at the permission bits :)

> Any chance the parameter defaults (if they're not hard coded...) could be
> exposed even if they're not given to the module on the command line?  (wish
> list...)

That's probably just a modinfo hack.

thanks,

greg k-h
