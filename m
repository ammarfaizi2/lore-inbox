Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317541AbSIEOHa>; Thu, 5 Sep 2002 10:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317544AbSIEOHa>; Thu, 5 Sep 2002 10:07:30 -0400
Received: from grace.speakeasy.org ([216.254.0.2]:11536 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S317541AbSIEOH3>; Thu, 5 Sep 2002 10:07:29 -0400
Date: Thu, 5 Sep 2002 09:12:06 -0500 (CDT)
From: Mike Isely <isely@pobox.com>
X-X-Sender: isely@grace.speakeasy.net
Reply-To: Mike Isely <isely@pobox.com>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20-pre5-ac2: Promise Controller LBA48 DMA fixed
In-Reply-To: <al7joo$9nd$1@forge.intermeta.de>
Message-ID: <Pine.LNX.4.44.0209050908350.10556-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2002, Henning P. Schmiedehausen wrote:

> Mike Isely <isely@pobox.com> writes:
> 
> >The trivial patch at the end of this text fixes DMA w/ LBA48 problems
> 
> More readable would be:
> 
> >-		if (!hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20246) {
> >+		if (!(hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20246)) {
> 
> 		if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246) {
> 

Yes that is true.  But this is Andre's code and it seemed to me to be
more important to follow his style.  But whatever...

  -Mike


                        |         Mike Isely          |     PGP fingerprint
    POSITIVELY NO       |                             | 03 54 43 4D 75 E5 CC 92
 UNSOLICITED JUNK MAIL! |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |   (spam-foiling  address)   |


