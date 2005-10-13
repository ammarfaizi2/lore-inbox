Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbVJMVVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVJMVVO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 17:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964835AbVJMVVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 17:21:14 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:49109 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964832AbVJMVVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 17:21:13 -0400
Date: Thu, 13 Oct 2005 23:19:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] 1/2  EDAC  (Core Code)
Message-ID: <20051013211911.GA15477@elf.ucw.cz>
References: <1129043623.23677.75.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129043623.23677.75.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is a pair of patches that add the basic ECC and related chipset
> handling to the kernel. Various "interesting" patches have kicked around
> since Dan Hollis original work some years ago. Since then many people
> have picked up the code and improved on it.
> 
> The current code (bluesmoke.sf.net) has some very fancy NMI handling
> features and other complex open issues with NMI during a PCI transaction
> and the like.
> 
> This code is a subset and the maintainer agrees this is the best
> approach to merging.
> 
> >From the original repository
> 
> -	2.4 and other compatibility code removed
> -	Some commenting added
> -	A couple of 32bit isms cleaned up
> -	Move several drivers from pci_find to pci_get
> -	Remove all the NMI layer handling so that the code requires no core
> changes
> -	Rename from bluesmoke to EDAC (Correct name for the whole field of ECC
> and friends) to avoid confusion

I'd say thta bluesmoke is *way* better name than EDAC. We don't need
yet another ETLA.
								Pavel

-- 
Thanks, Sharp!
