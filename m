Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267939AbUHaMAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267939AbUHaMAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 08:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268043AbUHaMAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 08:00:20 -0400
Received: from the-village.bc.nu ([81.2.110.252]:2695 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267939AbUHaMAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 08:00:16 -0400
Subject: Re: silent semantic changes with reiser4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tom Vier <tmv@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org>
References: <20040825163225.4441cfdd.akpm@osdl.org>
	 <20040825233739.GP10907@legion.cup.hp.com>
	 <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy>
	 <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy>
	 <20040826053200.GU31237@waste.org> <20040826075348.GT1284@nysv.org>
	 <20040826163234.GA9047@delft.aura.cs.cmu.edu>
	 <Pine.LNX.4.58.0408260936550.2304@ppc970.osdl.org>
	 <20040831033950.GA32404@zero>
	 <Pine.LNX.4.58.0408302055270.2295@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093949876.32682.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 31 Aug 2004 11:57:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-31 at 05:08, Linus Torvalds wrote:
> > What about microkernels? They do tcp in userspace.
> 
> No they don't. They do TCP in a separate address space from user space, 
> that just also happens to be separate from the "microkernel address 
> space".

Several do TCP in user space. The only thing you need in kernel for
TCP/IP is enough decode to decide who gets the packet. Even some non
microkernel embedded OS's do this in order to keep kernel size down.

Alan

