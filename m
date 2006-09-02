Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWIBKcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWIBKcN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 06:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWIBKcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 06:32:13 -0400
Received: from A.painless.aaisp.net.uk ([81.187.81.51]:65479 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S1751014AbWIBKcM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 06:32:12 -0400
Date: Sat, 2 Sep 2006 11:31:56 +0100
From: Andrew Clayton <andrew@digital-domain.net>
To: Greg KH <greg@kroah.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@suse.de>
Subject: Re: [Bugme-new] [Bug 7065] New: Devices no longer automount
Message-ID: <20060902113156.0cee3f1c@alpha.digital-domain.net>
In-Reply-To: <20060902095143.GA27196@kroah.com>
References: <200608281700.k7SH0CYl013187@fire-2.osdl.org>
	<20060828121057.035fd690.akpm@osdl.org>
	<20060902094239.GH26849@kroah.com>
	<44F95364.8020901@goop.org>
	<20060902095143.GA27196@kroah.com>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.6.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Sep 2006 02:51:43 -0700, Greg KH wrote:

> On Sat, Sep 02, 2006 at 02:48:20AM -0700, Jeremy Fitzhardinge wrote:
> > Greg KH wrote:
> > >This was narrowed down to a broken userspace configuration by the
> > >freedesktop.org developers.
> > >
> > >Many thanks to them.
> > >
> > >So no kernel issue here.
> > >  
> > 
> > Do you have a reference to what the fix is?
> 
> Are you having this same problem?  I think it was an invalid HAL
> configuration file from what I heard.  Kay would know for sure.

I was unsure what was actually broke as it happened at the same time on
three different machines.

On my laptop I removed udev and hal and reinstalled them (got an
updated udev in the process) and now it works with 2.6.18-rc5.

> thanks,
> 
> greg k-h


Cheers,

Andrew
