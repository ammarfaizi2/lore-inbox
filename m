Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWEVMqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWEVMqb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 08:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWEVMqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 08:46:31 -0400
Received: from ns2.suse.de ([195.135.220.15]:19856 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750802AbWEVMqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 08:46:30 -0400
From: Andi Kleen <ak@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [git patches] net driver updates
Date: Mon, 22 May 2006 14:46:23 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ayaz Abdulla <aabdulla@nvidia.com>
References: <20060520042856.GA7218@havoc.gtf.org> <4579880.1148217864672.SLOX.WebMail.wwwrun@imap-dhs.suse.de> <44707F8E.8010506@colorfullife.com>
In-Reply-To: <44707F8E.8010506@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605221446.24135.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't have any good ideas, please try to figure out what's wrong. Is 
> there a debug switch for the network layer that forces the network layer 
> to verify the CHECKSUM_UNNECESSARY blocks?
> 

Good news. The latest -git driver seems to fix the problem.

So maybe something got broken with the double request_irq.

-Andi
