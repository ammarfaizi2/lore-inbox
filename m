Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbTEUUq6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 16:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTEUUq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 16:46:58 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:8073 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262313AbTEUUq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 16:46:57 -0400
Date: Wed, 21 May 2003 14:01:54 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com, baldrick@wanadoo.fr
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [BK PATCH] Yet more USB changes for 2.5.69
Message-ID: <20030521210154.GA2991@kroah.com>
References: <20030521004509.GA7055@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030521004509.GA7055@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I messed up merging some patches yesterday, and I've now fixed that up.
Could you please pull from:
 
	bk://kernel.bkbits.net/gregkh/linux/linus-2.5

To get the following changes?

thanks,

greg k-h


 drivers/usb/misc/speedtch.c     | 1086 +++++++++++++++++-----------------------
 drivers/usb/storage/transport.c |    2 
 drivers/usb/storage/transport.h |    2 
 3 files changed, 487 insertions(+), 603 deletions(-)
-----

Duncan Sands:
  o USB speedtouch: receive code rewrite
  o USB speedtouch: receive path micro optimization
  o USB speedtouch: remove useless NULL pointer checks
  o USB speedtouch: kfree_skb -> dev_kfree_skb
  o USB speedtouch: send path micro optimizations
  o USB speedtouch: use optimally sized reconstruction buffers
  o USB speedtouch: remove stale code
  o USB speedtouch: verbose debugging
  o USB speedtouch: spin_lock_irqsave -> spin_lock_irq in tasklets
  o USB speedtouch: spin_lock_irqsave -> spin_lock_irq in process context
  o USB speedtouch: add defensive memory barriers
  o USB speedtouch: replace yield()
  o USB speedtouch: trivial whitespace and name changes

Greg Kroah-Hartman:
  o USB: speedtch merge fixups by hand

Vojtech Pavlik:
  o USB: Make Olympus cameras work with usb-storage

