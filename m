Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVBPBBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVBPBBm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 20:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVBPBBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 20:01:40 -0500
Received: from gate.crashing.org ([63.228.1.57]:32143 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261704AbVBPBBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 20:01:34 -0500
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200502151645.27774.jbarnes@sgi.com>
References: <200502151557.06049.jbarnes@sgi.com>
	 <9e473391050215163621dafa65@mail.gmail.com>
	 <200502151645.27774.jbarnes@sgi.com>
Content-Type: text/plain
Date: Wed, 16 Feb 2005 12:00:31 +1100
Message-Id: <1108515632.13394.59.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I thought the signature described what type of ROM was there?  E.g. 0xaa55 
> means x86 ROM, x0303 means OF ROM, etc.?
> 
> At any rate, not having a ROM at all (which my case may be) isn't an error 
> either, so I think removing the printk is appropriate regardless.

Oh, and if this is the PowerBook, then you don't have a ROM attached to
the video chip, the OF driver is part of the main system ROM.

Ben.


