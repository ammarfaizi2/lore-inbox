Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265130AbUF1Sru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265130AbUF1Sru (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 14:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265131AbUF1Sru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 14:47:50 -0400
Received: from math.ut.ee ([193.40.5.125]:12511 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S265130AbUF1Srr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 14:47:47 -0400
Date: Mon, 28 Jun 2004 21:47:44 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Patrick Dreker <patrick@dreker.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: IDE Timeout problem on Intel PIIX3 (Triton 2) chipset
In-Reply-To: <E1Bevgk-0007jR-4F@rhn.tartu-labor>
Message-ID: <Pine.GSO.4.44.0406282142540.5432-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any kernel above and including 2.4.21 (including 2.6.5 and 2.6.7, others not
> tested) produces the following errors quite often (once or twice per minute,
> with the corresponding delay) and the harddisk drops out of DMA.

Same here. 3 computers with PIIX4, 2 (or maybe even 3, need to check the
850M Conner too) different disks (all pre-udma but mwdma, 2.5G Seagate
Medalist and 850M WD Caviar). The common denominator seems to be PIIX
chip (PIIX3 and PIIX4 reported so far) and multiword DMA.

It came with 2.4.19 for me - 2.4.18 (and thus also Debian Woody) is fine
but anything with a newer kernel (incl. 2.6.*) is broken - DMA timeouts.

So maybe it is a little different (since your 2.4.20 works) but still
very similar.

-- 
Meelis Roos (mroos@linux.ee)


