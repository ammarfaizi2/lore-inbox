Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265473AbTFMSNX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 14:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265476AbTFMSNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 14:13:23 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:19382 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265473AbTFMSNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 14:13:14 -0400
Date: Fri, 13 Jun 2003 11:24:52 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030613182452.GE6037@kroah.com>
References: <3EE8D038.7090600@mvista.com> <200306130027.09288.oliver@neukum.org> <3EE9F5C7.8070304@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE9F5C7.8070304@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 09:03:19AM -0700, Steven Dake wrote:
> devfs is not appropriate as it does not allow for complex policy with 
> external attributes that the kernel is unaware of.  For an example, lets 
> take the situation where a policy must access a cluster-wide manager to 
> determine some information before it can make a policy decision.  For 
> that to occur, there must be sockets, and hopefully libc, which puts the 
> entire thing in user space.  Who would want to write policies in the 
> kernel?  uck.

Look at devfsd, it is in userspace.

greg k-h
