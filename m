Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262181AbVCUXi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbVCUXi1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 18:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVCUXhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 18:37:46 -0500
Received: from gate.crashing.org ([63.228.1.57]:51843 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262181AbVCUX3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 18:29:19 -0500
Subject: Re: [PATCH] alpha build fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
       chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Reiner Sailer <sailer@watson.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050321165310.A10078@jurassic.park.msu.ru>
References: <423BABBF.6030103@pobox.com> <20050319231116.GA4114@twiddle.net>
	 <20050319231641.GA28070@havoc.gtf.org>
	 <58cb370e0503210005358cf200@mail.gmail.com>
	 <20050321121616.A24129@jurassic.park.msu.ru>
	 <58cb370e0503210145375f5092@mail.gmail.com>
	 <1111408059.25180.277.camel@gaston>
	 <20050321165310.A10078@jurassic.park.msu.ru>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 10:27:27 +1100
Message-Id: <1111447647.3835.299.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Ok, but asm-generic/pci.h is not a good place for default IRQ 14/15 case -
> this header cannot be included on non-x86 without additional #ifdef's.
> Perhaps we can move it to linux/pci.h or linux/ata.h (as Bart noted)?

Well, I would have expected other archs to just make their own, but I
have no special preference here ... linux/pci.h is as good as anything.

Ben.

