Return-Path: <linux-kernel-owner+w=401wt.eu-S1750810AbWLLB7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbWLLB7l (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 20:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWLLB7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 20:59:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:53678 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbWLLB7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 20:59:40 -0500
Subject: Re: [PATCH 4/6] MTHCA driver (infiniband) use new pci interfaces
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <adafyblzyen.fsf@cisco.com>
References: <20061208182241.786324000@osdl.org>
	 <20061208182500.611327000@osdl.org>
	 <1165809339.7260.19.camel@localhost.localdomain>
	 <adafyblzyen.fsf@cisco.com>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 12:59:06 +1100
Message-Id: <1165888746.10055.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Actually even PCIe might not be that easy.  For example with current
> kernels on PowerPC 440SPe (SoC with PCIe), I just get:
> 
>     # lspci
>     00:01.0 InfiniBand: Mellanox Technology: Unknown device 6274 (rev a0)
> 
> ie no host bridge / root complex.

Did somebody used the spec as toilet paper again ? Or is it just the
kernel that isn't properly showing the root complex ? 
 
Ben.


