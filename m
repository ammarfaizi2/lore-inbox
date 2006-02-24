Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWBXH56@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWBXH56 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 02:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWBXH56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 02:57:58 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:10451 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S1750805AbWBXH55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 02:57:57 -0500
From: Wolfgang Hoffmann <woho@woho.de>
Reply-To: woho@woho.de
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [git patches] net driver fixes
Date: Fri, 24 Feb 2006 08:59:22 +0100
User-Agent: KMail/1.8
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20060224052214.GA14586@havoc.gtf.org>
In-Reply-To: <20060224052214.GA14586@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602240859.23062.woho@woho.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 February 2006 06:22, Jeff Garzik wrote:
> Please pull from 'upstream-fixes' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/netdev-2.6.git
>
> [...]
> Stephen Hemminger:
>       sky2: yukon-ec-u chipset initialization
>       sky2: limit coalescing values to ring size
>       sky2: poke coalescing timer to fix hang
>       sky2: force early transmit status
>       sky2: use device iomem to access PCI config
>       sky2: close race on IRQ mask update.
>[...]

Thanks for the update.

Still I'm seeing reproducable hangs with this version of sky2 (as reported in 
bugzilla 6084 and discussed on netdev).

Stephen, if there is anything I can do to narrow down my hangs a bit more 
systematically, please let me know, I'd be happy to help.

Wolfgang
