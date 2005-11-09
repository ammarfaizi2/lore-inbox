Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751621AbVKIXod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbVKIXod (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 18:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbVKIXod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 18:44:33 -0500
Received: from gate.crashing.org ([63.228.1.57]:49328 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751619AbVKIXoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 18:44:32 -0500
Subject: Re: [PATCH] ppc64: 64K pages support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20051109172125.GA12861@lst.de>
References: <1130915220.20136.14.camel@gaston>
	 <1130916198.20136.17.camel@gaston>  <20051109172125.GA12861@lst.de>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 10:42:32 +1100
Message-Id: <1131579752.24637.117.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-09 at 18:21 +0100, Christoph Hellwig wrote:
> Booting current mainline with 64K pagesize enabled gives me a purple (!)
> screen early during boot.

Do you use one of the nvidia fbdev's ? What if you disable it ?

(Also, rivafb has some funky bugs on my iMac G5, though nvidiafb works
fine with the latest fixes that are now in -git, but I haven't tried
with 64K pages enabled in the .config yet).

Ben.


