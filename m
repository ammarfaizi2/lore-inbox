Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265028AbTEPXHL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 19:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbTEPXHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 19:07:11 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:59040 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265028AbTEPXHK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 19:07:10 -0400
Date: Fri, 16 May 2003 16:21:51 -0700
From: Greg KH <greg@kroah.com>
To: jt@hpl.hp.com
Cc: Oliver Neukum <oliver@neukum.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030516232151.GB17177@kroah.com>
References: <20030515200324.GB12949@ranty.ddts.net> <200305161007.31335.oliver@neukum.org> <20030516095624.GA30397@ranty.ddts.net> <200305161753.17198.oliver@neukum.org> <20030516184920.GA26221@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030516184920.GA26221@bougret.hpl.hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 11:49:20AM -0700, Jean Tourrilhes wrote:
> 
> Many high level kernel developpers (Jeff, Alan, Greg) have said 'niet'
> to binary firmware linked with the kernel (unless there is source code
> available).

Excuse me, but I never said such a thing.  I don't mind putting firmware
blobs into kernel drivers, been doing it for years :)

I just stated that _if_ we want to move firmware to userspace, why not
have a consistant interface that all kinds of drivers can use to
accomplish this.  That is what has been done with this code.

thanks,

greg k-h
