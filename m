Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTDKWmu (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTDKWmt (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:42:49 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:63617 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261994AbTDKWms (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 18:42:48 -0400
Date: Fri, 11 Apr 2003 15:56:34 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: "Kevin P. Fleming" <kpfleming@cox.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411225634.GD3786@kroah.com>
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <3E9725C5.3090503@mvista.com> <20030411204329.GT1821@kroah.com> <3E9741FD.4080007@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9741FD.4080007@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 03:30:21PM -0700, Steven Dake wrote:
> There is no "spec" that states this is a requirement, however, telecom 
> customers require the elapsed time from the time they request the disk 
> to be used, to the disk being usable by the operating system to be 20 msec.

What defines the term, "request the disk to be used"?  Slamming it into
the SCSI tray?  Mounting the device on the command line?  I don't think
you can spin up a scsi disk in 20msec today :)

> Its even more helpful for their applications if the call that hotswap 
> inserts blocks until the device is actually ready to use and available 
> in the filesystem.

What would it block from happening?  The kernel?  Userspace?  I'm
confused.

thanks,

greg k-h
