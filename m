Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbUBDX3Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 18:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264933AbUBDX3Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 18:29:24 -0500
Received: from gate.crashing.org ([63.228.1.57]:53380 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264941AbUBDX3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 18:29:04 -0500
Subject: Re: [PATCH] PCI / OF linkage in sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040204231324.GA5078@kroah.com>
References: <1075878713.992.3.camel@gaston>
	 <Pine.LNX.4.58.0402041407160.2086@home.osdl.org>
	 <20040204231324.GA5078@kroah.com>
Content-Type: text/plain
Message-Id: <1075937299.4019.41.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 05 Feb 2004 10:28:20 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Or, if you really want to be able to get the OF info from the pci device
> in sysfs, why not create a symlink in the pci device directory pointing
> to your OF path in sysfs?  That would seem like the best option.

The OF device-tree isn't in sysfs, it's in /proc/device-tree, we never
"ported" that code to sysfs for various reasons. I could start doing
so but I'm afraid I won't have time to do that before 2.6.3 and I
really want something in asap so I can finally fix the bootloader setup
and XFree once for all...

Now, if you consider a symlink to /proc/device-tree acceptable... :)

Ben.


