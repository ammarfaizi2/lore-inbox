Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWJ0W6a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWJ0W6a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 18:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWJ0W6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 18:58:30 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28361 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750836AbWJ0W63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 18:58:29 -0400
Subject: Re: [RFC: 2.6.19 patch] let PCI_MULTITHREAD_PROBE depend on BROKEN
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <20061027170748.GA9020@kroah.com>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	 <20061026224541.GQ27968@stusta.de> <20061027010252.GV27968@stusta.de>
	 <20061027012058.GH5591@parisc-linux.org>
	 <20061026182838.ac2c7e20.akpm@osdl.org>
	 <20061026191131.003f141d@localhost.localdomain>
	 <20061027170748.GA9020@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 27 Oct 2006 23:57:31 +0100
Message-Id: <1161989851.16839.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-27 am 10:07 -0700, ysgrifennodd Greg KH:
> It's a very experimental feature, as the help text says.  If you can
> think of any harsher language to put in that text, please let me know.

The ATA drivers use text like (RAVING LUNATIC) for such things.
Realistically right now the multithread_probe stuff is useless because
your hardware ends up randomly re-ordered and everything breaks.

