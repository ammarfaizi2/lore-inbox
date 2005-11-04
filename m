Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbVKDVz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbVKDVz2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 16:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbVKDVz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 16:55:28 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:61160 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750962AbVKDVz1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 16:55:27 -0500
Subject: Re: [PATCH 22/42]: PCI: remove duplicted pci hotplug code
From: John Rose <johnrose@austin.ibm.com>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
       External List <linuxppc64-dev@ozlabs.org>,
       linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20051104005201.GA27016@mail.gnucash.org>
References: <20051103235918.GA25616@mail.gnucash.org>
	 <20051104005201.GA27016@mail.gnucash.org>
Content-Type: text/plain
Message-Id: <1131141266.9574.60.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 04 Nov 2005 15:54:26 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +extern void pcibios_claim_one_bus(struct pci_bus *b);
> +

Might need to export this for module use by the kernel.

Thanks-
John

