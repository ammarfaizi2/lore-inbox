Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbVIDOUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbVIDOUZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 10:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750850AbVIDOUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 10:20:25 -0400
Received: from ns.suse.de ([195.135.220.2]:61077 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750830AbVIDOUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 10:20:24 -0400
From: Andreas Schwab <schwab@suse.de>
To: Olaf Hering <olh@suse.de>
Cc: Jesse Barnes <jbarnes@sgi.com>, Jon Smirl <jonsmirl@gmail.com>,
       akpm@osdl.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
References: <200502151557.06049.jbarnes@sgi.com>
	<20050904132704.GA27274@suse.de>
X-Yow: Quick, sing me the BUDAPEST NATIONAL ANTHEM!!
Date: Sun, 04 Sep 2005 16:20:10 +0200
In-Reply-To: <20050904132704.GA27274@suse.de> (Olaf Hering's message of "Sun,
	4 Sep 2005 15:27:04 +0200")
Message-ID: <jeu0h0kj8l.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olh@suse.de> writes:

> -		printk(KERN_ERR "radeonfb (%s): Invalid ROM signature %x should be"
> +		printk(KERN_DEBUG "radeonfb (%s): Invalid ROM signature %x should be"
>  		       "0xaa55\n", pci_name(rinfo->pdev), BIOS_IN16(0));

While you are at it you could also add the missing space.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
