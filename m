Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265281AbTF1Qiw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 12:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265284AbTF1Qiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 12:38:52 -0400
Received: from granite.he.net ([216.218.226.66]:30224 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265281AbTF1Qiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 12:38:51 -0400
Date: Sat, 28 Jun 2003 09:46:34 -0700
From: Greg KH <greg@kroah.com>
To: cb-lkml@fish.zetnet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [USB] [2.5.73-mm1] /etc/init.d/hotplug stop (rmmod uhci-hcd) never returns
Message-ID: <20030628164634.GA1619@kroah.com>
References: <20030628082441.GA1979@fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030628082441.GA1979@fish.zetnet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 28, 2003 at 09:24:41AM +0100, cb-lkml@fish.zetnet.co.uk wrote:
> 
> Following suspend/resume with a USB mouse connected, I found thousands of:
> drivers/usb/host/uhci-hcd.c: fca0: host controller halted. very bad

Try unloading the uhci-hcd driver before suspending.  I think most
people have reported success that way.

thanks,

greg k-h
