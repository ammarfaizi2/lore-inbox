Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262732AbTIAHOd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 03:14:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262734AbTIAHOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 03:14:33 -0400
Received: from mail.kroah.org ([65.200.24.183]:52888 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262732AbTIAHOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 03:14:32 -0400
Date: Sun, 31 Aug 2003 23:59:28 -0700
From: Greg KH <greg@kroah.com>
To: John Stoffel <stoffel@lucent.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.0-test4-mm4 - USD disconnect oops
Message-ID: <20030901065928.GB22647@kroah.com>
References: <16210.44543.579049.520185@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16210.44543.579049.520185@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 10:25:03PM -0400, John Stoffel wrote:
> 
> This is 2.6.0-test4-mm4 with some hacks to the hotplug script to not
> modprobe the ehci-hcd or uhci-hcd modules, since they hang things even
> worse.  Sigh...

Where does the kernel hang?

> Here's the backtrace, my .config is at the end.  It's a PIII Xeon 2 x
> 550mhz, Dell Precision 610 motherboard/system, 768mb of RAM.  The only
> USB devices are the controllers and the CompactFlash reader, which
> works great under 2.4.  

Does this happen on 2.6.0-test4?  (no -mm).

thanks,

greg k-h
