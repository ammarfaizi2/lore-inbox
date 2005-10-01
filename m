Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbVJAX2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbVJAX2s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 19:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbVJAX2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 19:28:48 -0400
Received: from [81.2.110.250] ([81.2.110.250]:14015 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750895AbVJAX2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 19:28:47 -0400
Subject: RE: I request inclusion of SAS Transport Layer and AIC-94xx into
	the kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       "Tuikov, Luben" <Luben_Tuikov@adaptec.com>, andrew.patterson@hp.com,
       dougg@torque.net, Linus Torvalds <torvalds@osdl.org>,
       Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1128102837.3012.15.camel@laptopd505.fenrus.org>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>
	 <1128102837.3012.15.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 02 Oct 2005 00:55:52 +0100
Message-Id: <1128210952.17099.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-09-30 at 19:53 +0200, Arjan van de Ven wrote:
> that makes me wonder... why and how does T10 control linux abi's ??

Indirectly the standards do define APIs at the very least. A good
example is taskfile. ACPI methods (which we don't yet use) allow get/set
mode, get features on the motherboard ATA controller if you don't know
how to drive it. The objects they work in are taskfiles. No taskfiles,
no ACPI.

Alan

