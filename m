Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265783AbUANBFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 20:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265667AbUANBFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 20:05:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:55245 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265783AbUANBFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 20:05:07 -0500
Date: Tue, 13 Jan 2004 17:05:05 -0800
From: Chris Wright <chrisw@osdl.org>
To: john moser <bluefoxicy@linux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Capabilities help
Message-ID: <20040113170505.C30560@osdlab.pdx.osdl.net>
References: <20040113235407.EA4D7393B@sitemail.everyone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040113235407.EA4D7393B@sitemail.everyone.net>; from bluefoxicy@linux.net on Tue, Jan 13, 2004 at 03:54:07PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* john moser (bluefoxicy@linux.net) wrote:
> I know this is working, because I checked my code over, plus the double
> chroot / fails.  I can still load modules, change the system time,
> and administrate the network.

First are you sure you dropped those particular bits?  Assuming you are,
what's your .config look like (esp. CONFIG_SECURITY_*)?  Can you show me
that your process is dropping a capability (say from /proc/<pid>/status),
and that the capability is still enabled?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
