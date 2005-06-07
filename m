Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVFGC3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVFGC3G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 22:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbVFGC3F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 22:29:05 -0400
Received: from webmail.topspin.com ([12.162.17.3]:26808 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261368AbVFGC2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 22:28:55 -0400
To: Greg KH <gregkh@suse.de>
Cc: tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: pci_enable_msi() for everyone?
X-Message-Flag: Warning: May contain useful information
References: <20050603224551.GA10014@kroah.com> <524qcft3m6.fsf@topspin.com>
	<20050606225826.GB11184@suse.de>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 06 Jun 2005 17:23:17 -0700
In-Reply-To: <20050606225826.GB11184@suse.de> (Greg KH's message of "Mon, 6
 Jun 2005 15:58:26 -0700")
Message-ID: <52acm3j9qi.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 07 Jun 2005 02:28:53.0887 (UTC) FILETIME=[A60038F0:01C56B08]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> Motherboard quirks are one thing.  Broken devices are a
    Greg> totally different thing.  If there are too many of them,
    Greg> then the current situation is acceptable to me.  Does ib
    Greg> have devices that will break with MSI?

Yes, I believe some versions of the firmware for Mellanox HCAs have
problems with MSI.

    Greg> In looking at that, I don't see a way to get rid of the msix
    Greg> stuff.  So that's probably just going to stay the same.

OK -- we'll just have to make sure that the switch from MSI mode to
MSI-X mode is implementated correctly.

 - R.
