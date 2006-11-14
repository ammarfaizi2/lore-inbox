Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966402AbWKNWHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966402AbWKNWHz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 17:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966403AbWKNWHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 17:07:55 -0500
Received: from gate.crashing.org ([63.228.1.57]:25036 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S966402AbWKNWHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 17:07:54 -0500
Subject: Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on
	acer ferrari 4005 with radeonfb enabled
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Hoffmann <chrmhoffmann@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Solomon Peachy <pizza@shaftnet.org>, Pavel Machek <pavel@ucw.cz>
In-Reply-To: <200611142247.55137.chrmhoffmann@gmail.com>
References: <D0233BCDB5857443B48E64A79E24B8CE6B544C@labex2.corp.trema.com>
	 <200611140008.55059.rjw@sisk.pl>
	 <200611142247.55137.chrmhoffmann@gmail.com>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 09:07:13 +1100
Message-Id: <1163542033.5940.156.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I tried that patch, but the last message I see over netconsole (using tg3) is:
> Suspending console(s)
> and then nothing. Nothing on resume at all :(
> 
> Adding some printks in the radeonfb_pci_suspend and radeonfb_pci_resume 
> (radeon_pm.c) didn't help: I don't see them. But I am not a kernel programmer 
> at all, so I might do something wrong or in the wrong place.

Does it resume if you make radeon_pci_resume() a nop ? 

Of course, the fbdev will not come back, but will the machine overall
resume ?

Ben.


