Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265978AbUHPMOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUHPMOm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 08:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267575AbUHPMOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 08:14:42 -0400
Received: from the-village.bc.nu ([81.2.110.252]:50659 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265978AbUHPMOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 08:14:34 -0400
Subject: Re: your mail
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Airlie <airlied@linux.ie>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040816105014.A9367@infradead.org>
References: <Pine.LNX.4.58.0408151311340.27003@skynet>
	 <20040815133432.A1750@infradead.org>
	 <Pine.LNX.4.58.0408160038320.9944@skynet>
	 <20040816101732.A9150@infradead.org>
	 <Pine.LNX.4.58.0408161019040.21177@skynet>
	 <20040816105014.A9367@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092654719.20523.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 Aug 2004 12:12:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-16 at 10:50, Christoph Hellwig wrote:
> no, now you're acting like an even more broken driver, preventing a fbdev
> driver to be loaded afterwards and doing all kinds of funny things.  Please
> revert to the old method until you have a common pci_driver for fbdev and dri.

fbdev and DRI are not functional together in the general case. They
sometimes happen to work by luck. fbdev and X for that matter are
generally incompatible except unaccelerated.


