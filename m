Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWJ0XCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWJ0XCE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 19:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750971AbWJ0XCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 19:02:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60862 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750967AbWJ0XCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 19:02:00 -0400
Subject: Re: [RFC: 2.6.19 patch] let PCI_MULTITHREAD_PROBE depend on BROKEN
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Greg KH <greg@kroah.com>, Stephen Hemminger <shemminger@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Matthew Wilcox <matthew@wil.cx>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20061027222326.GC27968@stusta.de>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	 <20061026224541.GQ27968@stusta.de> <20061027010252.GV27968@stusta.de>
	 <20061027012058.GH5591@parisc-linux.org>
	 <20061026182838.ac2c7e20.akpm@osdl.org>
	 <20061026191131.003f141d@localhost.localdomain>
	 <20061027170748.GA9020@kroah.com>  <20061027222326.GC27968@stusta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 28 Oct 2006 00:03:02 +0100
Message-Id: <1161990182.16839.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-10-28 am 00:23 +0200, ysgrifennodd Adrian Bunk:
> The problem is that if only 1 out of 100 people who are compiling a 
> kernel accidentally enable this option, linux-kernel will be swamped 
> with bug reports...
> 
> If it shouldn't be enabled by users, the only correct language is a 
> dependency on BROKEN.

If Greg insists of NAKking this then will you please make IDE and ATA at
least dependant on !MULTITHREADED_PROBE, as neither are safe with it
selected.

No I've no idea how you will boot a box with Greg's stuff after that
either, but I'm just pointing out the correct dependancies as the code
stands today.

Alan
