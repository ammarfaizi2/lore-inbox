Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbWILUK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWILUK7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 16:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030401AbWILUK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 16:10:59 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:57860 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030398AbWILUK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 16:10:58 -0400
Date: Tue, 12 Sep 2006 16:10:57 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Mattia Dongili <malattia@linux.it>
cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] 2.6.18-rc6-mm1
In-Reply-To: <20060912180412.GA3947@inferi.kami.home>
Message-ID: <Pine.LNX.4.44L0.0609121605200.5686-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2006, Mattia Dongili wrote:

> No luck here. I'll give -mm2 a run just to 
> 
> full dmesg
> with patch applied[1]:
> http://oioio.altervista.org/linux/dmesg-2.6.18-rc6-mm1-fail-S3-2
> 
> without it (it's almost identical :)):
> http://oioio.altervista.org/linux/dmesg-2.6.18-rc6-mm1-fail-S3
> 
> .config:
> http://oioio.altervista.org/linux/config-2.6.18-rc6-mm1-3
> 
> [1]: I didn't rebuild fully, just applied the patch and re-run make
> bzImage modules

I can't reproduce your results here with my configuration.  I used 
2.6.18-rc6-mm2 instead of -mm1 but I don't think that should matter.

(It's also a little awkward to try.  My system has the annoying habit of 
waking up from suspend-to-RAM with the screen non-functional.  No doubt a 
BIOS problem.)

Please try this again after setting CONFIG_USB_DEBUG.  It's hard to say 
anything definite without more debugging info.

Alan Stern

