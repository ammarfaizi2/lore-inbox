Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWGRNtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWGRNtm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 09:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWGRNtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 09:49:42 -0400
Received: from cantor2.suse.de ([195.135.220.15]:27058 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932206AbWGRNtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 09:49:41 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] [PATCH 1/2] x86_64: Calgary IOMMU - Multi-Node NULL pointer dereference fix
Date: Tue, 18 Jul 2006 15:50:57 +0200
User-Agent: KMail/1.9.1
Cc: Jon Mason <jdmason@us.ibm.com>, muli@il.ibm.com,
       linux-kernel@vger.kernel.org, konradr@redhat.com
References: <20060717231836.GD5363@us.ibm.com>
In-Reply-To: <20060717231836.GD5363@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607181550.57382.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 July 2006 01:18, Jon Mason wrote:
> Hey Andi,
>
> Calgary hits a NULL pointer dereference when booting in a multi-chassis
> NUMA system.  See Redhat bugzilla number 198498, found by Konrad
> Rzeszutek (konradr@redhat.com).

The patch doesn't apply at all to rc2.

patching file arch/x86_64/kernel/pci-calgary.c
Hunk #5 FAILED at 814.
Hunk #9 FAILED at 892.
Hunk #10 succeeded at 941 (offset 1 line).
Hunk #11 FAILED at 1014.
3 out of 11 hunks FAILED -- rejects in file arch/x86_64/kernel/pci-calgary.c

Also where is 2/2 ? I only see 1/2 

-Andi
