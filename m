Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261529AbVGCVAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbVGCVAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 17:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVGCVAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 17:00:08 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:13672 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261529AbVGCVAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 17:00:04 -0400
Date: Sun, 3 Jul 2005 13:59:55 -0700
From: Greg KH <gregkh@suse.de>
To: John Lenz <lenz@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add class_interface pointer to add and remove functions
Message-ID: <20050703205955.GB17461@suse.de>
References: <20050630060206.GA23321@kroah.com> <34128.127.0.0.1.1120152169.squirrel@localhost> <20050630194540.GA15389@suse.de> <37114.127.0.0.1.1120166322.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37114.127.0.0.1.1120166322.squirrel@localhost>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2005 at 04:18:42PM -0500, John Lenz wrote:
> On Thu, June 30, 2005 2:45 pm, Greg KH said:
> > On Thu, Jun 30, 2005 at 12:22:49PM -0500, John Lenz wrote:
> >> As long as there are a whole bunch of class API changes going on, I would
> >> request that the class_interface add and remove functions get passed the
> >> class_interface pointer as well as the class_device.  This way, the same
> >> function can be used on multiple class_interfaces.
> >
> > I'm sorry, I seem to have missed the patch in this email that implements
> > this feature...
> >
> 
> Here is a patch that updates every usage of class_interface I could find.

Do you have a patch that will take advantage of this change?  I would
prefer to have that before accepting this patch.

thanks,

greg k-h
