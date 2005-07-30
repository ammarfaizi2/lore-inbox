Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263027AbVG3Jm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263027AbVG3Jm4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 05:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbVG3Jm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 05:42:56 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:8346 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S263027AbVG3Jm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 05:42:56 -0400
From: Grant Coady <lkml@dodo.com.au>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Gaston, Jason D" <jason.d.gaston@intel.com>, mj@ucw.cz, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 2.6.13-rc4 1/1] pci_ids: patch for Intel ICH7R
Date: Sat, 30 Jul 2005 19:42:44 +1000
Organization: www.scatter.mine.nu
Reply-To: lkml@dodo.com.au
Message-ID: <j9ime15b20eq23q1bnrbh1fnj34gch7lbp@4ax.com>
References: <26CEE2C804D7BE47BC4686CDE863D0F5046EA44B@orsmsx410> <42EAABD1.8050903@pobox.com>
In-Reply-To: <42EAABD1.8050903@pobox.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jul 2005 18:21:05 -0400, Jeff Garzik <jgarzik@pobox.com> wrote:
>
>[speaking to the audience]  I wouldn't mind if someone did a pass 
>through pci_ids.h and removed all the constants that are not being used. 
>  If constants are not being used, it's IMHO more appropriate to store 
>that info in pci.ids.

For: 

linux-2.6.13-rc4:
118 pci_ids-defined_elsewhere-files
475 pci_ids-defined_elsewhere-items
7 pci_ids-duplicate-items
2321 pci_ids-list
725 pci_ids-not_used

linux-2.6.13-rc3-mm3:
119 pci_ids-defined_elsewhere-files
475 pci_ids-defined_elsewhere-items
7 pci_ids-duplicate-items
2325 pci_ids-list
723 pci_ids-not_used

Should the 'defined elsewhere' items be brought into the one 
pci_ids.h file?  Testing will take time.  Patch is ~70kB.

Grant.
