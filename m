Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964867AbWIPR4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbWIPR4M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 13:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWIPR4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 13:56:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36023 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964867AbWIPR4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 13:56:10 -0400
Date: Sat, 16 Sep 2006 10:54:01 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Rene Rebe <rene@exactcode.de>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] USB device stopped working - can't set config
 #1, error -71
Message-Id: <20060916105401.d7f3a1b2.zaitcev@redhat.com>
In-Reply-To: <Pine.LNX.4.44L0.0609161033550.7454-100000@netrider.rowland.org>
References: <200609161137.14307.rene@exactcode.de>
	<Pine.LNX.4.44L0.0609161033550.7454-100000@netrider.rowland.org>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.2; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sep 2006 10:39:33 -0400 (EDT), Alan Stern <stern@rowland.harvard.edu> wrote:

> with the latest kernels (definetly 2.6.17 and 1.6.8-rc*, I do now know off 
> hand when this started) I can not access some (I think all USB 1) scanners 
> via my SANE/Avision backend:
>[...]
> Try using usbmon to watch what happens when you plug in your scanner.  
> Instructions are in the kernel source file Documentation/usb/usbmon.txt.

I second that. But it would also help a lot to find a kernel which
worked, even if it's relatively old, so we'd try to diff the hub.c.

-- Pete
