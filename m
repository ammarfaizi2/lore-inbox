Return-Path: <linux-kernel-owner+w=401wt.eu-S1751395AbXAFNmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbXAFNmv (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 08:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbXAFNmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 08:42:51 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:40521 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbXAFNmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 08:42:50 -0500
X-Originating-Ip: 74.109.98.100
Date: Sat, 6 Jan 2007 08:36:23 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] DAC960: kmalloc->kzalloc/Casting cleanups
In-Reply-To: <20070106131725.GB19020@Ahmed>
Message-ID: <Pine.LNX.4.64.0701060833150.12420@localhost.localdomain>
References: <20070106131725.GB19020@Ahmed>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.541, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, SARE_SUB_OBFU_Z 0.26)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2007, Ahmed S. Darwish wrote:

> Hi all,
> I'm not able to find the DAC960 block driver maintainer. If someones knows
> please reply :).
>
> A patch to switch kmalloc->kzalloc and to clean unneeded kammloc,
> pci_alloc_consistent casts
>
> Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>
>
> diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c

  a couple bits of advice here.  you should start your patch
submission with *only* that descriptive text you want included in the
log, followed by your "Signed-off-by" line, then a line containing
"---".

  *after* that "---" line, and *before* you start the actual patch,
you can add superfluous text, like asking about who the maintainer is,
so that informal dialogue like that doesn't become part of the
permanent patch record.

  in short, your patch should look like:

A patch to switch...

Signed-off-by: ...

---

  i'm not sure who the maintainer is.  can anyone help?

diff --git ...



rday
