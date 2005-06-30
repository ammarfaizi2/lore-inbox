Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263057AbVF3UPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbVF3UPY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbVF3UAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:00:06 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:32051 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S263032AbVF3TqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 15:46:01 -0400
Date: Thu, 30 Jun 2005 12:45:41 -0700
From: Greg KH <gregkh@suse.de>
To: John Lenz <lenz@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [GIT PATCH] Driver core patches for 2.6.13-rc1
Message-ID: <20050630194540.GA15389@suse.de>
References: <20050630060206.GA23321@kroah.com> <34128.127.0.0.1.1120152169.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34128.127.0.0.1.1120152169.squirrel@localhost>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 12:22:49PM -0500, John Lenz wrote:
> On Thu, June 30, 2005 1:02 am, Greg KH said:
> > Here are some small patches for the driver core.  They fix a bug that
> > has caused some people to see deadlocks when some drivers are unloaded
> > (like ieee1394), and add the ability to bind and unbind drivers from
> > devices from userspace (something that people have been asking for for a
> > long time.)
> 
> As long as there are a whole bunch of class API changes going on, I would
> request that the class_interface add and remove functions get passed the
> class_interface pointer as well as the class_device.  This way, the same
> function can be used on multiple class_interfaces.

I'm sorry, I seem to have missed the patch in this email that implements
this feature...

:)

thanks,

greg k-h
