Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265756AbUFSNxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265756AbUFSNxD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 09:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265764AbUFSNwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 09:52:49 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:15337 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S265755AbUFSNvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 09:51:18 -0400
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: Proposal for new generic device API: dma_get_required_mask()
References: <1087481331.2210.27.camel@mulgrave>
	<m33c4tsnex.fsf@defiant.pm.waw.pl>
	<20040618102120.A29213@flint.arm.linux.org.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 19 Jun 2004 01:10:31 +0200
In-Reply-To: <20040618102120.A29213@flint.arm.linux.org.uk> (Russell King's
 message of "Fri, 18 Jun 2004 10:21:20 +0100")
Message-ID: <m3brjg7994.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> writes:

> Good idea, except for the fact that we have drivers merged which have
> real masks like 0x0fefffff.  It _really is_ a mask and not a number
> of bits.

Which drivers do you mean? And which platforms support it?
-- 
Krzysztof Halasa, B*FH
