Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVILMJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVILMJX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 08:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVILMJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 08:09:22 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:44182 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750773AbVILMJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 08:09:22 -0400
Subject: Re: [1/3] Add 4GB DMA32 zone
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, discuss@x86-64.org
In-Reply-To: <200509121322.09138.ak@suse.de>
References: <43246267.mailL4R11PXCB@suse.de> <200509121242.20910.ak@suse.de>
	 <1126524787.30449.56.camel@localhost.localdomain>
	 <200509121322.09138.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Sep 2005 13:34:33 +0100
Message-Id: <1126528473.30449.59.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-09-12 at 13:22 +0200, Andi Kleen wrote:
> And with the mempool sleep approach they will just get small queues. Yes
> that will be slower, but if you want performance on boxes with a lot of memory 
> you should not buy broken hardware.

Ironically its broken hardware it works best with. AMD64 is problematic
but Intel with the swiotlb works ;)

Ok - points made anyway, if you think the 4GB one is the best way to do
it even considering these then I've no problem with that.

