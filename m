Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWHLBAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWHLBAE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 21:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWHLBAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 21:00:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:9887 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964810AbWHLBAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 21:00:03 -0400
Date: Fri, 11 Aug 2006 17:59:59 -0700
From: Greg KH <greg@kroah.com>
To: Louis Garcia II <louisg00@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Status of driver core struct device changes?
Message-ID: <20060812005959.GA25689@kroah.com>
References: <1155332969.2652.8.camel@soncomputer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155332969.2652.8.camel@soncomputer>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2006 at 05:49:29PM -0400, Louis Garcia II wrote:
> A couple of months ago greg kh started work toward allowing everything
> to be a struct device in the sysfs device tree. How is this progressing?

Quite well.  But next time you might want to CC: me as I almost missed
this message.

> Any time frame when we will have a simplified driver core api?

It's getting there.  If you look in -mm there are a lot of subsystems
already converted over, along with a lot of patches from andrew that
revert these changes due to udev issues.

I'm working on fixing up the udev issues so that the kernel work is not
held up.  That's a bit slower going as it requires me to install a lot
of different distros...

thanks,

greg k-h
