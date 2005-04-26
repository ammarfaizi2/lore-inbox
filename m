Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVDZDkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVDZDkO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 23:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVDZDkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 23:40:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:64709 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261285AbVDZDkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 23:40:08 -0400
Subject: Re: [linux-usb-devel] Re: [PATCH] PCI: Add pci shutdown ability
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg KH <greg@kroah.com>, Amit Gud <gud@eth.net>,
       Alan Stern <stern@rowland.harvard.edu>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>, cramerj@intel.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <20050425204207.GA23724@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0504251128070.5751-100000@iolanthe.rowland.org>
	 <20050425182951.GA23209@kroah.com>
	 <SVLXCHCON1syWVLEFN00000099e@SVLXCHCON1.enterprise.veritas.com>
	 <20050425185113.GC23209@kroah.com> <20050425190606.GA23763@kroah.com>
	 <20050425204207.GA23724@elf.ucw.cz>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 13:39:20 +1000
Message-Id: <1114486761.7183.14.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Yes.
> 
> I believe it should just do suspend(PMSG_SUSPEND) before system
> shutdown. If you think distintion between shutdown and suspend is
> important (I am not 100% convinced it is), we can just add flag
> saying "this is system shutdown".
> 
> Actually this patch should be in the queue somewhere... We had it in
> suse trees for a long time, and IMO it can solve problem easily.

I think we probably want a distinct state for shutdown ...

Ben.


