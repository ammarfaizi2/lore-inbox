Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263725AbUGYOuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUGYOuc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 10:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263995AbUGYOuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 10:50:32 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.20.8]:52187 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263725AbUGYOub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 10:50:31 -0400
Date: Sun, 25 Jul 2004 16:50:27 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Nesimi Buelbuel <nesimi.buelbuel@gmx.de>
Subject: Re: High CPU usage for disk I/O while DMA is enabled
Message-ID: <20040725145027.GB9404@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	Nesimi Buelbuel <nesimi.buelbuel@gmx.de>
References: <20040725130502.6e7f92f4@gasmaske>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040725130502.6e7f92f4@gasmaske>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> my CPU usage goes up to 100% while copying files from CD to HDD or from
> HDD to HDD.
> I have enabled DMA successfully on all of my HDD.
> 
> <snip>
> 
> I am experiencing this since my Kernel upgrade from the 2.4.x series to
> the current 2.6.7 Kernel.
> So DMA is definetely running on my box. But the CPU is utilizing too
> much while copying files.
> 
> Is there anything that I have forgot to consider in the "new" 2.6.x
> Kernel series for DMA settings?

Maybe you don't have the right IDE driver configured (CONFIG_BLK_DEV_*)...

Rudo.
