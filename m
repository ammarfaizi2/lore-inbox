Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTLKHOJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 02:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbTLKHLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 02:11:51 -0500
Received: from mail.kroah.org ([65.200.24.183]:13766 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264371AbTLKHJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 02:09:31 -0500
Date: Wed, 10 Dec 2003 22:46:52 -0800
From: Greg KH <greg@kroah.com>
To: Vince <fuzzy77@free.fr>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>, Duncan Sands <baldrick@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, mfedyk@matchmail.com,
       zwane@holomorphy.com, linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Message-ID: <20031211064652.GB2529@kroah.com>
References: <20031210153056.GA7087@kroah.com> <Pine.LNX.4.44L0.0312101212480.850-100000@ida.rowland.org> <20031210204621.GA8566@kroah.com> <20031210210854.GA8724@kroah.com> <3FD7D219.7030408@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD7D219.7030408@free.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 11, 2003 at 03:10:33AM +0100, Vince wrote:
> I've tried this patch together with Duncan's fix for my first problem 
> and I couldn't reproduce any oops on my system. I've only tried a few (a 
> dozen) cyles of loading/unloading for now (but earlier that was much 
> enough to trigger an oops). I'll report later if/when I get any bad 
> behaviour but so far everything looks fine.

Hm, on my box, it seems to unload just fine, but oopses when loading the
ehci driver again (ohci and uhci loaded just fine.)  If I get the chance
tomorrow I'll try to figure it out...

thanks,

greg k-h
