Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVFIWzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVFIWzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 18:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVFIWzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 18:55:23 -0400
Received: from webmail.topspin.com ([12.162.17.3]:23082 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261290AbVFIWzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 18:55:19 -0400
To: "Narendra Sankar" <nsankar@broadcom.com>
Cc: "David S. Miller" <davem@davemloft.net>, gregkh@suse.de, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] Another PCI fix for 2.6.12-rc6
X-Message-Flag: Warning: May contain useful information
References: <20050609222033.GA12580@kroah.com>
	<20050609.153254.74562706.davem@davemloft.net>
	<42A8C73C.6060005@broadcom.com>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 09 Jun 2005 15:55:06 -0700
In-Reply-To: <42A8C73C.6060005@broadcom.com> (Narendra Sankar's message of
 "Thu, 09 Jun 2005 15:48:28 -0700")
Message-ID: <52zmtz16ph.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 09 Jun 2005 22:55:12.0005 (UTC) FILETIME=[4ACD8B50:01C56D46]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Narendra> So it would still be useful to have this patch in, would
    Narendra> it not?

Yes, we should use the PCI quirk to disable MSI when we know a host
bridge does not support MSI.

 - R.
