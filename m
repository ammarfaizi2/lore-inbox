Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262296AbTICNkn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 09:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbTICNjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 09:39:51 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:54475 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262296AbTICNif (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 09:38:35 -0400
Subject: Re: CONFIG_64_BIT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030902195246.7ba3515c.ak@suse.de>
References: <20030902143424.GO13467@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
	 <p73wucrm6uo.fsf@oldwotan.suse.de>
	 <20030902174436.GP13467@parcelfarce.linux.theplanet.co.uk>
	 <20030902195246.7ba3515c.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062596254.19059.44.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 03 Sep 2003 14:37:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-02 at 18:52, Andi Kleen wrote:
> Ok, I2O and ATM and WANPIPE maybe but I assume that both are getting fixed
> Still all those are non 64bit safe, so it may be better to have an 
> CONFIG_32BIT_ONLY or similar.

I2O is currently unmaintained. I fixed some of the DMA issues but there
are still a few bits of code that pass pointers in 32bit slots rather
than using array indices.

