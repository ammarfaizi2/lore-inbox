Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbTD2QPe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 12:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbTD2QPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 12:15:34 -0400
Received: from mail0.lsil.com ([147.145.40.20]:21481 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261334AbTD2QPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 12:15:33 -0400
Message-Id: <0E3FA95632D6D047BA649F95DAB60E570185F15D@EXA-ATLANTA.se.lsil.com>
From: "Mukker, Atul" <atulm@lsil.com>
To: prequejo@dbs.es, linux-kernel@vger.kernel.org
Cc: "'Martin_List-Petersen@Dell.com'" <Martin_List-Petersen@Dell.com>
Subject: RE: LSI MegaRAID ATA driver (COMPAQ Proliant DL-320 G2)
Date: Tue, 29 Apr 2003 12:27:37 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> > Well... Now, I need to upgrade and rebuild the kernel (2.4.18 
> > to 2.4.20)
> > but, I haven't got the source code of the LSI MegaRAID ATA 
> controller.
> > 
That's right, the source for this software stack is not released under GPL.
We do release the RPM packages to update driver. This is true for the stock
kernels only. It is not possible to use the RPM for all (or individually
compiled) kernels

> 
> Shouldn't that more or less be the same as the LSI MegaRaid 
> SCSI driver.
> Both adapters are based on the same BIOS design.
> 
> I'm pretty sure, that it should work on the default MegaRaid 
> module (SCSI
> low-level drivers).
No, these are separate drivers, at least as of now.

-Atul Mukker <atulm@lsil.com>
