Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265840AbTFSQx4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 12:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265839AbTFSQx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 12:53:56 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:2311 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S265841AbTFSQxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 12:53:55 -0400
Date: Thu, 19 Jun 2003 21:04:57 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Matthew Wilcox <willy@fc.hp.com>
Cc: Greg KH <greg@kroah.com>, davidm@hpl.hp.com, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: move pci_domain_nr() inside "#ifdef CONFIG_PCI" bracket
Message-ID: <20030619210457.A24357@jurassic.park.msu.ru>
References: <16112.54572.443092.996206@napali.hpl.hp.com> <20030618215706.GA1919@kroah.com> <20030619150344.GE21906@ldl.fc.hp.com> <20030619161952.GF21906@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030619161952.GF21906@ldl.fc.hp.com>; from willy@fc.hp.com on Thu, Jun 19, 2003 at 10:19:52AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 19, 2003 at 10:19:52AM -0600, Matthew Wilcox wrote:
> A bit subtle, that ... I think this patch is fine, though perhaps it'd
> be best to unconditionally make CONFIG_PCI_DOMAIN true as well?

That's that I did on alpha.

Ivan.
