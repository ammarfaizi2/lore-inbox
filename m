Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269557AbTGXRVK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 13:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269575AbTGXRVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 13:21:10 -0400
Received: from math.ut.ee ([193.40.5.125]:44202 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S269557AbTGXRVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 13:21:07 -0400
Date: Thu, 24 Jul 2003 20:36:14 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: IDE DMA disabled messages for wrong drive?
Message-ID: <Pine.GSO.4.44.0307242031310.7781-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In another thread I wrote about my MWDMA mode disk problems. One thing
that I noticed there was a strange message during disabling DMA.

I access hdd, I get DMA timeouts for hdd (for whatever reasons), then
suddenly comes a message that DMA is disabled for hdc (not hdd).  hdc
was not accessed at all suring this time - it's a cdrom and no CD was
inserted and no CD access was tried.

Is this a bug?

-- 
Meelis Roos (mroos@linux.ee)


