Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbTKGWJg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbTKGWIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:08:44 -0500
Received: from boo-mda02.boo.net ([216.200.67.22]:50821 "EHLO kaneda.boo.net")
	by vger.kernel.org with ESMTP id S263901AbTKGGWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 01:22:11 -0500
Message-Id: <5.2.1.1.2.20031107012419.00a956e0@boo.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Fri, 07 Nov 2003 01:28:40 -0500
To: viro@parcelfarce.linux.theplanet.co.uk
From: Jason Papadopoulos <jasonp@boo.net>
Subject: Re: Alpha: ALi 15x3 DMA completely broken now
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031106065806.GO7665@parcelfarce.linux.theplanet.co.uk>
References: <5.2.1.1.2.20031106012936.00a9b030@boo.net>
 <5.2.1.1.2.20031106012936.00a9b030@boo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:58 AM 11/6/03 +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:

 >Yes - setup_irq() fix in 2.4.23-pre8 (arch/alpha/kernel/irq.c) had
 >fixed IDE hangs on DS10 (verified for 5229 rev c1).  If that doesn't
 >help, try to narrow it down - try 2.4.21-* + irq.c change and see
 >where does it stop working.
 >
 >It should be able to do DMA at boot time, BTW:

I actually have a rev c1 controller.

And it works now, with DMA turned on at boot time. Attempting to
turn on UDMA with hdparm, even with irq.c patched, still causes
an immediate hang.

I don't care though. Thanks a million.

jasonp

