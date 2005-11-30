Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbVK3BKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVK3BKF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 20:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbVK3BKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 20:10:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32396 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750738AbVK3BKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 20:10:02 -0500
Date: Tue, 29 Nov 2005 17:09:56 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, rjw@sisk.pl, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: Linux 2.6.15-rc3
Message-ID: <20051129170956.32e58342@dxpl.pdx.osdl.net>
In-Reply-To: <20051129233744.GA32316@kroah.com>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org>
	<200511292247.09243.rjw@sisk.pl>
	<200511292342.36228.rjw@sisk.pl>
	<20051129145328.3e5964a4@dxpl.pdx.osdl.net>
	<20051129233744.GA32316@kroah.com>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: David Brownell <david-b@pacbell.net>
> Subject: USB: ehci fixups
> 
> Rename the EHCI "reset" routine so it better matches what it does (setup);
> and move the one-time data structure setup earlier, before doing anything
> that implicitly relies on it having been completed already.
> 
> From: David Brownell <david-b@pacbell.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 

Yes, that fixed the usb problem with 2.6.15-rc3. Boots and 
USB serial works okay.

The problem with git latest still exists.



-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
