Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267211AbUBMWAJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 17:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267246AbUBMWAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 17:00:09 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:15115 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267211AbUBMWAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 17:00:07 -0500
Date: Fri, 13 Feb 2004 22:00:03 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] New radeonfb
In-Reply-To: <1076566810.12556.178.camel@gaston>
Message-ID: <Pine.LNX.4.44.0402132141080.17669-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Linus: This new driver uses framebuffer_alloc/release, so if you back
> out the fb sysfs patch, make sure to replace it with wrapper functions
> that just kmalloc/kfree

No need to back out the sysfs patch since I have new patches coming for 
the drivers. I just finished out how to deal with non pci devices. 


