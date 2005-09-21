Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbVIUMao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbVIUMao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 08:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbVIUMao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 08:30:44 -0400
Received: from laf31-5-82-235-130-100.fbx.proxad.net ([82.235.130.100]:47587
	"EHLO lexbox.fr") by vger.kernel.org with ESMTP id S1750824AbVIUMao convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 08:30:44 -0400
Subject: RE: How to Force PIO mode on sata promise (Linux 2.6.10)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-class: urn:content-classes:message
Date: Wed, 21 Sep 2005 14:28:02 +0200
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Message-ID: <17AB476A04B7C842887E0EB1F268111E026FB3@xpserver.intra.lexbox.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to Force PIO mode on sata promise (Linux 2.6.10)
thread-index: AcW+pBGin444d+MZTR2wi9lOM0pFgwAAZN8Q
From: "David Sanchez" <david.sanchez@lexbox.fr>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using the linux kernel 2.6.10 and busybox on an AMD db AU1550 with a hdd connected to the pata port of a PCI card (Promise PDC20579).

I've got file copy corruption on big files (around 500MB). I made some investigations and I found that sometimes the read(fd,4096) function returns unexpected data and sometimes after a write(fd,4096) function, the data on disk is not the data send in the write() function... 

Maybe a hw bug ? A hw or sw DMA transfer bug ? or anything else... I need to known what happens so I try everything...

Any idea on my problem Jeff ?

David 

Note: I've connected a hdd through the ide interface in PIO mode and my problem seems to not appear. But when I enable DMA, I've got a lot of error messages. In other word, the DMA doesn't work (as it is wrote in the HELP of the option in the kernel) with the ide interface.

-----Message d'origine-----
De : Jeff Garzik [mailto:jgarzik@pobox.com] 
Envoyé : mercredi 21 septembre 2005 14:01
À : David Sanchez
Cc : linux-kernel@vger.kernel.org
Objet : Re: How to Force PIO mode on sata promise (Linux 2.6.10)

David Sanchez wrote:
> I'm using the Linux kernel 2.6.10 on a DBAU1550 and I would like to
> force PIO mode (and thus disable DMA) on my sata promise TX2.
> How can I do that ?

Why do you wish to do this?

	Jeff








