Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTLVBax (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 20:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264284AbTLVBax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 20:30:53 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:15512 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264277AbTLVBaw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 20:30:52 -0500
Subject: Re: [PATCH] loop.c patches, take two
From: Christophe Saout <christophe@saout.de>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m31xqx7im0.fsf@averell.firstfloor.org>
References: <MllE.6qa.7@gated-at.bofh.it> <MpyW.3Ub.9@gated-at.bofh.it>
	 <MsGq.8cN.1@gated-at.bofh.it> <MvO6.47g.7@gated-at.bofh.it>
	 <MEf3.8oB.13@gated-at.bofh.it> <MROA.319.5@gated-at.bofh.it>
	 <NxkP.4kY.17@gated-at.bofh.it> <15hUp-58e-21@gated-at.bofh.it>
	 <15iGH-6hd-17@gated-at.bofh.it> <15kfk-vj-1@gated-at.bofh.it>
	 <m31xqx7im0.fsf@averell.firstfloor.org>
Content-Type: text/plain
Message-Id: <1072056646.2237.4.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Dec 2003 02:30:46 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 22.12.2003 schrieb Andi Kleen um 02:21:

> > What about dropping block device backed support for the loop driver
> > altogether? We now have a nice device mapper in the 2.6 kernel. I don't
> 
> Device Mapper doesn't support cryptographic transformations.

I know. Not yet.

As I've written some lines below, there is a patch:
http://www.saout.de/misc/dm-crypt.diff that I've written some time ago.

I posted it some time ago but never got feedback from any "VIP" (except
for Joe Thornber who helped developing the target and thinks it looks
good). Some people tested it though and it worked for them (and better
than cryptoloop around test4).

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

