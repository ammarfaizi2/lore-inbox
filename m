Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWHHVdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWHHVdZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWHHVdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:33:25 -0400
Received: from A.painless.aaisp.net.uk ([81.187.81.51]:19120 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S964984AbWHHVdY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:33:24 -0400
Date: Tue, 8 Aug 2006 22:33:21 +0100
From: Andrew Clayton <andrew@digital-domain.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc strange hotplug/udev/uevent problem
Message-ID: <20060808223321.45802fec@alpha.digital-domain.net>
In-Reply-To: <20060808060211.GA3206@kroah.com>
References: <44D79574.8080703@digital-domain.net>
	<20060808060211.GA3206@kroah.com>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.6.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2006 23:02:11 -0700, Greg KH wrote:

> On Mon, Aug 07, 2006 at 08:33:08PM +0100, Andrew Clayton wrote:

> > If you rmmod the sd_mod module and plug in, then it will get
> > mounted.
> 
> That's just wierd.  I can't think of anything that has changed
> recently to cause this.
> 
> Can you use 'git bisect' to try to narrow it down which change caused
> the problem?

I've done a binary search of kernels and found that the breakage occurs
between 2.6.17-git3 and 2.6.17-git4

Next I'll figure out git bisect to try and narrow it further.

> thansk,
> 
> greg k-h


Cheers,

Andrew
