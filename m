Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVGFJKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVGFJKb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 05:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVGFJKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 05:10:31 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:1228 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S262123AbVGFHRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 03:17:34 -0400
Date: Wed, 6 Jul 2005 00:17:30 -0700
From: Greg KH <gregkh@suse.de>
To: John Lenz <lenz@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add class_interface pointer to add and remove functions
Message-ID: <20050706071730.GA18669@suse.de>
References: <20050630060206.GA23321@kroah.com> <34128.127.0.0.1.1120152169.squirrel@localhost> <20050630194540.GA15389@suse.de> <37114.127.0.0.1.1120166322.squirrel@localhost> <20050703205955.GB17461@suse.de> <41050.127.0.0.1.1120617353.squirrel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41050.127.0.0.1.1120617353.squirrel@localhost>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 09:35:53PM -0500, John Lenz wrote:
> On Sun, July 3, 2005 3:59 pm, Greg KH said:
> > On Thu, Jun 30, 2005 at 04:18:42PM -0500, John Lenz wrote:
> >> Here is a patch that updates every usage of class_interface I could
> >> find.
> >
> > Do you have a patch that will take advantage of this change?  I would
> > prefer to have that before accepting this patch.
> >
> 
> No, not for inclusion.  I needed this change while I was working on the
> touchscreen driver for Zaurus (http://www.cs.wisc.edu/~lenz/zaurus).  I
> have not yet completed that driver, and am currently working on some other
> drivers.  So I won't really have a patch until I (or someone else, we can
> always use volunteers!) goes back and tries to work on the touchscreen
> driver.
> 
> I just thought that since the class API is changing anyway, this API
> change could come along.  Otherwise I will resubmit this patch when I (or
> someone else) gets around to working on the touchscreen driver.

Yeah, I prefer to wait until someone uses it.  There's no reason we
can't change the API any time we need to :)

thanks,

greg k-h
