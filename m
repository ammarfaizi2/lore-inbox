Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbTILTPz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 15:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTILTPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 15:15:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:23693 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261835AbTILTPw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 15:15:52 -0400
Date: Fri, 12 Sep 2003 12:16:05 -0700
From: Greg KH <greg@kroah.com>
To: Kyle Rose <krose+linux-kernel@krose.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops during USB unloading, 2.6.0-test{4,5}. sysfs?
Message-ID: <20030912191605.GA19628@kroah.com>
References: <87he3hg8vb.fsf@nausicaa.krose.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87he3hg8vb.fsf@nausicaa.krose.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 02:27:36PM -0400, Kyle Rose wrote:
> In both test4 and test5, I get the following panic when I attempt to
> do a clean shutdown.  It happens every time.  The problem may be in
> the sysfs code given where the trace begins.  The error message given
> before reboot was that the kernel couldn't handle a NULL pointer
> dereference, but for some reason, that didn't make it into
> /var/log/messages.
> 
> BTW, if I'm not giving you guys enough interesting information about
> these problems, please let me know.  There's no such thing as too much
> information. :) I can also recompile with frame pointers, if that will
> help.

Do you have the same error if you only unload the ohci-hcd and ehci-hcd
modules?

thanks,

greg k-h
