Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269475AbUJTLKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269475AbUJTLKs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 07:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267632AbUJTLJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 07:09:09 -0400
Received: from i31207.upc-i.chello.nl ([62.195.31.207]:2944 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S270036AbUJTK7q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 06:59:46 -0400
Subject: Re: Delete drivers/pci/syscall.c?
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
In-Reply-To: <Pine.LNX.4.58.0410190801250.2317@ppc970.osdl.org>
References: <20041019124850.GM16153@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0410190801250.2317@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098199282.12196.13.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 19 Oct 2004 11:21:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> w X may work only on single-domain setups, or on setups where 
> the video card has a unique address when ignoring the domnain number. 
> That's pretty much all of the affected machines, so no, I don't think we 
> can/should remove it.
> 
> Will X eventually learn about multiple domains? Maybe. 

can we do something to at least try to avoid other (new) architectures
picking up these syscalls even when we can't fix the existing ones?
Or can we do like a once-per-boot printk to mark then deprecated now so
that eventually we can remove them, and that application writers realize
they are deprecated and wont use them for new code ?

