Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTHUXRv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 19:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262968AbTHUXRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 19:17:51 -0400
Received: from mail.kroah.org ([65.200.24.183]:30637 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262942AbTHUXRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 19:17:49 -0400
Date: Thu, 21 Aug 2003 15:56:14 -0700
From: Greg KH <greg@kroah.com>
To: cb-lkml@fish.zetnet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] [USB] [2.6.0-test3] crash after inserting bluetooth dongle
Message-ID: <20030821225614.GA5287@kroah.com>
References: <20030821211409.GA2062@fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030821211409.GA2062@fish.zetnet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 10:14:10PM +0100, cb-lkml@fish.zetnet.co.uk wrote:
> 
> Kernel is 2.6.0-test3 with ingo's -G7 scheduler, and a patch from rmk with
> additional printk's in cs.c which I used because I was getting the 'every other
> insert' problem. That seems to have gone away anyway, but now USB doesn't work
> at all. It used to work up until I used APM suspend, but now it doesn't work
> even after a clean reboot.
> 
> I got this oops. Suspicious /proc/interrupts is below, as well as
> /proc/ioports, dmesg output, config, and lspci -vvv.

This has been fixed in the test3-bk tree, I would suggest either waiting
for test4, or downloading the latest -bk patch.

If this still happens in 2.6.0-test4, please let the bluetooth driver
author know about it.

thanks,

greg k-h
