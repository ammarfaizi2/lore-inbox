Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264577AbTDPULm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 16:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264578AbTDPULm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 16:11:42 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:55709 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264577AbTDPULE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 16:11:04 -0400
Date: Wed, 16 Apr 2003 13:24:12 -0700
From: Greg KH <greg@kroah.com>
To: Niels den Otter <otter@surfnet.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.67-bk6: usb_hotplug problem in usb.c
Message-ID: <20030416202412.GA19852@kroah.com>
References: <20030416150935.GA824@surfnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030416150935.GA824@surfnet.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 05:09:35PM +0200, Niels den Otter wrote:
> An rmmod of module uhci_hcd using kernel 2.5.67-bk6 gives the following
> dump on my laptop. Looks like a problem in the usb_hotplug function. I
> have my attached my kernel config to this e-mail.

Known problem, a patch that gets rid of this symtom has been posted
here, and to linux-usb-devel in the past.  It's also in the -mm tree.

I have a number of USB patches queued up to send to Linus to fix this
problem for real, but am waiting for the kernel.org machines to come up
again to send them off.

Thanks,

greg k-h
