Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbVCOUNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVCOUNc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 15:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbVCOUNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 15:13:22 -0500
Received: from colo.lackof.org ([198.49.126.79]:64641 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261866AbVCOUKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 15:10:18 -0500
Date: Tue, 15 Mar 2005 13:11:39 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: "Nguyen, Tom L" <tom.l.nguyen@intel.com>
Cc: Greg KH <greg@kroah.com>, long <tlnguyen@snoqualmie.dp.intel.com>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/6] PCI Express Advanced Error Reporting Driver
Message-ID: <20050315201139.GA1756@colo.lackof.org>
References: <C7AB9DA4D0B1F344BF2489FA165E5024080A4C09@orsmsx404.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503120010.j2C0AS4Q020291@snoqualmie.dp.intel.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom,
A co-worker made the following observation (I'm paraphrasing):
	...this proposal does not deal with the Error Reporting ECN.
	For example, they do not show the advisory non-fatal bit in
	the correctable error status register.

I believe he is referring to the "Error Clarifications ECN":

	http://www.pcisig.com/specifications/pciexpress/ECN_-_Error_Clarifications.pdf

Looks like all PCI-E ECNs are available [just not the original docs :^( ]:
	http://www.pcisig.com/specifications/pciexpress/specifications

hth,
grant
