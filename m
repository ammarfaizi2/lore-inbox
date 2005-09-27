Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964819AbVI0M3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVI0M3L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 08:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVI0M3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 08:29:11 -0400
Received: from ns.suse.de ([195.135.220.2]:44234 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964819AbVI0M3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 08:29:11 -0400
Date: Tue, 27 Sep 2005 14:29:09 +0200
From: Olaf Hering <olh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, Stian Jordet <liste@jordet.nu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bogus VIA IRQ fixup in drivers/pci/quirks.c
Message-ID: <20050927122909.GA5824@suse.de>
References: <20050926184451.GB11752@suse.de> <Pine.LNX.4.58.0509261446590.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509261446590.3308@g5.osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Sep 26, Linus Torvalds wrote:

> > <6>USB Universal Host Controller Interface driver v2.3
> > <4>PCI: Enabling device 0000:00:0e.0 (0094 ->0095)
> > <6>PCI:Via IRQ fixup for 0000:00:0e.0, from 24 to 0
> 
> That does seem to be seriously broken.

On a side note:

echo $((24 & 15))
8

Thats what I get on my Mac, and the card works there. Also forcing the
irq to 0 doesnt break it.


-- 
short story of a lazy sysadmin:
 alias appserv=wotan
