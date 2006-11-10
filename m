Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424344AbWKJEHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424344AbWKJEHs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 23:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966080AbWKJEHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 23:07:48 -0500
Received: from gate.crashing.org ([63.228.1.57]:49079 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S966079AbWKJEHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 23:07:48 -0500
Subject: Re: DMA APIs gumble grumble
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       paulus@samba.org, anton@samba.org, greg@kroah.com
In-Reply-To: <20061109.190143.78711283.davem@davemloft.net>
References: <1163120524.4982.61.camel@localhost.localdomain>
	 <20061109.185026.07639529.davem@davemloft.net>
	 <1163127327.4982.79.camel@localhost.localdomain>
	 <20061109.190143.78711283.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 15:07:32 +1100
Message-Id: <1163131652.4982.103.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I wish sparc32 hadn't used alloc_resource() as a poor-man's bitmap
> allocator to keep track of IOMMU mappings.  That's where the
> GFP_KERNEL requirement comes from.
> 
> Just use GFP_KERNEL for now, and someone might find the strength
> to remove this problem some day :-)

Well, Anton has a pile of sparc's in a closet... :-)

Ben.


