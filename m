Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932400AbVJRDRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVJRDRa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 23:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbVJRDRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 23:17:30 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:17500 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932400AbVJRDRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 23:17:30 -0400
To: Matthew Wilcox <matthew@wil.cx>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] PCI: Add pci_find_next_capability() to deal with >1
 caps of same type
X-Message-Flag: Warning: May contain useful information
References: <52mzl7pwrn.fsf@cisco.com>
	<20051018021033.GA12610@parisc-linux.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Mon, 17 Oct 2005 20:17:15 -0700
In-Reply-To: <20051018021033.GA12610@parisc-linux.org> (Matthew Wilcox's
 message of "Mon, 17 Oct 2005 20:10:33 -0600")
Message-ID: <52ek6jpl8k.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 18 Oct 2005 03:17:17.0402 (UTC) FILETIME=[719233A0:01C5D392]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Matthew> I don't like having this loop duplicated.  How about the
    Matthew> following?

Looks good to me -- I agree with wanting only one loop, but I wasn't
clever enough to see how to avoid the duplication.

Greg, want me to send a new patch including this along with required
the <linux/pci.h> changes again?

Thanks,
  Roland
