Return-Path: <linux-kernel-owner+w=401wt.eu-S1754996AbWL1VRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754996AbWL1VRp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754997AbWL1VRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:17:45 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:51852 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739AbWL1VRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:17:44 -0500
Message-ID: <45943472.9080000@pobox.com>
Date: Thu, 28 Dec 2006 16:17:38 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Ravikiran G Thirumalai <kiran@scalex86.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de, hch@lst.de
Subject: Re: [patch] x86: Fix dev_to_node  for x86 and x86_64
References: <20061228210553.GA3874@localhost.localdomain>
In-Reply-To: <20061228210553.GA3874@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai wrote:
> Hi Andrew,
> dev_to_node() does not work as expected on x86 and x86_64 as pointed out
> earlier here:
> http://lkml.org/lkml/2006/11/7/10
> 
> Following patch fixes it, please apply.  (Note: The fix depends on support
> for PCI domains for x86/x86_64)

Thanks, I'll merge into my misc-2.6.git#pciseg repository, which is 
where Andrew gets his PCI domain support from.

	Jeff



