Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264731AbUEYE4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264731AbUEYE4T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 00:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264729AbUEYE4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 00:56:19 -0400
Received: from mail0.lsil.com ([147.145.40.20]:64766 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S264725AbUEYE4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 00:56:15 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC694@exa-atlanta>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Cc: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       "'Matthew Wilcox'" <willy@debian.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'matt_domsch@dell.com'" <matt_domsch@dell.com>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'paul@wagland.net'" <paul@wagland.net>,
       "Doelfel, Hardy" <hdoelfel@lsil.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "Prabhakaran, Rajesh" <rajeshpr@lsil.com>,
       "Jose, Manoj" <Manojj@lsil.com>
Subject: [ANNOUNCE]: megaraid driver version 2.20.0.rc2
Date: Tue, 25 May 2004 00:47:58 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

We are pleased to announce the megaraid release candidate (since it is still
in test labs at LSI) for lk 2.6

This driver incorporates the inputs from Paul Wagland, James Bottomley, Matt
Domsch, Christoph Hellwig, Arjan van de Ven, Matthew Wilcox, Marcelo
Tosatti, and many others on the scsi and kernel lists. As always, the
feedback is greatly appreciated.

Highlight of this release

1.	Fully qualified PCI identifiers to identify MegaRAID controllers
2.	PCI shutdown notification routine with hba and devices sync
3.	Support for random drive deletion
4.	Fully re-entrant hot-path w/ data structures protected by their
respective locks. No longer rely on "host_lock". Should boost performance by
5-10% and hopefully better CPU utilization
5.	Better abort and reset handling.

The patch for lk 2.6.6 and the driver is available at

ftp://ftp.lsil.com/pub/linux-megaraid/drivers/version-2.20.0.rc2/

Thanks

-Atul Mukker
LSI Logic Corporation
