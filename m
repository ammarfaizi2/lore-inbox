Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbTDKRIU (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 13:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbTDKRIS (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 13:08:18 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:46026 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261360AbTDKRII (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 13:08:08 -0400
Date: Fri, 11 Apr 2003 10:21:57 -0700
From: Greg KH <greg@kroah.com>
To: Jeremy Jackson <jerj@coplanar.net>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411172157.GB1821@kroah.com>
References: <20030411032424.GA3688@kroah.com> <1050081047.1252.4.camel@contact.skynet.coplanar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050081047.1252.4.camel@contact.skynet.coplanar.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 01:10:47PM -0400, Jeremy Jackson wrote:
> What about read-only root fs?

Make /dev a ramfs partition.

> What about the root= kernel command line ever working?

See next answer.

> What about initrd issues?

You mean initramfs, right?  :)
I wrote this in C for it to go into initramfs so that it would get
called at device discovery early in the boot process so that the root=
issue would work transparently.

thanks,

greg k-h
