Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317606AbSIEObL>; Thu, 5 Sep 2002 10:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317610AbSIEObK>; Thu, 5 Sep 2002 10:31:10 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:3090 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S317606AbSIEObJ>; Thu, 5 Sep 2002 10:31:09 -0400
Message-Id: <200209051435.g85EZZ6H022915@pincoya.inf.utfsm.cl>
To: Mike Isely <isely@pobox.com>
cc: "Henning P. Schmiedehausen" <hps@intermeta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20-pre5-ac2: Promise Controller LBA48 DMA fixed 
In-Reply-To: Message from Mike Isely <isely@pobox.com> 
   of "Thu, 05 Sep 2002 09:12:06 EST." <Pine.LNX.4.44.0209050908350.10556-100000@grace.speakeasy.net> 
Date: Thu, 05 Sep 2002 10:35:35 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Isely <isely@pobox.com> said:
> On Thu, 5 Sep 2002, Henning P. Schmiedehausen wrote:
> 
> > Mike Isely <isely@pobox.com> writes:
> > 
> > >The trivial patch at the end of this text fixes DMA w/ LBA48 problems
> > 
> > More readable would be:
> > 
> > >-		if (!hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20246) {
> > >+		if (!(hwif->pci_dev->device == PCI_DEVICE_ID_PROMISE_20246)) {
> > 
> > 		if (hwif->pci_dev->device != PCI_DEVICE_ID_PROMISE_20246) {
> > 
> 
> Yes that is true.  But this is Andre's code and it seemed to me to be
> more important to follow his style.  But whatever...

What is wrong with != here?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
