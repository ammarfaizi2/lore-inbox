Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263077AbVCXJ0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbVCXJ0g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 04:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbVCXJ0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 04:26:36 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32400 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263077AbVCXJ0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 04:26:34 -0500
Date: Thu, 24 Mar 2005 10:26:23 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Li Shaohua <shaohua.li@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, rjw@sisk.pl,
       lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
Subject: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389
Message-ID: <20050324092623.GA1354@elf.ucw.cz>
References: <20050322122041.GA1414@elf.ucw.cz> <1111627799.11775.9.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111627799.11775.9.camel@sli10-desk.sh.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You can't put -ENODEV into pci_power_t ... but maybe we should create
> > PCI_ERROR and pass it in cases like this one?
> That makes sense, please do it.

Added:

#define PCI_POWER_ERROR ((pci_power_t __force) -1)

									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
