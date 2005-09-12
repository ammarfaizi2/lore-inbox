Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750771AbVILMIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbVILMIV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 08:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVILMIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 08:08:21 -0400
Received: from magic.adaptec.com ([216.52.22.17]:57579 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1750771AbVILMIV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 08:08:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [1/3] Add 4GB DMA32 zone
Date: Mon, 12 Sep 2005 08:08:18 -0400
Message-ID: <547AF3BD0F3F0B4CBDC379BAC7E4189F01919BD1@otce2k03.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [1/3] Add 4GB DMA32 zone
Thread-Index: AcW3kHDiWH2PYjSfRXKFmujW+vBJEwAAVl4w
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <torvalds@osdl.org>,
       <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen [mailto:ak@suse.de] writes:
> Ok that makes a lot of sense.  You should probably be really using 
> pci_alloc_consistent() instead of GFP_DMA directly here, but other
than that it should just work.
scsi-misc-2.6 version of the driver has but one left in an ioctl call
that could be converted over ... Mostly done.

> Anyways, it shows the aacraid doesn't need GFP_DMA32 at all, which is
good.
>
> I hope there are no other concerns about the patch and Linus could
just merge it now? 

Few concerns from me once the remaining driver source propagates, we
will watch carefully and hopefully turn around bugfix patches quickly in
the driver should it be needed. I seem to loose sleep at night over the
legacy cards doing yet another strangeness ;-/

-- Mark

